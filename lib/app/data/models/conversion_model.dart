import 'package:cloud_firestore/cloud_firestore.dart';

class ConversionModel {
  final String id;
  final String userId;
  final String fileName;
  final String originalFormat;
  final String convertedFormat;
  final String downloadUrl;
  final DateTime timestamp;

  ConversionModel({
    required this.id,
    required this.userId,
    required this.fileName,
    required this.originalFormat,
    required this.convertedFormat,
    required this.downloadUrl,
    required this.timestamp,
  });

  factory ConversionModel.fromJson(Map<String, dynamic> json) {
    return ConversionModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      fileName: json['fileName'] as String,
      originalFormat: json['originalFormat'] as String,
      convertedFormat: json['convertedFormat'] as String,
      downloadUrl: json['downloadUrl'] as String,
      timestamp: (json['timestamp'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'fileName': fileName,
      'originalFormat': originalFormat,
      'convertedFormat': convertedFormat,
      'downloadUrl': downloadUrl,
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }
}
