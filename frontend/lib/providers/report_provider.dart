import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/report_service.dart';
import '../models/report_model.dart';

/// Provides the ReportService singleton.
final reportServiceProvider =
    Provider<ReportService>((ref) => ReportService());

/// FutureProvider for the weekly report.
final weeklyReportProvider = FutureProvider<ReportModel>((ref) async {
  final service = ref.read(reportServiceProvider);
  return service.getWeeklyReport();
});

/// FutureProvider for the monthly report.
final monthlyReportProvider = FutureProvider<ReportModel>((ref) async {
  final service = ref.read(reportServiceProvider);
  return service.getMonthlyReport();
});
