import 'package:byteloop/controllers/chatbot_controller.dart';
import 'package:byteloop/model/chat_message_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';


class PreviousChatsScreen extends StatelessWidget {
  const PreviousChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChatbotController>();

    return Scaffold(
      appBar: AppBar(title: const Text("Previous Chats")),
      body: FutureBuilder<List<List<ChatMessage>>>(
        future: controller.getAllSessions(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final sessions = snapshot.data!;
          if (sessions.isEmpty) {
            return const Center(child: Text("No previous chats"));
          }
          return ListView.builder(
            itemCount: sessions.length,
            itemBuilder: (context, index) {
              final session = sessions[index];
              return ListTile(
                leading: const Icon(Iconsax.message_time_copy, color: Colors.purple),
                title: Text(
                  session.isNotEmpty ? session.first.message : "Empty session",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text("${session.length} messages"),
                onTap: () {
                  controller.loadSession(sessions.length - 1 - index); // latest first
                  Get.back(); // go back to main chat
                },
              );
            },
          );
        },
      ),
    );
  }
}
