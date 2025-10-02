import 'dart:convert';

class ChatMessage {
  final String message;
  final bool isUser;

  ChatMessage({required this.message, required this.isUser});

  Map<String, dynamic> toJson() => {
    'message': message,
    'isUser': isUser,
  };

  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
    message: json['message'],
    isUser: json['isUser'],
  );

  static String encodeList(List<ChatMessage> messages) =>
      jsonEncode(messages.map((e) => e.toJson()).toList());

  static List<ChatMessage> decodeList(String messagesString) {
    final List decoded = jsonDecode(messagesString);
    return decoded.map((e) => ChatMessage.fromJson(e)).toList();
  }
}
