import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:get/get.dart';

class StorageService extends GetxService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  final uploadProgress = 0.0.obs;
  final downloadProgress = 0.0.obs;
  final isUploading = false.obs;
  final isDownloading = false.obs;

  // Upload PDF to Firebase Storage
  Future<bool> uploadPdf(File pdfFile, String userId, String fileName) async {
    try {
      isUploading.value = true;
      uploadProgress.value = 0;

      final storagePath = 'users/$userId/pdfs/$fileName';
      final reference = _storage.ref().child(storagePath);

      final uploadTask = reference.putFile(pdfFile);

      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        uploadProgress.value = snapshot.bytesTransferred / snapshot.totalBytes;
      });

      await uploadTask;
      isUploading.value = false;
      return true;
    } catch (e) {
      isUploading.value = false;
      throw 'Upload failed: $e';
    }
  }

  // Download PDF from Firebase Storage
  Future<File?> downloadPdf(String userId, String fileName) async {
    try {
      isDownloading.value = true;
      downloadProgress.value = 0;

      final storagePath = 'users/$userId/pdfs/$fileName';
      final reference = _storage.ref().child(storagePath);

      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/$fileName');

      final downloadTask = reference.writeToFile(file);

      downloadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        downloadProgress.value = snapshot.bytesTransferred / snapshot.totalBytes;
      });

      await downloadTask;
      isDownloading.value = false;
      return file;
    } catch (e) {
      isDownloading.value = false;
      throw 'Download failed: $e';
    }
  }

  // List all PDFs for a user
  Future<List<String>> listUserPdfs(String userId) async {
    try {
      final result = await _storage.ref('users/$userId/pdfs').listAll();
      return result.items.map((ref) => ref.name).toList();
    } catch (e) {
      throw 'Failed to list PDFs: $e';
    }
  }

  // Get PDF metadata (size, last modified, etc.)
  Future<Map<String, dynamic>> getPdfMetadata(String userId, String fileName) async {
    try {
      final storagePath = 'users/$userId/pdfs/$fileName';
      final reference = _storage.ref().child(storagePath);

      final metadata = await reference.getMetadata();

      return {
        'fileName': metadata.name,
        'size': (metadata.size ?? 0) / 1024,
        'modified': metadata.timeCreated,
        'contentType': metadata.contentType,
      };
    } catch (e) {
      throw 'Failed to get metadata: $e';
    }
  }

  // Delete PDF from Firebase Storage
  Future<bool> deletePdf(String userId, String fileName) async {
    try {
      final storagePath = 'users/$userId/pdfs/$fileName';
      await _storage.ref().child(storagePath).delete();
      return true;
    } catch (e) {
      throw 'Delete failed: $e';
    }
  }

  // Get download URL for a PDF
  Future<String> getPdfDownloadUrl(String userId, String fileName) async {
    try {
      final storagePath = 'users/$userId/pdfs/$fileName';
      return await _storage.ref().child(storagePath).getDownloadURL();
    } catch (e) {
      throw 'Failed to get download URL: $e';
    }
  }

  // Share PDF (returns a public download link)
  Future<String> sharePdf(String userId, String fileName) async {
    try {
      return await getPdfDownloadUrl(userId, fileName);
    } catch (e) {
      throw 'Failed to share PDF: $e';
    }
  }

  // Batch upload multiple PDFs
  Future<bool> uploadMultiplePdfs(List<File> pdfFiles, String userId) async {
    try {
      isUploading.value = true;
      uploadProgress.value = 0;

      for (int i = 0; i < pdfFiles.length; i++) {
        final file = pdfFiles[i];
        final fileName = file.path.split('/').last;
        
        await uploadPdf(file, userId, fileName);
        uploadProgress.value = (i + 1) / pdfFiles.length;
      }

      isUploading.value = false;
      return true;
    } catch (e) {
      isUploading.value = false;
      throw 'Batch upload failed: $e';
    }
  }
}
