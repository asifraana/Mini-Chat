import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../chat.dart';
import 'chathistory_controller.dart';

class ChatHistoryTab extends StatefulWidget {
  const ChatHistoryTab({super.key});

  @override
  State<ChatHistoryTab> createState() => _ChatHistoryTabState();
}

class _ChatHistoryTabState extends State<ChatHistoryTab> {

  final ChathistoryController chatshistorycontroller=Get.put(ChathistoryController());

  @override
  void initState() {
    chatshistorycontroller.fetchChats();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (chatshistorycontroller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      return ListView.builder(
      padding: const EdgeInsets.only(right: 16,left: 16, top: 8,bottom: 90),
      itemCount: chatshistorycontroller.chats.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final chat = chatshistorycontroller.chats[index];
        final name = chatshistorycontroller.capitalizeFirst(chat.name);
        final message = chat.message;
        final time = chat.time;
        final unread = chat.unread;

        return ListTile(
          onTap: (){
            Get.offAll(() => ChatScreen(),
              transition: Transition.leftToRight,
              duration: Duration(milliseconds: 500),
            );
          },
          contentPadding: const EdgeInsets.symmetric(vertical: 8),
          leading: CircleAvatar(
            radius: 26,
            backgroundColor: Colors.green,
            child: Text(
              name[0],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          title: Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          subtitle: Text(
            message,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.grey.shade600),
          ),

          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                time,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 6),
              if (unread > 0)
                Container(
                  width: 20,
                  height: 20,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    unread.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );});
  }
}