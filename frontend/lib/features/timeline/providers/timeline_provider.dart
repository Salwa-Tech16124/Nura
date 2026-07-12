import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/timeline_entry.dart';
import '../services/timeline_service.dart';

// ---------------------------------------------------------------------------
// State
// ---------------------------------------------------------------------------
class TimelineState {
  final List<TimelineEntry> entries;
  final bool isLoading;
  final String? error;

  const TimelineState({
    this.entries = const [],
    this.isLoading = false,
    this.error,
  });

  TimelineState copyWith({
    List<TimelineEntry>? entries,
    bool? isLoading,
    String? error,
  }) =>
      TimelineState(
        entries: entries ?? this.entries,
        isLoading: isLoading ?? this.isLoading,
        error: error,
      );
}

// ---------------------------------------------------------------------------
// Notifier
// ---------------------------------------------------------------------------
class TimelineNotifier extends StateNotifier<TimelineState> {
  final TimelineService _service;

  TimelineNotifier(this._service) : super(const TimelineState());

  Future<void> load() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final entries = await _service.getTimeline();
      state = state.copyWith(entries: entries, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> add(TimelineEntry entry) async {
    try {
      final added = await _service.addEntry(entry);
      state = state.copyWith(entries: [added, ...state.entries]);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> delete(int entryId) async {
    try {
      await _service.deleteEntry(entryId);
      state = state.copyWith(
        entries: state.entries.where((e) => e.id != entryId).toList(),
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }
}

// ---------------------------------------------------------------------------
// Provider
// ---------------------------------------------------------------------------
final timelineProvider =
    StateNotifierProvider<TimelineNotifier, TimelineState>((ref) {
  final service = ref.watch(timelineServiceProvider);
  return TimelineNotifier(service);
});
