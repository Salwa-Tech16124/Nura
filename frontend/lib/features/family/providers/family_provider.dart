import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/family_member.dart';
import '../services/family_service.dart';

// ---------------------------------------------------------------------------
// State
// ---------------------------------------------------------------------------
class FamilyState {
  final List<FamilyMember> members;
  final bool isLoading;
  final String? error;

  const FamilyState({
    this.members = const [],
    this.isLoading = false,
    this.error,
  });

  FamilyState copyWith({
    List<FamilyMember>? members,
    bool? isLoading,
    String? error,
  }) =>
      FamilyState(
        members: members ?? this.members,
        isLoading: isLoading ?? this.isLoading,
        error: error,
      );
}

// ---------------------------------------------------------------------------
// Notifier
// ---------------------------------------------------------------------------
class FamilyNotifier extends StateNotifier<FamilyState> {
  final FamilyService _service;

  FamilyNotifier(this._service) : super(const FamilyState());

  Future<void> load() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final members = await _service.getFamilyMembers();
      state = state.copyWith(members: members, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> add(FamilyMember member) async {
    try {
      final added = await _service.addFamilyMember(member);
      state = state.copyWith(members: [...state.members, added]);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> update(int id, FamilyMember member) async {
    try {
      final updated = await _service.updateFamilyMember(id, member);
      state = state.copyWith(
        members: state.members.map((m) => m.id == id ? updated : m).toList(),
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> delete(int id) async {
    try {
      await _service.deleteFamilyMember(id);
      state = state.copyWith(
        members: state.members.where((m) => m.id != id).toList(),
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }
}

// ---------------------------------------------------------------------------
// Provider
// ---------------------------------------------------------------------------
final familyProvider =
    StateNotifierProvider<FamilyNotifier, FamilyState>((ref) {
  final service = ref.watch(familyServiceProvider);
  return FamilyNotifier(service);
});
