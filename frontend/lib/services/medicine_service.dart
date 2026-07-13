import '../core/constants/api_constants.dart';
import '../models/medicine_model.dart';
import 'api_client.dart';

/// Service responsible for retrieving medication schedules and logging adherence.
class MedicineService {
  final _client = ApiClient.instance.dio;

  /// Adds a new medication for the authenticated user.
  Future<MedicineModel> addMedicine(MedicineModel medicine) async {
    final response = await _client.post(
      ApiConstants.medicines,
      data: medicine.toJson(),
    );
    return MedicineModel.fromJson(response.data as Map<String, dynamic>);
  }

  /// Fetches all medications for the authenticated user.
  Future<List<MedicineModel>> getMedicines() async {
    final response = await _client.get(ApiConstants.medicines);
    final list = response.data as List<dynamic>;
    return list
        .map((e) => MedicineModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// Updates an existing medication by [medicineId].
  Future<MedicineModel> updateMedicine(
      int medicineId, MedicineModel medicine) async {
    final response = await _client.put(
      '${ApiConstants.medicines}$medicineId',
      data: medicine.toJson(),
    );
    return MedicineModel.fromJson(response.data as Map<String, dynamic>);
  }

  /// Deletes a medication by [medicineId].
  Future<void> deleteMedicine(int medicineId) async {
    await _client.delete('${ApiConstants.medicines}$medicineId');
  }
}
