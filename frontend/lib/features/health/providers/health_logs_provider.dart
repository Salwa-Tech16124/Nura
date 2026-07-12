import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/health_log.dart';
import '../services/health_service.dart';

// ---------------------------------------------------------------------------
// State
// ---------------------------------------------------------------------------
class HealthLogsState {
  final List<HealthLog> logs;
  final bool isLoading;
  final String? error;

  const HealthLogsState({
    this.logs = const [],
    this.isLoading = false,
    this.error,
  });

  HealthLogsState copyWith({
    List<HealthLog>? logs,
    bool? isLoading,
    String? error,
  }) =>
      HealthLogsState(
        logs: logs ?? this.logs,
        isLoading: isLoading ?? this.isLoading,
        error: error,
      );
}

// ---------------------------------------------------------------------------
// Notifier
// ---------------------------------------------------------------------------
class HealthLogsNotifier extends StateNotifier<HealthLogsState> {
  final HealthService _service;

  HealthLogsNotifier(this._service) : super(const HealthLogsState());

  Future<void> load() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final logs = await _service.getHistory();
      state = state.copyWith(logs: logs, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> add(HealthLog log) async {
    try {
      final added = await _service.addLog(log);
      state = state.copyWith(logs: [added, ...state.logs]);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> update(int logId, HealthLog log) async {
    try {
      final updated = await _service.updateLog(logId, log);
      state = state.copyWith(
        logs: state.logs.map((l) => l.id == logId ? updated : l).toList(),
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> delete(int logId) async {
    try {
      await _service.deleteLog(logId);
      state =
          state.copyWith(logs: state.logs.where((l) => l.id != logId).toList());
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }
}

// ---------------------------------------------------------------------------
// Provider
// ---------------------------------------------------------------------------
final healthLogsProvider =
    StateNotifierProvider<HealthLogsNotifier, HealthLogsState>((ref) {
  final service = ref.watch(healthServiceProvider);
  return HealthLogsNotifier(service);
});
