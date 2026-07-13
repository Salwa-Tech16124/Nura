class OCRReportModel {
  final int id;
  final int userId;
  final String fileUrl;
  final String? rawExtractedText;
  final Map<String, dynamic>? structuredData;
  final DateTime? reportDate;
  final DateTime createdAt;

  OCRReportModel({
    required this.id,
    required this.userId,
    required this.fileUrl,
    this.rawExtractedText,
    this.structuredData,
    this.reportDate,
    required this.createdAt,
  });

  factory OCRReportModel.fromJson(Map<String, dynamic> json) {
    return OCRReportModel(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      fileUrl: json['file_url'] as String,
      rawExtractedText: json['raw_extracted_text'] as String?,
      structuredData: json['structured_data'] as Map<String, dynamic>?,
      reportDate: json['report_date'] != null ? DateTime.parse(json['report_date']) : null,
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'file_url': fileUrl,
      'raw_extracted_text': rawExtractedText,
      'structured_data': structuredData,
      'report_date': reportDate?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
    };
  }
}
