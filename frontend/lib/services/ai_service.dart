import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import '../core/constants/api_constants.dart';
import 'api_client.dart';

/// Service handling conversational inputs for the AI Health/Voice Assistant.
/// NOTE: This communicates with the FastAPI AI proxy endpoints, NOT directly with the AI model.
class AIService {
  final _client = ApiClient.instance.dio;

  /// Sends a question to the AI assistant with full health context from the backend.
  /// Returns the AI answer string.
  Future<String> askAI(String question) async {
    final response = await _client.post(
      ApiConstants.aiAsk,
      data: {'question': question},
    );
    final data = response.data as Map<String, dynamic>;
    return data['answer'] as String? ?? 'I could not generate a response.';
  }

  /// Uploads a medicine photo for AI-powered prescription scanning.
  /// [imageBytes]: raw bytes of the image file.
  /// [filename]: original filename with extension (e.g. 'prescription.jpg').
  Future<String> scanMedicine(List<int> imageBytes, String filename) async {
    // Determine content type from file extension
    final ext = filename.split('.').last.toLowerCase();
    final contentType = _getContentType(ext);

    final formData = FormData.fromMap({
      'photo': MultipartFile.fromBytes(
        imageBytes,
        filename: filename,
        contentType: contentType,
      ),
    });

    final response = await _client.post(
      ApiConstants.aiMedicineScan,
      data: formData,
      options: Options(contentType: 'multipart/form-data'),
    );

    final data = response.data as Map<String, dynamic>;
    return data['analysis'] as String? ?? 'Could not analyze the image.';
  }

  MediaType _getContentType(String ext) {
    switch (ext) {
      case 'png':
        return MediaType('image', 'png');
      case 'jpg':
      case 'jpeg':
        return MediaType('image', 'jpeg');
      case 'gif':
        return MediaType('image', 'gif');
      case 'webp':
        return MediaType('image', 'webp');
      default:
        return MediaType('image', 'jpeg');
    }
  }
}
