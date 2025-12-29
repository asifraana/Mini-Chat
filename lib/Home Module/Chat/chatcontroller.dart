import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../PopAlert.dart';
import 'messenger Model.dart';

class ChatController extends GetxController{

  final TextEditingController controller = TextEditingController();
  final ScrollController scrollController = ScrollController();
  var id,name,status;

  final RxList<MessageModel> messages = <MessageModel>[].obs;

  void sendMessage(BuildContext context) async {
    final text = controller.text.trim();
    if (text.isEmpty) return;

    messages.add(
      MessageModel(
        text: text,
        isSender: true,
        time: TimeOfDay.now().format(context),
      ),
    );

    controller.clear();
    scrollToBottom();
    await fetchReceiverMessage(context);
  }



  Future<void> fetchReceiverMessage(BuildContext context) async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/comments'),
    );
print(response.body);
print(response.statusCode);
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      data.shuffle();

      messages.add(
        MessageModel(
          text: data.first['body'],
          isSender: false,
          time: TimeOfDay.now().format(context),
        ),
      );
      scrollToBottom();
    }else if(response.statusCode == 403){
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => PopAlert(subtext: 'Api url not working'),
      );

    }else{
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => PopAlert(subtext: 'Something went Wrong!,\n Try again later'),
      );
    }
  }

  void scrollToBottom() {
    if (!scrollController.hasClients) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.animateTo(
        500.0,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 300),
      );
    });

  }

  @override
  void dispose() {
    controller.dispose();
    scrollController.dispose();
    super.dispose();
  }
}