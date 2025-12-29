import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../PopAlert.dart';
import 'model.dart';

class UserlistController extends GetxController{
  var users = <UserModel>[].obs;
  var isLoading = true.obs;


  Future<List<UserModel>> fetchUsers(context) async {
    try {
      final response = await http.get(
          Uri.parse('https://dummyjson.com/users?limit=20'),
          headers: {"Content-Type": "application/json"});
      print(response.body);
      print(response.statusCode);

      if (response.statusCode == 200) {
        isLoading.value = false;
        final data = jsonDecode(response.body);
        users.value =
            (data['users'] as List).map((e) => UserModel.fromJson(e)).toList();
        return users.value;
      } else {
        isLoading.value = true;
        throw Exception('Failed to load chats');
      }
    }on SocketException {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => PopAlert(subtext: 'No Internet connection'),
      );

      throw Exception('No Internet connection');
}
}

  void showAddUserDialog(context) {
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color(0xffFFFFFF),
          title: const Text("Add User"),
          content: TextField(
            controller: controller,

            decoration: InputDecoration(

              hintText: 'Enter a Name',
              hintStyle: const TextStyle(
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                color: Color(0xff999999),
              ),


            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (controller.text.trim().isNotEmpty) {
                  users.add(
                    UserModel(
                      id: DateTime.now().millisecondsSinceEpoch,
                      name: capitalizeFirst(controller.text.trim()),
                      online: false,
                      status: "Online",
                    ),
                  );

                  Navigator.pop(context);
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (_) => PopAlert(subtext: 'User Added Successfully'),
                  );

                }else{
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (_) => PopAlert(subtext: 'Something went Wrong!,\n Try again later'),
                  );
print('Something Error!, Try again later');
                }
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }
  String capitalizeFirst(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }
}