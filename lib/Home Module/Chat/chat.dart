import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_chat/BottomNavigation.dart';

import '../dictionary_word.dart';
import 'chatcontroller.dart';
import 'messenger Model.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatController chatcontroller= Get.put(ChatController());


  @override
  void initState() {
    super.initState();
    final data = Get.arguments as Map<String, dynamic>;
    chatcontroller.id=data['id'];
    chatcontroller.name=data['name'];
    chatcontroller.status=data['status'];


  }
  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          Get.offAll(
                () => Bottomnavigation(bottomvalue: 0,),

            transition: Transition.rightToLeft,
            duration: Duration(milliseconds: 500),
          );
        },
        child:Scaffold(
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
                  chatcontroller.name[0],
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
                    chatcontroller.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    chatcontroller.status,
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
            child: Obx(() {
              return ListView.builder(
                controller: chatcontroller.scrollController,
                padding: const EdgeInsets.all(12),
                itemCount: chatcontroller.messages.length,
                itemBuilder: (context, index) {
                  final msg = chatcontroller.messages[index];
                  return ChatBubble(
                    message: msg,
                    name: chatcontroller.name,
                  );
                },
              );
            }),
          ),

          _inputBar(),
        ],
      ),


    ));
  }
  Widget _inputBar() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: chatcontroller.controller,
                onSubmitted: (value){
                  chatcontroller.sendMessage(context);
                },
                decoration: const InputDecoration(
                  hintText: "Type message...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
                icon: const Icon(Icons.send),
                onPressed:(){chatcontroller.sendMessage(context);}
            ),
          ],
        ),
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final MessageModel message;
  String?  name;

  ChatBubble({super.key, required this.message,this.name});

  @override
  Widget build(BuildContext context) {
    final isSender = message.isSender;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment:
        isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isSender) _avatar(name![0],isSender),
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
                    children: message.text.split(' ').map((word) {
                      return GestureDetector(
                        onLongPress: () {
                          showMeaningBottomSheet(
                            context,
                            word.replaceAll(RegExp(r'[^\w]'), '').toLowerCase(),
                          );
                        },
                        child: Text(
                          "$word ",
                          textAlign: TextAlign.justify,

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
                  message.time,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          if (isSender) _avatar("Y",isSender),
        ],
      ),
    );
  }

  Widget _avatar(String letter,isSender) {
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














