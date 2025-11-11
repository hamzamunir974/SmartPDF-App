import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as path;
import 'package:share_plus/share_plus.dart';
import '../../../services/document_conversion_service.dart';

class ConversionController extends GetxController {
  final DocumentConversionService _conversionService = DocumentConversionService();
  
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;
  final RxDouble progress = 0.0.obs;

  Future<void> convertFile(String fromFormat, String toFormat) async {
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
        convertedFile = await _conversionService.convertPdfToWord(file, fileName);
      } else if (fromFormat.toLowerCase() == 'docx' && toFormat.toLowerCase() == 'pdf') {
        convertedFile = await _conversionService.convertWordToPdf(file, fileName);
      } else {
        throw 'Unsupported conversion format';
      }

      // Show success message
      Get.snackbar(
        'Success',
        'File converted successfully',
        snackPosition: SnackPosition.BOTTOM,
      );

      // Share the converted file
      await shareFile(convertedFile, fileName);

    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
      progress.value = 0;
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
