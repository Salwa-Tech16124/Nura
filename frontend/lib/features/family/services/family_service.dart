import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/api_client.dart';
import '../models/family_member.dart';

final familyServiceProvider = Provider<FamilyService>((ref) {
  final client = ref.watch(apiClientProvider);
  return FamilyService(client);
});

class FamilyService {
  final ApiClient _client;
  FamilyService(this._client);

  Future<List<FamilyMember>> getFamilyMembers() async {
    final response = await _client.get<List<dynamic>>('/family');
    final data = response.data ?? [];
    return data
        .map((e) => FamilyMember.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<FamilyMember> addFamilyMember(FamilyMember member) async {
    final response = await _client
        .post<Map<String, dynamic>>('/family', data: member.toJson());
    return FamilyMember.fromJson(response.data!);
  }

  Future<FamilyMember> updateFamilyMember(int memberId, FamilyMember member) async {
    final response = await _client.put<Map<String, dynamic>>(
        '/family/$memberId',
        data: member.toJson());
    return FamilyMember.fromJson(response.data!);
  }

  Future<void> deleteFamilyMember(int memberId) async {
    await _client.delete('/family/$memberId');
  }
}
