import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/medicine.dart';
import '../services/medicine_service.dart';

// ---------------------------------------------------------------------------
// State
// ---------------------------------------------------------------------------
class MedicineState {
  final List<Medicine> medicines;
  final bool isLoading;
  final String? error;

  const MedicineState({
    this.medicines = const [],
    this.isLoading = false,
    this.error,
  });

  MedicineState copyWith({
    List<Medicine>? medicines,
    bool? isLoading,
    String? error,
  }) =>
      MedicineState(
        medicines: medicines ?? this.medicines,
        isLoading: isLoading ?? this.isLoading,
        error: error,
      );
}

// ---------------------------------------------------------------------------
// Notifier
// ---------------------------------------------------------------------------
class MedicineNotifier extends StateNotifier<MedicineState> {
  final MedicineService _service;

  MedicineNotifier(this._service) : super(const MedicineState());

  Future<void> load() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final medicines = await _service.getMedicines();
      state = state.copyWith(medicines: medicines, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> add(Medicine medicine) async {
    try {
      final added = await _service.addMedicine(medicine);
      state = state.copyWith(medicines: [...state.medicines, added]);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> update(int id, Medicine medicine) async {
    try {
      final updated = await _service.updateMedicine(id, medicine);
      state = state.copyWith(
        medicines: state.medicines
            .map((m) => m.id == id ? updated : m)
            .toList(),
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> delete(int id) async {
    try {
      await _service.deleteMedicine(id);
      state = state.copyWith(
        medicines: state.medicines.where((m) => m.id != id).toList(),
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }
}

// ---------------------------------------------------------------------------
// Provider
// ---------------------------------------------------------------------------
final medicineProvider =
    StateNotifierProvider<MedicineNotifier, MedicineState>((ref) {
  final service = ref.watch(medicineServiceProvider);
  return MedicineNotifier(service);
});
