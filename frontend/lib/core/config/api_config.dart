class ApiConfig {
  ApiConfig._();

  /// The base URL for the FastAPI backend server.
  static const String baseUrl = 'https://ai-care-copilot-backend-1.onrender.com';

  /// Timeout duration for connecting to the server.
  static const Duration connectTimeout = Duration(seconds: 15);

  /// Timeout duration for receiving data from the server.
  static const Duration receiveTimeout = Duration(seconds: 15);

  /// Timeout duration for sending data to the server.
  static const Duration sendTimeout = Duration(seconds: 15);

  /// Default headers applied to all HTTP requests.
  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
}
