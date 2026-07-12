import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/api_client.dart';
import '../models/health_log.dart';

final healthServiceProvider = Provider<HealthService>((ref) {
  final client = ref.watch(apiClientProvider);
  return HealthService(client);
});

class HealthService {
  final ApiClient _client;
  HealthService(this._client);

  Future<List<HealthLog>> getHistory() async {
    final response = await _client.get<List<dynamic>>('/health-history');
    final data = response.data ?? [];
    return data
        .map((e) => HealthLog.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<HealthLog> addLog(HealthLog log) async {
    final response =
        await _client.post<Map<String, dynamic>>('/health-log', data: log.toJson());
    return HealthLog.fromJson(response.data!);
  }

  Future<HealthLog> updateLog(int logId, HealthLog log) async {
    final response = await _client.put<Map<String, dynamic>>(
        '/health-log/$logId',
        data: log.toJson());
    return HealthLog.fromJson(response.data!);
  }

  Future<void> deleteLog(int logId) async {
    await _client.delete('/health-log/$logId');
  }
}
