import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/network/api_client.dart';

final aiServiceProvider = Provider<AIService>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return AIService(apiClient);
});

class AIService {
  final ApiClient _apiClient;

  AIService(this._apiClient);

  /// POST /ai/chat
  Future<String> chat(String message) async {
    final response = await _apiClient.post(
      '/ai/chat',
      data: {'message': message},
    );
    final data = response.data;
    if (data is Map) {
      return (data['response'] ??
              data['reply'] ??
              data['message'] ??
              data['text'] ??
              'No response received.')
          .toString();
    }
    return data.toString();
  }

  /// POST /ocr/upload
  Future<String> uploadOcr(List<int> bytes, String filename,
      {required void Function(double) onProgress}) async {
    final formData = FormData.fromMap({
      'file': MultipartFile.fromBytes(bytes, filename: filename),
    });

    final response = await _apiClient.post(
      '/ocr/upload',
      data: formData,
      onSendProgress: (sent, total) {
        if (total > 0) {
          onProgress(sent / total);
        }
      },
    );

    final data = response.data;
    if (data is Map) {
      final reportId = data['report_id'] ?? data['id'] ?? data['reportId'];
      if (reportId != null) {
        return reportId.toString();
      }
      throw Exception('Could not find report ID in OCR response.');
    }
    throw Exception('Invalid response format for OCR upload.');
  }

  /// GET /ocr/{report_id}
  Future<Map<String, dynamic>> getOcrReport(String reportId) async {
    final response = await _apiClient.get('/ocr/$reportId');
    final data = response.data;
    if (data is Map) {
      return Map<String, dynamic>.from(data);
    }
    throw Exception('Invalid response format for OCR report.');
  }

  /// POST /ai/prescription
  Future<Map<String, dynamic>> analyzePrescription(String ocrText) async {
    final response = await _apiClient.post(
      '/ai/prescription',
      data: {'ocr_text': ocrText},
    );
    final data = response.data;
    if (data is Map) {
      return Map<String, dynamic>.from(data);
    }
    throw Exception('Invalid response format for prescription analysis.');
  }

  /// POST /ai/summary
  Future<String> getSummary() async {
    final response = await _apiClient.post(
      '/ai/summary',
      data: {},
    );
    final data = response.data;
    if (data is Map) {
      return (data['summary'] ??
              data['response'] ??
              data['message'] ??
              data['text'] ??
              'No summary generated.')
          .toString();
    }
    return data.toString();
  }

  /// POST /ai/risk
  Future<List<String>> getRiskAnalysis() async {
    final response = await _apiClient.post(
      '/ai/risk',
      data: {},
    );
    final data = response.data;
    if (data is Map) {
      final risks = data['risks'] ?? data['risk_analysis'] ?? data['response'] ?? data['text'];
      if (risks is List) {
        return risks.map((e) => e.toString()).toList();
      }
      if (risks is String) {
        // Parse list if returned as string
        return risks
            .split('\n')
            .map((e) => e.trim().replaceAll(RegExp(r'^[-*•\d\.\s]+'), ''))
            .where((e) => e.isNotEmpty)
            .toList();
      }
    }
    if (data is List) {
      return data.map((e) => e.toString()).toList();
    }
    return [];
  }
}
