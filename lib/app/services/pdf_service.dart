import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class PdfService {
  // Load PDF file from path
  Future<PdfDocument> loadPdfFile(String filePath) async {
    try {
      final file = File(filePath);
      final bytes = await file.readAsBytes();
      return PdfDocument(inputBytes: bytes);
    } catch (e) {
      throw 'Error loading PDF: $e';
    }
  }

  // Load PDF from bytes
  PdfDocument loadPdfFromBytes(List<int> bytes) {
    try {
      return PdfDocument(inputBytes: bytes);
    } catch (e) {
      throw 'Error loading PDF from bytes: $e';
    }
  }

  // Get page count
  int getPageCount(PdfDocument document) {
    return document.pages.count;
  }

  // Extract text from all pages
  Future<String> extractAllText(PdfDocument document) async {
    try {
      final extractor = PdfTextExtractor(document);
      final StringBuffer text = StringBuffer();

      for (int i = 0; i < document.pages.count; i++) {
        if (i > 0) text.write('\n\n--- PAGE ${i + 1} ---\n\n');
        final pageText = extractor.extractText(startPageIndex: i, endPageIndex: i);
        text.write(pageText);
      }

      return text.toString();
    } catch (e) {
      throw 'Error extracting text: $e';
    }
  }

  // Extract text from specific page
  String extractPageText(PdfDocument document, int pageIndex) {
    try {
      final extractor = PdfTextExtractor(document);
      return extractor.extractText(startPageIndex: pageIndex, endPageIndex: pageIndex);
    } catch (e) {
      throw 'Error extracting page text: $e';
    }
  }

  // Search for text in PDF
  Future<List<int>> searchText(PdfDocument document, String searchTerm) async {
    try {
      final List<int> pagesWithText = [];
      final extractor = PdfTextExtractor(document);

      for (int i = 0; i < document.pages.count; i++) {
        final pageText = extractor.extractText(startPageIndex: i, endPageIndex: i);
        if (pageText.toLowerCase().contains(searchTerm.toLowerCase())) {
          pagesWithText.add(i);
        }
      }

      return pagesWithText;
    } catch (e) {
      throw 'Error searching PDF: $e';
    }
  }

  // Add watermark to PDF
  Future<File> addWatermark(File pdfFile, String watermarkText) async {
    try {
      final bytes = await pdfFile.readAsBytes();
      final document = PdfDocument(inputBytes: bytes);

      for (int i = 0; i < document.pages.count; i++) {
        final page = document.pages[i];
        final font = PdfStandardFont(PdfFontFamily.helvetica, 48);

        page.graphics.drawString(
          watermarkText,
          font,
          brush: PdfBrushes.lightGray,
          bounds: Rect.fromLTWH(
            50,
            page.getClientSize().height / 2 - 50,
            page.getClientSize().width - 100,
            100,
          ),
          format: PdfStringFormat(
            alignment: PdfTextAlignment.center,
            lineAlignment: PdfVerticalAlignment.middle,
          ),
        );
      }

      final tempDir = await getTemporaryDirectory();
      final outputFile = File('${tempDir.path}/watermarked_${DateTime.now().millisecondsSinceEpoch}.pdf');
      final outputBytes = await document.save();
      await outputFile.writeAsBytes(outputBytes);
      document.dispose();

      return outputFile;
    } catch (e) {
      throw 'Error adding watermark: $e';
    }
  }

  // Merge multiple PDFs
  Future<File> mergePdfs(List<File> pdfFiles, String outputFileName) async {
    try {
      final document = PdfDocument();

      for (final pdfFile in pdfFiles) {
        final bytes = await pdfFile.readAsBytes();
        final sourceDocument = PdfDocument(inputBytes: bytes);

        for (int i = 0; i < sourceDocument.pages.count; i++) {
          document.pages.add();
          final page = document.pages[document.pages.count - 1];
          final sourcePage = sourceDocument.pages[i];

          // Copy content from source page
          final template = sourcePage.createTemplate();
          page.graphics.drawPdfTemplate(
            template,
            Offset.zero,
            Size(page.getClientSize().width, page.getClientSize().height),
          );
        }

        sourceDocument.dispose();
      }

      final tempDir = await getTemporaryDirectory();
      final outputFile = File('${tempDir.path}/$outputFileName.pdf');
      final bytes = await document.save();
      await outputFile.writeAsBytes(bytes);
      document.dispose();

      return outputFile;
    } catch (e) {
      throw 'Error merging PDFs: $e';
    }
  }

  // Compress PDF
  Future<File> compressPdf(File pdfFile) async {
    try {
      final bytes = await pdfFile.readAsBytes();
      final document = PdfDocument(inputBytes: bytes);
      document.compressionLevel = PdfCompressionLevel.best;

      final tempDir = await getTemporaryDirectory();
      final outputFile = File('${tempDir.path}/compressed_${DateTime.now().millisecondsSinceEpoch}.pdf');
      final outputBytes = await document.save();
      await outputFile.writeAsBytes(outputBytes);
      document.dispose();

      return outputFile;
    } catch (e) {
      throw 'Error compressing PDF: $e';
    }
  }

  // Get PDF file size in KB
  Future<double> getFileSizeKb(File file) async {
    try {
      final bytes = await file.readAsBytes();
      return bytes.length / 1024;
    } catch (e) {
      throw 'Error getting file size: $e';
    }
  }

  // Get PDF metadata
  Future<Map<String, dynamic>> getPdfMetadata(File pdfFile) async {
    try {
      final bytes = await pdfFile.readAsBytes();
      final document = PdfDocument(inputBytes: bytes);

      final sizeKb = bytes.length / 1024;
      final pageCount = document.pages.count;

      document.dispose();

      return {
        'pageCount': pageCount,
        'fileSize': sizeKb.toStringAsFixed(2),
        'fileName': pdfFile.path.split('/').last,
      };
    } catch (e) {
      throw 'Error getting metadata: $e';
    }
  }
}
