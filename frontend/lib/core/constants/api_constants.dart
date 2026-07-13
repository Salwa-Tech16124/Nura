/// Centralized API configuration for the Nura backend.
/// Change [baseUrl] here to point to any backend (ngrok, production, localhost).
class ApiConstants {
  // ─── Base URL ─────────────────────────────────────────────────────────────
  static const String baseUrl =
      'https://ceroplastic-evaluative-emeline.ngrok-free.dev';

  // ─── Auth ─────────────────────────────────────────────────────────────────
  static const String register = '/auth/register';
  static const String login = '/auth/login';
  static const String profile = '/auth/profile';

  // ─── Health ───────────────────────────────────────────────────────────────
  static const String healthLog = '/health-log';
  static const String healthHistory = '/health-history';

  // ─── Medicine ─────────────────────────────────────────────────────────────
  static const String medicines = '/medicine/';

  // ─── Reports ──────────────────────────────────────────────────────────────
  static const String weeklyReport = '/weekly-report';
  static const String monthlyReport = '/monthly-report';

  // ─── AI ───────────────────────────────────────────────────────────────────
  static const String aiAsk = '/ai/ask';
  static const String aiMedicineScan = '/ai/medicine-scan';

  // ─── Timeline ─────────────────────────────────────────────────────────────
  static const String timeline = '/timeline';

  // ─── Token Storage Key ────────────────────────────────────────────────────
  static const String tokenKey = 'nura_auth_token';
  static const String userKey = 'nura_user_data';
}
