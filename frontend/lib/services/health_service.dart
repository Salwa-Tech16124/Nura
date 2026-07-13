import '../core/constants/api_constants.dart';
import '../models/health_log_model.dart';
import 'api_client.dart';

/// Service responsible for fetching and updating user health vitals and daily check-ins.
class HealthService {
  final _client = ApiClient.instance.dio;

  /// Logs a new health vitals entry. Returns the created log.
  Future<HealthLogModel> logHealth(HealthLogModel data) async {
    final response = await _client.post(
      ApiConstants.healthLog,
      data: data.toJson(),
    );
    return HealthLogModel.fromJson(response.data as Map<String, dynamic>);
  }

  /// Fetches full health log history for the authenticated user.
  Future<List<HealthLogModel>> getHealthHistory() async {
    final response = await _client.get(ApiConstants.healthHistory);
    final list = response.data as List<dynamic>;
    return list
        .map((e) => HealthLogModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// Updates an existing health log entry by [logId].
  Future<HealthLogModel> updateHealthLog(int logId, HealthLogModel data) async {
    final response = await _client.put(
      '${ApiConstants.healthLog}/$logId',
      data: data.toJson(),
    );
    return HealthLogModel.fromJson(response.data as Map<String, dynamic>);
  }

  /// Deletes a health log entry by [logId].
  Future<void> deleteHealthLog(int logId) async {
    await _client.delete('${ApiConstants.healthLog}/$logId');
  }
}
