import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/health_service.dart';
import '../models/health_log_model.dart';

/// Provides the HealthService singleton.
final healthServiceProvider = Provider<HealthService>((ref) => HealthService());

/// State notifier for the health log list.
class HealthHistoryNotifier extends StateNotifier<AsyncValue<List<HealthLogModel>>> {
  final HealthService _service;

  HealthHistoryNotifier(this._service) : super(const AsyncValue.loading()) {
    load();
  }

  Future<void> load() async {
    try {
      state = const AsyncValue.loading();
      final logs = await _service.getHealthHistory();
      state = AsyncValue.data(logs);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addLog(HealthLogModel log) async {
    try {
      final created = await _service.logHealth(log);
      final current = state.valueOrNull ?? [];
      state = AsyncValue.data([created, ...current]);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteLog(int logId) async {
    try {
      await _service.deleteHealthLog(logId);
      final current = state.valueOrNull ?? [];
      state = AsyncValue.data(
        current.where((l) => l.id != logId).toList(),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final healthHistoryProvider = StateNotifierProvider<HealthHistoryNotifier,
    AsyncValue<List<HealthLogModel>>>((ref) {
  final service = ref.read(healthServiceProvider);
  return HealthHistoryNotifier(service);
});
