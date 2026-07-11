import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../screens/reports/report_dashboard_screen.dart';
import '../../screens/reports/weekly_report_screen.dart';
import '../../screens/reports/monthly_report_screen.dart';
import '../../screens/reports/ai_health_summary_screen.dart';
import '../../screens/reports/doctor_summary_screen.dart';
import '../../screens/reports/share_report_screen.dart';
import '../../screens/profile/health_profile_screen.dart';
import '../../screens/profile/family_caregivers_screen.dart';
import '../../screens/profile/medical_records_screen.dart';
import '../../screens/profile/settings_preferences_screen.dart';
import '../../screens/profile/privacy_security_screen.dart';
import '../../screens/profile/about_nura_screen.dart';
import '../../screens/home/home_dashboard_screen.dart';
import '../../screens/health/health_dashboard_screen.dart';
import '../../screens/health/health_trends_screen.dart';
import '../../screens/health/settings_screen.dart';
import '../../screens/medication/medication_dashboard_screen.dart';
import '../../screens/medication/medication_notification_screen.dart';
import '../../screens/medication/confirm_medication_screen.dart';
import '../../screens/medication/medication_history_screen.dart';
import '../../screens/medication/family_alert_screen.dart';
import '../../screens/voice/voice_standby_screen.dart';
import '../../screens/voice/medicine_query_screen.dart';
import '../../screens/voice/hydration_reminder_screen.dart';
import '../../screens/voice/language_selection_screen.dart';
import '../../screens/voice/call_initiated_screen.dart';
import '../../screens/sos/sos_initial_map_screen.dart';
import '../../screens/sos/sos_activation_screen.dart';
import '../../screens/sos/sos_sending_location_screen.dart';
import '../../screens/sos/sos_family_alerted_screen.dart';
import '../../screens/sos/sos_active_tracking_screen.dart';
import '../../screens/wellness/health_wellness_screen.dart';
import '../../screens/profile/profile_screen.dart';
import '../../screens/splash/splash_screen.dart';
import '../../screens/onboarding/onboarding_screen.dart';
import '../../screens/auth/login_screen.dart';
import '../../screens/auth/register_screen.dart';
import '../../widgets/layout/main_scaffold.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorHome = GlobalKey<NavigatorState>(debugLabel: 'shellHome');
final GlobalKey<NavigatorState> _shellNavigatorHealth = GlobalKey<NavigatorState>(debugLabel: 'shellHealth');
final GlobalKey<NavigatorState> _shellNavigatorMeds = GlobalKey<NavigatorState>(debugLabel: 'shellMeds');
final GlobalKey<NavigatorState> _shellNavigatorWellness = GlobalKey<NavigatorState>(debugLabel: 'shellWellness');
final GlobalKey<NavigatorState> _shellNavigatorProfile = GlobalKey<NavigatorState>(debugLabel: 'shellProfile');

class AppRouter {
  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/splash',
    routes: [
      GoRoute(path: '/splash', builder: (context, state) => const SplashScreen()),
      GoRoute(path: '/onboarding', builder: (context, state) => const OnboardingScreen()),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(path: '/register', builder: (context, state) => const RegisterScreen()),
      GoRoute(path: '/sos-map', builder: (context, state) => const SosInitialMapScreen()),
      GoRoute(path: '/sos-activation', builder: (context, state) => const SosActivationScreen()),
      GoRoute(path: '/sos-sending-location', builder: (context, state) => const SosSendingLocationScreen()),
      GoRoute(path: '/sos-family-alerted', builder: (context, state) => const SosFamilyAlertedScreen()),
      GoRoute(path: '/sos-active-tracking', builder: (context, state) => const SosActiveTrackingScreen()),
      GoRoute(path: '/reports', builder: (context, state) => const ReportDashboardScreen()),
      GoRoute(path: '/weekly-report', builder: (context, state) => const WeeklyReportScreen()),
      GoRoute(path: '/monthly-report', builder: (context, state) => const MonthlyReportScreen()),
      GoRoute(path: '/ai-summary', builder: (context, state) => const AIHealthSummaryScreen()),
      GoRoute(path: '/doctor-summary', builder: (context, state) => const DoctorSummaryScreen()),
      GoRoute(path: '/share-report', builder: (context, state) => const ShareReportScreen()),
      GoRoute(path: '/health-profile', builder: (context, state) => const HealthProfileScreen()),
      GoRoute(path: '/family-caregivers', builder: (context, state) => const FamilyCaregiversScreen()),
      GoRoute(path: '/medical-records', builder: (context, state) => const MedicalRecordsScreen()),
      GoRoute(path: '/settings-preferences', builder: (context, state) => const SettingsPreferencesScreen()),
      GoRoute(path: '/privacy-security', builder: (context, state) => const PrivacySecurityScreen()),
      GoRoute(path: '/about-nura', builder: (context, state) => const AboutNuraScreen()),
      GoRoute(path: '/health-trends', builder: (context, state) => const HealthTrendsScreen()),
      GoRoute(path: '/settings', builder: (context, state) => const SettingsScreen()),
      GoRoute(path: '/meds-notification', builder: (context, state) => const MedicationNotificationScreen()),
      GoRoute(path: '/meds-confirm', builder: (context, state) => const ConfirmMedicationScreen()),
      GoRoute(path: '/meds-history', builder: (context, state) => const MedicationHistoryScreen()),
      GoRoute(path: '/family-alert', builder: (context, state) => const FamilyAlertScreen()),
      GoRoute(path: '/voice', builder: (context, state) => const VoiceStandbyScreen()),
      GoRoute(path: '/voice-medicine-query', builder: (context, state) => const MedicineQueryScreen()),
      GoRoute(path: '/voice-hydration', builder: (context, state) => const HydrationReminderScreen()),
      GoRoute(path: '/voice-language', builder: (context, state) => const LanguageSelectionScreen()),
      GoRoute(path: '/voice-call', builder: (context, state) => const CallInitiatedScreen()),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainScaffold(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _shellNavigatorHome,
            routes: [
              GoRoute(path: '/home', builder: (context, state) => const HomeDashboardScreen()),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorHealth,
            routes: [
              GoRoute(path: '/health', builder: (context, state) => const HealthDashboardScreen()),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorMeds,
            routes: [
              GoRoute(path: '/meds', builder: (context, state) => const MedicationDashboardScreen()),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorWellness,
            routes: [
              GoRoute(path: '/wellness', builder: (context, state) => const HealthWellnessScreen()),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorProfile,
            routes: [
              GoRoute(path: '/profile', builder: (context, state) => const ProfileScreen()),
            ],
          ),
        ],
      ),
    ],
  );
}
