import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/chat_message_model.dart';
import '../services/gemini_service.dart';

class ChatbotController extends GetxController {
  var messages = <ChatMessage>[].obs;
  var isTyping = false.obs;

  final GeminiService geminiService;

  ChatbotController({required this.geminiService});

  @override
  void onInit() {
    super.onInit();
    loadLatestSession();
  }

  // Send message and save to current session
  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    messages.add(ChatMessage(message: text, isUser: true));
    isTyping.value = true;

    final response = await geminiService.generateResponse(text);

    messages.add(ChatMessage(message: response, isUser: false));
    isTyping.value = false;

    await saveCurrentSession();
  }

  // Save current session
  Future<void> saveCurrentSession() async {
    final prefs = await SharedPreferences.getInstance();
    // Load all sessions
    List<String> sessions = prefs.getStringList('chat_sessions') ?? [];
    // Save this session as JSON
    sessions.add(ChatMessage.encodeList(messages));
    // Keep only last 10 sessions
    if (sessions.length > 10) sessions = sessions.sublist(sessions.length - 10);
    await prefs.setStringList('chat_sessions', sessions);
  }

  // Load the latest session
  Future<void> loadLatestSession() async {
    final prefs = await SharedPreferences.getInstance();
    final sessions = prefs.getStringList('chat_sessions');
    if (sessions != null && sessions.isNotEmpty) {
      messages.assignAll(ChatMessage.decodeList(sessions.last));
    }
  }

  // Load a specific session
  Future<void> loadSession(int index) async {
    final prefs = await SharedPreferences.getInstance();
    final sessions = prefs.getStringList('chat_sessions');
    if (sessions != null && index >= 0 && index < sessions.length) {
      messages.assignAll(ChatMessage.decodeList(sessions[index]));
    }
  }

  // Get all sessions
  Future<List<List<ChatMessage>>> getAllSessions() async {
    final prefs = await SharedPreferences.getInstance();
    final sessions = prefs.getStringList('chat_sessions') ?? [];
    return sessions
        .map((s) => ChatMessage.decodeList(s))
        .toList()
        .reversed
        .toList(); // latest first
  }

  // Clear current chat
  Future<void> clearCurrentChat() async {
    messages.clear();
  }
}
