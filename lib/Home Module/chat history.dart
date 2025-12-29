import 'package:flutter/material.dart';

class ChatHistoryTab extends StatefulWidget {
  const ChatHistoryTab({super.key});

  @override
  State<ChatHistoryTab> createState() => _ChatHistoryTabState();
}

class _ChatHistoryTabState extends State<ChatHistoryTab> {
  @override
  Widget build(BuildContext context) {
    final chats = [
      {
        "name": "Alice Johnson",
        "message": "See you tomorrow!",
        "time": "2 min ago",
        "unread": 2
      },
      {
        "name": "Bob Smith",
        "message": "Thanks for the help",
        "time": "10 min ago",
        "unread": 0
      },
      {
        "name": "Carol Williams",
        "message": "Let's catch up soon",
        "time": "1 hour ago",
        "unread": 1
      },
      {
        "name": "David Brown",
        "message": "Got it, thanks!",
        "time": "3 hours ago",
        "unread": 0
      },
      {
        "name": "Emma Davis",
        "message": "Perfect, see you then",
        "time": "5 hours ago",
        "unread": 0
      },
      {
        "name": "Frank Miller",
        "message": "That sounds great",
        "time": "Yesterday",
        "unread": 0
      },
      {
        "name": "Grace Wilson",
        "message": "I'll check it out",
        "time": "Yesterday",
        "unread": 0
      },
      {
        "name": "Henry Moore",
        "message": "Okay",
        "time": "2 days ago",
        "unread": 0
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: chats.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final chat = chats[index];
        final name = chat["name"] as String;
        final message = chat["message"] as String;
        final time = chat["time"] as String;
        final unread = chat["unread"] as int;

        return ListTile(
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
    );
  }
}