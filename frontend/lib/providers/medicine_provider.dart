import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/medicine_service.dart';
import '../models/medicine_model.dart';

/// Provides the MedicineService singleton.
final medicineServiceProvider =
    Provider<MedicineService>((ref) => MedicineService());

/// State notifier for the medicines list.
class MedicinesNotifier
    extends StateNotifier<AsyncValue<List<MedicineModel>>> {
  final MedicineService _service;

  MedicinesNotifier(this._service) : super(const AsyncValue.loading()) {
    load();
  }

  Future<void> load() async {
    try {
      state = const AsyncValue.loading();
      final medicines = await _service.getMedicines();
      state = AsyncValue.data(medicines);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addMedicine(MedicineModel medicine) async {
    try {
      final created = await _service.addMedicine(medicine);
      final current = state.valueOrNull ?? [];
      state = AsyncValue.data([...current, created]);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateMedicine(int id, MedicineModel medicine) async {
    try {
      final updated = await _service.updateMedicine(id, medicine);
      final current = state.valueOrNull ?? [];
      state = AsyncValue.data(
        current.map((m) => m.id == id ? updated : m).toList(),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteMedicine(int id) async {
    try {
      await _service.deleteMedicine(id);
      final current = state.valueOrNull ?? [];
      state = AsyncValue.data(
        current.where((m) => m.id != id).toList(),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final medicinesProvider = StateNotifierProvider<MedicinesNotifier,
    AsyncValue<List<MedicineModel>>>((ref) {
  final service = ref.read(medicineServiceProvider);
  return MedicinesNotifier(service);
});
