import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'chathistory_model.dart';


class ChathistoryController {
  var chats = <ChatModel>[].obs;
  var isLoading = true.obs;

   Future<List<ChatModel>> fetchChats() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/comments?_limit=15'),
    );

    print(response.body);
    if (response.statusCode == 200) {
      isLoading.value=false;
      final List data = jsonDecode(response.body);
      chats.value= data.map((e) => ChatModel.fromJson(e)).toList();
      return chats.value;
    } else {
      throw Exception('Failed to load chats');
    }
  }

  String capitalizeFirst(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }


}
