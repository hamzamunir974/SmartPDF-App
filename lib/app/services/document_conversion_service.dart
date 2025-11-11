import 'dart:io';
import 'dart:ui';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class DocumentConversionService {
  // Convert PDF to Word (saves as RTF format) with enhanced text extraction
  Future<File> convertPdfToWord(File pdfFile, String fileName) async {
    try {
      // Load PDF document
      final PdfDocument pdfDocument = PdfDocument(inputBytes: await pdfFile.readAsBytes());
      
      // Create text extractor with improved settings
      final PdfTextExtractor extractor = PdfTextExtractor(pdfDocument);
      final StringBuffer text = StringBuffer();
      
      // Process each page with enhanced text extraction
      for (int i = 0; i < pdfDocument.pages.count; i++) {
        // Add page break if not first page
        if (i > 0) text.write('\n\n');
        
        // Extract text with bounds to preserve layout better
        final textLines = extractor.extractTextLines(startPageIndex: i);
        for (var line in textLines) {
          text.write(line.text);
          text.write('\n');
        }
      }
      
      // Save as RTF document with enhanced formatting
      final tempDir = await getTemporaryDirectory();
      final outputFile = File('${tempDir.path}/$fileName.rtf');
      
      // Convert to RTF format with better styling
      final StringBuffer rtf = StringBuffer();
      rtf.write(r'{\rtf1\ansi\ansicpg1252\deff0');
      rtf.write(r'{\fonttbl{\f0\fswiss Arial;}{\f1\fnil Times New Roman;}}');
      rtf.write(r'{\colortbl;\red0\green0\blue0;}');
      rtf.write('\n');
      rtf.write(r'\margl1440\margr1440\margt1440\margb1440'); // 1-inch margins
      rtf.write('\n');
      rtf.write(r'\plain\f0\fs24\cf1 '); // Default font style
      
      try {
        // Format text for RTF
        final String formattedText = text.toString()
          .replaceAll('\\', r'\\')
          .replaceAll('{', r'\{')
          .replaceAll('}', r'\}')
          .replaceAll('\n', r'\par ');
        
        rtf.write(formattedText);
        rtf.write('}');
        
        // Save with error handling
        try {
          await outputFile.writeAsString(rtf.toString());
        } catch (e) {
          throw 'Failed to save RTF file: $e';
        }
        
        return outputFile;
      } finally {
        // Ensure document is disposed even if an error occurs
        pdfDocument.dispose();
      }
    } catch (e) {
      throw 'Error converting PDF to Word: $e';
    }
  }

  // Convert Word (or any text) to PDF with enhanced formatting
  Future<File> convertWordToPdf(File wordFile, String fileName) async {
    try {
      // Create a new PDF document with better compression
      final PdfDocument pdfDocument = PdfDocument();
      pdfDocument.compressionLevel = PdfCompressionLevel.best;
      
      // Add page
      final PdfPage page = pdfDocument.pages.add();
      
      // Create font for text
      final PdfStandardFont font = PdfStandardFont(PdfFontFamily.helvetica, 12);
      
      // Load document content as text
      final String text = await wordFile.readAsString();
      
      // Set page margins (in points, 1 inch = 72 points)
      final bounds = Rect.fromLTWH(
        72, // 1 inch left margin
        72, // 1 inch top margin
        page.getClientSize().width - 144, // 1 inch margins on both sides
        page.getClientSize().height - 144, // 1 inch margins on top and bottom
      );
      
            try {
        // Draw text with proper formatting
        page.graphics.drawString(
          text,
          font,
          brush: PdfSolidBrush(PdfColor(0, 0, 0)),
          bounds: bounds,
          format: PdfStringFormat(
            alignment: PdfTextAlignment.justify,
            lineSpacing: 1.15,
            paragraphIndent: 36, // 0.5 inch paragraph indent
            wordWrap: PdfWordWrapType.word,
          ),
        );
        
        // Save the PDF document
        final tempDir = await getTemporaryDirectory();
        final outputFile = File('${tempDir.path}/$fileName.pdf');
        
        // Save with error handling
        try {
          final bytes = await pdfDocument.save();
          await outputFile.writeAsBytes(bytes);
        } catch (e) {
          throw 'Failed to save PDF file: $e';
        }
        
        return outputFile;
      } finally {
        // Ensure document is disposed even if an error occurs
        pdfDocument.dispose();
      }
    } catch (e) {
      throw 'Error converting Word to PDF: $e';
    }
  }
}
