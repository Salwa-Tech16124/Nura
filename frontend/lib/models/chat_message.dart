/// Represents a single message in the AI chat conversation.
enum MessageSender { user, ai }

class ChatMessage {
  final String id;
  final String text;
  final MessageSender sender;
  final DateTime timestamp;

  const ChatMessage({
    required this.id,
    required this.text,
    required this.sender,
    required this.timestamp,
  });

  bool get isUser => sender == MessageSender.user;
  bool get isAI => sender == MessageSender.ai;
}
