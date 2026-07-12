import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/api_client.dart';
import '../models/medicine.dart';

final medicineServiceProvider = Provider<MedicineService>((ref) {
  final client = ref.watch(apiClientProvider);
  return MedicineService(client);
});

class MedicineService {
  final ApiClient _client;
  MedicineService(this._client);

  Future<List<Medicine>> getMedicines() async {
    final response = await _client.get<List<dynamic>>('/medicine');
    final data = response.data ?? [];
    return data
        .map((e) => Medicine.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<Medicine> addMedicine(Medicine medicine) async {
    final response = await _client
        .post<Map<String, dynamic>>('/medicine', data: medicine.toJson());
    return Medicine.fromJson(response.data!);
  }

  Future<Medicine> updateMedicine(int medicineId, Medicine medicine) async {
    final response = await _client.put<Map<String, dynamic>>(
        '/medicine/$medicineId',
        data: medicine.toJson());
    return Medicine.fromJson(response.data!);
  }

  Future<void> deleteMedicine(int medicineId) async {
    await _client.delete('/medicine/$medicineId');
  }
}
