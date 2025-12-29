import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_chat/BottomNavigation.dart';

import 'dictionary_word.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final TextEditingController _controller = TextEditingController();

  final List<Map<String, dynamic>> messages = [
    {
      "msg": "Hey! How are you doing?",
      "time": "10:30 AM",
      "isSender": false,
    },
    {
      "msg": "I'm doing great, thanks! How about you?",
      "time": "10:31 AM",
      "isSender": true,
    },
    {
      "msg": "Hey! How are you doing?",
      "time": "10:30 AM",
      "isSender": false,
    },
    {
      "msg": "I'm doing great, thanks! How about you?",
      "time": "10:31 AM",
      "isSender": true,
    },
    {
      "msg": "Hey! How are you doing?",
      "time": "10:30 AM",
      "isSender": false,
    },
    {
      "msg": "I'm doing great, thanks! How about you?",
      "time": "10:31 AM",
      "isSender": true,
    },
    {
      "msg": "Hey! How are you doing?",
      "time": "10:30 AM",
      "isSender": false,
    },
    {
      "msg": "I'm doing great, thanks! How about you?",
      "time": "10:31 AM",
      "isSender": true,
    },
    {
      "msg": "Hey! How are you doing?",
      "time": "10:30 AM",
      "isSender": false,
    },
    {
      "msg": "I'm doing great, thanks! How about you?",
      "time": "10:31 AM",
      "isSender": true,
    },
    {
      "msg": "Hey! How are you doing?",
      "time": "10:30 AM",
      "isSender": false,
    },
    {
      "msg": "I'm doing great, thanks! How about you?",
      "time": "10:31 AM",
      "isSender": true,
    },
    {
      "msg": "Hey! How are you doing?",
      "time": "10:30 AM",
      "isSender": false,
    },
    {
      "msg": "I'm doing great, thanks! How about you?",
      "time": "10:31 AM",
      "isSender": true,
    },
  ];

  void sendMessage() {
    if (_controller.text.trim().isEmpty) return;

    setState(() {
      messages.add({
        "msg": _controller.text.trim(),
        "time": TimeOfDay.now().format(context),
        "isSender": true,
      });
    });

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        surfaceTintColor: Colors.white,
        title: Container(
          child: Row(
            children: [
              SizedBox(width: 4,),
              GestureDetector(
                onTap: () {
                  Get.off(
                        () => Bottomnavigation(bottomvalue: 0),
                    transition: Transition.rightToLeft,
                    duration: Duration(milliseconds: 500),
                  );
                },
                child: Icon(Icons.arrow_back, size: 26),
              ),
              SizedBox(width: 14,),
              Container(
                alignment: Alignment.center,
                width: 50,
                height: 50,

                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    gradient: LinearGradient(
                        begin: AlignmentGeometry.topLeft,
                        end: AlignmentGeometry.bottomRight,
                        colors: [
                          Color(0xff6474FF),
                          Color(0xff7070FF),
                          Color(0xff9A59FF),
                          Color(0xff9959FF),
                        ])

                ),
                child: Text(
                  'A',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Asif',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'online',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(15),
          child: Divider(height: 1, thickness: 1, color: Color(0xFFE0E0E0)),
        ),
      ),
      body: Column(
        children: [

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 12),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final m = messages[index];
                return ChatBubble(
                  message: m["msg"],
                  time: m["time"],
                  isSender: m["isSender"],
                );
              },
            ),
          ),


          SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => sendMessage(),
                      decoration: InputDecoration(
                        hintText: "Type a message...",
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.blue,
                    child: IconButton(
                      icon: const Icon(Icons.send, color: Colors.white),
                      onPressed: sendMessage,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }






}

class ChatBubble extends StatelessWidget {
  final String message;
  final String time;
  final bool isSender;

  const ChatBubble({
    super.key,
    required this.message,
    required this.time,
    required this.isSender,
  });

  @override
  Widget build(BuildContext context) {
    final words = message.split(" ");

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
        isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [

          if (!isSender) _avatar("A"),

          Flexible(
            child: Column(
              crossAxisAlignment: isSender
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isSender ? Colors.blue : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Wrap(
                    children: words.map((word) {
                      return GestureDetector(
                        onLongPress: () {
                          showMeaningBottomSheet(
                            context,
                            word.replaceAll(RegExp(r'[^\w]'), '').toLowerCase(),
                          );
                        },
                        child: Text(
                          "$word ",
                          style: TextStyle(
                            color:
                            isSender ? Colors.white : Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          if (isSender) _avatar("Y"),
        ],
      ),
    );
  }

  Widget _avatar(String letter) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child:   Container(
        alignment: Alignment.center,
        width: 32,
        height: 32,

        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            gradient: LinearGradient(
                begin: AlignmentGeometry.topLeft,
                end: AlignmentGeometry.bottomRight,
                colors:isSender?[
                  Color(0xffC04AED),
                  Color(0xffCC49D9),
                  Color(0xffE541B4),
                ]: [
                  Color(0xff6474FF),
                  Color(0xff7070FF),
                  Color(0xff9A59FF),
                  Color(0xff9959FF),
                ])

        ),
        child: Text(
          letter,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
  void showMeaningBottomSheet(BuildContext context, String word) async {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return FutureBuilder<String?>(
          future: DictionaryService.getMeaning(word),
          builder: (context, snapshot) {
            return Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(16),
              child: snapshot.connectionState == ConnectionState.waiting
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    word,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    snapshot.data ?? "Meaning not found",
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        );
      },
    );
  }
}




// GET https://dummyjson.com/comments?limit=10
// GET https://jsonplaceholder.typicode.com/comments?postId=1
// GET https://www.boredapi.com/api/activity
// GET https://api.quotable.io/random
