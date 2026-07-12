import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/api_client.dart';
import '../models/timeline_entry.dart';

final timelineServiceProvider = Provider<TimelineService>((ref) {
  final client = ref.watch(apiClientProvider);
  return TimelineService(client);
});

class TimelineService {
  final ApiClient _client;
  TimelineService(this._client);

  Future<List<TimelineEntry>> getTimeline() async {
    final response = await _client.get<List<dynamic>>('/timeline');
    final data = response.data ?? [];
    return data
        .map((e) => TimelineEntry.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<TimelineEntry> addEntry(TimelineEntry entry) async {
    final response =
        await _client.post<Map<String, dynamic>>('/timeline', data: entry.toJson());
    return TimelineEntry.fromJson(response.data!);
  }

  Future<void> deleteEntry(int entryId) async {
    await _client.delete('/timeline/$entryId');
  }
}
