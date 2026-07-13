import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'api_client.dart';
import 'auth_service.dart';
import 'medicine_service.dart';
import 'health_service.dart';
import 'report_service.dart';
import 'ai_service.dart';
import '../models/user_model.dart';
import '../models/medicine_model.dart';
import '../models/health_log_model.dart';
import '../models/report_model.dart';
import '../models/chat_message.dart';
import '../models/timeline_model.dart';

// -------------------------------------------------------------
// Service Providers
// -------------------------------------------------------------

final apiClientProvider = Provider<ApiClient>((ref) => ApiClient());

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(ref.watch(apiClientProvider));
});

final medicineServiceProvider = Provider<MedicineService>((ref) {
  return MedicineService(ref.watch(apiClientProvider));
});

final healthServiceProvider = Provider<HealthService>((ref) {
  return HealthService(ref.watch(apiClientProvider));
});

final reportServiceProvider = Provider<ReportService>((ref) {
  return ReportService(ref.watch(apiClientProvider));
});

final aiServiceProvider = Provider<AIService>((ref) {
  return AIService(ref.watch(apiClientProvider));
});

// -------------------------------------------------------------
// State Providers
// -------------------------------------------------------------

// Authentication State
final authStateProvider = StateNotifierProvider<AuthStateNotifier, UserModel?>((ref) {
  return AuthStateNotifier(ref.watch(authServiceProvider));
});

class AuthStateNotifier extends StateNotifier<UserModel?> {
  final AuthService _authService;

  AuthStateNotifier(this._authService) : super(null) {
    checkAuth();
  }

  Future<void> checkAuth() async {
    final authed = await _authService.isAuthenticated();
    if (authed) {
      try {
        final profile = await _authService.getProfile();
        state = profile;
      } catch (e) {
        state = null;
      }
    } else {
      state = null;
    }
  }

  Future<void> login(String email, String password) async {
    final user = await _authService.login(email, password);
    state = user;
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String phoneNumber,
    int? age,
    String? gender,
    String? emergencyContact,
  }) async {
    await _authService.register(
      name: name,
      email: email,
      password: password,
      phoneNumber: phoneNumber,
      age: age,
      gender: gender,
      emergencyContact: emergencyContact,
    );
  }

  Future<void> logout() async {
    await _authService.logout();
    state = null;
  }
}

// Medicines State (Notifier)
final medicinesProvider = StateNotifierProvider<MedicinesNotifier, AsyncValue<List<MedicineModel>>>((ref) {
  return MedicinesNotifier(ref.watch(medicineServiceProvider));
});

class MedicinesNotifier extends StateNotifier<AsyncValue<List<MedicineModel>>> {
  final MedicineService _medicineService;

  MedicinesNotifier(this._medicineService) : super(const AsyncValue.loading()) {
    fetchMedicines();
  }

  Future<void> fetchMedicines() async {
    state = const AsyncValue.loading();
    try {
      final list = await _medicineService.getMedicines();
      state = AsyncValue.data(list);
    } catch (err, stack) {
      state = AsyncValue.error(err, stack);
    }
  }

  Future<void> addMedicine({
    required String medicineName,
    String? dosage,
    String? frequency,
    String? time,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      await _medicineService.addMedicine(
        medicineName: medicineName,
        dosage: dosage,
        frequency: frequency,
        time: time,
        startDate: startDate,
        endDate: endDate,
      );
      await fetchMedicines();
    } catch (err, stack) {
      state = AsyncValue.error(err, stack);
      rethrow;
    }
  }

  Future<void> updateMedicine({
    required int medicineId,
    required String medicineName,
    String? dosage,
    String? frequency,
    String? time,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      await _medicineService.updateMedicine(
        medicineId: medicineId,
        medicineName: medicineName,
        dosage: dosage,
        frequency: frequency,
        time: time,
        startDate: startDate,
        endDate: endDate,
      );
      await fetchMedicines();
    } catch (err, stack) {
      state = AsyncValue.error(err, stack);
      rethrow;
    }
  }

  Future<void> deleteMedicine(int id) async {
    try {
      await _medicineService.deleteMedicine(id);
      await fetchMedicines();
    } catch (err, stack) {
      state = AsyncValue.error(err, stack);
      rethrow;
    }
  }
}

// Health Vitals History State (Notifier)
final healthHistoryProvider = StateNotifierProvider<HealthHistoryNotifier, AsyncValue<List<HealthLogModel>>>((ref) {
  return HealthHistoryNotifier(ref.watch(healthServiceProvider));
});

class HealthHistoryNotifier extends StateNotifier<AsyncValue<List<HealthLogModel>>> {
  final HealthService _healthService;

  HealthHistoryNotifier(this._healthService) : super(const AsyncValue.loading()) {
    fetchHealthHistory();
  }

  Future<void> fetchHealthHistory() async {
    state = const AsyncValue.loading();
    try {
      final list = await _healthService.getHealthHistory();
      state = AsyncValue.data(list);
    } catch (err, stack) {
      state = AsyncValue.error(err, stack);
    }
  }

  Future<void> addLog({
    String? bloodPressure,
    double? sugarLevel,
    double? weight,
    double? sleepHours,
    String? mood,
    String? symptoms,
    int? heartRate,
    double? caloriesBurned,
    int? steps,
  }) async {
    try {
      await _healthService.addHealthLog(
        bloodPressure: bloodPressure,
        sugarLevel: sugarLevel,
        weight: weight,
        sleepHours: sleepHours,
        mood: mood,
        symptoms: symptoms,
        heartRate: heartRate,
        caloriesBurned: caloriesBurned,
        steps: steps,
      );
      await fetchHealthHistory();
    } catch (err, stack) {
      state = AsyncValue.error(err, stack);
      rethrow;
    }
  }

  Future<void> deleteLog(int logId) async {
    try {
      await _healthService.deleteHealthLog(logId);
      await fetchHealthHistory();
    } catch (err, stack) {
      state = AsyncValue.error(err, stack);
      rethrow;
    }
  }
}

// Reports Providers
final weeklyReportProvider = FutureProvider.autoDispose<ReportSummaryModel>((ref) {
  return ref.watch(reportServiceProvider).getWeeklyReport();
});

final monthlyReportProvider = FutureProvider.autoDispose<ReportSummaryModel>((ref) {
  return ref.watch(reportServiceProvider).getMonthlyReport();
});

// AI Chatbot Conversation State
class ChatState {
  final List<ChatMessage> messages;
  final bool isLoading;

  ChatState({required this.messages, this.isLoading = false});

  ChatState copyWith({List<ChatMessage>? messages, bool? isLoading}) {
    return ChatState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

final aiChatProvider = StateNotifierProvider.autoDispose<AIChatNotifier, ChatState>((ref) {
  return AIChatNotifier(ref.watch(aiServiceProvider));
});

class AIChatNotifier extends StateNotifier<ChatState> {
  final AIService _aiService;

  AIChatNotifier(this._aiService) : super(ChatState(messages: []));

  Future<void> askQuestion(String question) async {
    final userMsg = ChatMessage(
      id: DateTime.now().toString(),
      text: question,
      sender: MessageSender.user,
      timestamp: DateTime.now(),
    );

    state = state.copyWith(
      messages: [...state.messages, userMsg],
      isLoading: true,
    );

    try {
      final reply = await _aiService.askAI(question);
      final aiMsg = ChatMessage(
        id: DateTime.now().toString(),
        text: reply,
        sender: MessageSender.ai,
        timestamp: DateTime.now(),
      );

      state = state.copyWith(
        messages: [...state.messages, aiMsg],
        isLoading: false,
      );
    } catch (e) {
      final errorMsg = ChatMessage(
        id: DateTime.now().toString(),
        text: 'Error getting response: ${e.toString().replaceAll('Exception: ', '')}',
        sender: MessageSender.ai,
        timestamp: DateTime.now(),
      );

      state = state.copyWith(
        messages: [...state.messages, errorMsg],
        isLoading: false,
      );
    }
  }

  void clearChat() {
    state = ChatState(messages: []);
  }
}

// Timeline State
final timelineProvider = StateNotifierProvider.autoDispose<TimelineNotifier, AsyncValue<List<TimelineEntryModel>>>((ref) {
  return TimelineNotifier(ref.watch(apiClientProvider));
});

class TimelineNotifier extends StateNotifier<AsyncValue<List<TimelineEntryModel>>> {
  final ApiClient _apiClient;

  TimelineNotifier(this._apiClient) : super(const AsyncValue.loading()) {
    fetchTimeline();
  }

  Future<void> fetchTimeline() async {
    state = const AsyncValue.loading();
    try {
      final response = await _apiClient.dio.get('/timeline');
      final List<dynamic> data = response.data;
      final list = data.map((json) => TimelineEntryModel.fromJson(json)).toList();
      state = AsyncValue.data(list);
    } catch (err, stack) {
      state = AsyncValue.error(err, stack);
    }
  }

  Future<void> addManualNote(String title, String content) async {
    try {
      await _apiClient.dio.post('/timeline', data: {
        'title': title,
        'content': content,
      });
      await fetchTimeline();
    } catch (err, stack) {
      state = AsyncValue.error(err, stack);
      rethrow;
    }
  }

  Future<void> deleteTimelineEntry(int entryId) async {
    try {
      await _apiClient.dio.delete('/timeline/$entryId');
      await fetchTimeline();
    } catch (err, stack) {
      state = AsyncValue.error(err, stack);
      rethrow;
    }
  }
}
