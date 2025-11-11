import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as path;
import 'package:share_plus/share_plus.dart';
import '../../../services/document_conversion_service.dart';
import '../../auth/controllers/auth_controller.dart';
import '../../../data/models/conversion_model.dart';

class HomeController extends GetxController {
  final AuthController _authController = Get.find<AuthController>();
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;
  final RxDouble progress = 0.0.obs;
  final RxList<ConversionModel> conversions = <ConversionModel>[].obs;
  final RxInt currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _loadConversions();
  }

  Future<void> _loadConversions() async {
    try {
      final userId = _authController.user.value?.uid;
      if (userId == null) return;

      _firestore
          .collection('conversions')
          .where('userId', isEqualTo: userId)
          .orderBy('timestamp', descending: true)
          .snapshots()
          .listen((snapshot) {
        conversions.value = snapshot.docs
            .map((doc) => ConversionModel.fromJson({
                  ...doc.data(),
                  'id': doc.id,
                }))
            .toList();
      });
    } catch (e) {
      error.value = 'Error loading conversion history';
    }
  }

  Future<void> pickAndConvertFile(String fromFormat, String toFormat) async {
    try {
      isLoading.value = true;
      error.value = '';
      progress.value = 0;

      // Validate formats
      if (!['pdf', 'docx'].contains(fromFormat.toLowerCase()) ||
          !['pdf', 'docx'].contains(toFormat.toLowerCase())) {
        throw 'Unsupported file format. Only PDF and DOCX are supported.';
      }

      // Pick file
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: [fromFormat.toLowerCase()],
        lockParentWindow: true,
      );

      if (result == null || result.files.isEmpty) {
        isLoading.value = false;
        return;
      }

      final filePath = result.files.single.path;
      if (filePath == null) {
        throw 'Selected file path is invalid';
      }

      File file = File(filePath);
      if (!await file.exists()) {
        throw 'Selected file does not exist';
      }

      String fileName = path.basenameWithoutExtension(file.path);
      
      // Convert file
      File convertedFile;
      if (fromFormat.toLowerCase() == 'pdf' && toFormat.toLowerCase() == 'docx') {
        convertedFile = await _convertPdfToWord(file, fileName);
      } else if (fromFormat.toLowerCase() == 'docx' && toFormat.toLowerCase() == 'pdf') {
        convertedFile = await _convertWordToPdf(file, fileName);
      } else {
        throw 'Unsupported conversion format';
      }

      // Upload converted file
      String downloadUrl = await _uploadFile(convertedFile, toFormat);

      // Save conversion record
      await _saveConversion(
        fileName: fileName,
        originalFormat: fromFormat,
        convertedFormat: toFormat,
        downloadUrl: downloadUrl,
      );

      Get.snackbar(
        'Success',
        'File converted successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
      progress.value = 0;
    }
  }

  final DocumentConversionService _conversionService = DocumentConversionService();

  Future<File> _convertPdfToWord(File file, String fileName) async {
    return await _conversionService.convertPdfToWord(file, fileName);
  }

  Future<File> _convertWordToPdf(File file, String fileName) async {
    return await _conversionService.convertWordToPdf(file, fileName);
  }

  Future<String> _uploadFile(File file, String format) async {
    try {
      final userId = _authController.user.value?.uid;
      if (userId == null) throw 'User not authenticated';

      // Validate file exists and is readable
      if (!await file.exists()) {
        throw 'File does not exist';
      }

      try {
        await file.readAsBytes();
      } catch (e) {
        throw 'File is not readable: $e';
      }

      final fileName = path.basename(file.path);
      final destination = 'conversions/$userId/$fileName';

      final ref = _storage.ref().child(destination);
      final uploadTask = ref.putFile(
        file,
        SettableMetadata(
          contentType: format.toLowerCase() == 'pdf' 
              ? 'application/pdf'
              : 'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
        ),
      );

      // Listen to upload progress
      uploadTask.snapshotEvents.listen(
        (TaskSnapshot snapshot) {
          progress.value = snapshot.bytesTransferred / snapshot.totalBytes;
        },
        onError: (error) {
          throw 'Upload interrupted: $error';
        },
      );

      try {
        final snapshot = await uploadTask;
        final downloadUrl = await snapshot.ref.getDownloadURL();
        return downloadUrl;
      } catch (e) {
        throw 'Failed to complete upload: $e';
      }
    } catch (e) {
      throw 'Error uploading file: $e';
    }
  }

  Future<void> _saveConversion({
    required String fileName,
    required String originalFormat,
    required String convertedFormat,
    required String downloadUrl,
  }) async {
    try {
      final userId = _authController.user.value?.uid;
      if (userId == null) throw 'User not authenticated';

      await _firestore.collection('conversions').add({
        'userId': userId,
        'fileName': fileName,
        'originalFormat': originalFormat,
        'convertedFormat': convertedFormat,
        'downloadUrl': downloadUrl,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw 'Error saving conversion record: $e';
    }
  }

  Future<void> deleteConversion(String conversionId) async {
    try {
      await _firestore.collection('conversions').doc(conversionId).delete();
      Get.snackbar(
        'Success',
        'Conversion record deleted',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      error.value = 'Error deleting conversion record';
    }
  }

  Future<void> shareFile(File file, String fileName) async {
    try {
      final result = await Share.shareXFiles(
        [XFile(file.path)],
        text: 'Sharing converted file: $fileName',
      );

      if (result.status == ShareResultStatus.success) {
        Get.snackbar(
          'Success',
          'File shared successfully',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      error.value = 'Error sharing file: $e';
    }
  }
}
