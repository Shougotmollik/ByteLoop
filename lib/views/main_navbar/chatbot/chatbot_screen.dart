import 'package:byteloop/constant/app_colors.dart';
import 'package:byteloop/controllers/chatbot_controller.dart';
import 'package:byteloop/services/gemini_service.dart';
import 'package:byteloop/utils/env.dart';
import 'package:byteloop/views/main_navbar/chatbot/previous_chat_screen.dart';
import 'package:byteloop/views/main_navbar/chatbot/widgets/code_block_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ChatbotScreen extends StatelessWidget {
  const ChatbotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      ChatbotController(geminiService: GeminiService(apiKey: Env.geminiKey)),
    );

    final TextEditingController textController = TextEditingController();
    final ScrollController scrollController = ScrollController();

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        title: const Text(
          "Byte Box",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.message_tick_copy),
            onPressed: () {
              Get.to(() => const PreviousChatsScreen());
            },
          ),
          IconButton(
            onPressed: () => controller.clearCurrentChat(),
            icon: const Icon(Icons.phonelink_erase, color: Colors.white),
          ),
        ],
      ),
      body: Column(
        children: [
          // Chat messages
          Expanded(
            child: Obx(() {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (scrollController.hasClients) {
                  scrollController.animateTo(
                    scrollController.position.maxScrollExtent,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  );
                }
              });

              return ListView.builder(
                controller: scrollController,
                padding: const EdgeInsets.all(12),
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  final msg = controller.messages[index];

                  return Align(
                    alignment: msg.isUser
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.9,
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: msg.isUser
                            ? Colors.purple.shade600
                            : const Color(0xFF1F1F1F),
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(12),
                          topRight: const Radius.circular(12),
                          bottomLeft: msg.isUser
                              ? const Radius.circular(12)
                              : const Radius.circular(0),
                          bottomRight: msg.isUser
                              ? const Radius.circular(0)
                              : const Radius.circular(12),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(122),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: MarkdownBody(
                        data: msg.message,
                        selectable: false, // Prevent crash
                        builders: {'code': CodeBlockBuilder()},
                        styleSheet: MarkdownStyleSheet(
                          p: TextStyle(
                            color: msg.isUser ? Colors.white : Colors.white70,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ),

          // Typing indicator
          Obx(
            () => controller.isTyping.value
                ? const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.purple,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          "Bot is typing...",
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          ),

          // Input field
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textController,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                    cursorColor: Colors.tealAccent,
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      hintStyle: const TextStyle(color: Colors.white38),
                      filled: true,
                      fillColor: const Color(0xFF2C2C2C),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    final text = textController.text;
                    if (text.trim().isEmpty) return;
                    textController.clear();
                    controller.sendMessage(text);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.purple.shade700,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(Icons.send, color: Colors.white60, size: 24),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
