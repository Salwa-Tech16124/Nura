import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/ai_service.dart';
import '../models/chat_message.dart';

/// Provides the AIService singleton.
final aiServiceProvider = Provider<AIService>((ref) => AIService());

/// State notifier for chat messages between user and NURA AI.
class ChatNotifier extends StateNotifier<List<ChatMessage>> {
  final AIService _aiService;
  bool _isLoading = false;

  ChatNotifier(this._aiService) : super([]);

  bool get isLoading => _isLoading;

  /// Sends a user message and fetches AI response, updating the list reactively.
  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    // Add user message
    final userMsg = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: text.trim(),
      sender: MessageSender.user,
      timestamp: DateTime.now(),
    );
    state = [...state, userMsg];

    _isLoading = true;

    try {
      final answer = await _aiService.askAI(text.trim());
      final aiMsg = ChatMessage(
        id: '${DateTime.now().millisecondsSinceEpoch}_ai',
        text: answer,
        sender: MessageSender.ai,
        timestamp: DateTime.now(),
      );
      state = [...state, aiMsg];
    } catch (e) {
      final errorMsg = ChatMessage(
        id: '${DateTime.now().millisecondsSinceEpoch}_err',
        text:
            'Sorry, I could not connect to the AI service right now. Please try again.',
        sender: MessageSender.ai,
        timestamp: DateTime.now(),
      );
      state = [...state, errorMsg];
    } finally {
      _isLoading = false;
    }
  }

  /// Clears all messages (new conversation).
  void clearChat() => state = [];
}

final chatProvider =
    StateNotifierProvider<ChatNotifier, List<ChatMessage>>((ref) {
  final service = ref.read(aiServiceProvider);
  return ChatNotifier(service);
});

/// True while AI is processing a response.
final chatLoadingProvider = Provider<bool>((ref) {
  return ref.watch(chatProvider.notifier).isLoading;
});
