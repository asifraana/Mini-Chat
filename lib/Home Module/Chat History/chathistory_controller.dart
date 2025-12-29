import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../PopAlert.dart';
import 'chathistory_model.dart';


class ChathistoryController {
  var chats = <ChatModel>[].obs;
  var isLoading = true.obs;

   Future<List<ChatModel>> fetchChats(context) async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/comments?_limit=15'),headers: {"Content-Type": "application/json",
      "Accept": "application/json",
      "User-Agent": "Mozilla/5.0",
    }
    );

    print(response.body);
    if (response.statusCode == 200) {
      isLoading.value=false;
      final List data = jsonDecode(response.body);
      chats.value= data.map((e) => ChatModel.fromJson(e)).toList();
      return chats.value;
    } else {
      isLoading.value=true;
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => PopAlert(subtext: 'Something went Wrong!,\n Try again later'),
      );
      throw Exception('Failed to load chats');

    }
  }

  String capitalizeFirst(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }


}
