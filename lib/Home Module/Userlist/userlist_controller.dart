import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'model.dart';

class UserlistController extends GetxController{
  var users = <UserModel>[].obs;
  var isLoading = true.obs;


  Future<List<UserModel>> fetchUsers() async {
    final response = await http.get(Uri.parse('https://dummyjson.com/users?limit=20'),headers: {"Content-Type": "application/json"});
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      isLoading.value=false;
      final data = jsonDecode(response.body);
      users.value= (data['users'] as List).map((e) => UserModel.fromJson(e)).toList();
      return users.value;
    } else {
      isLoading.value=true;
      throw Exception('Failed to load chats');
    }
  }

}