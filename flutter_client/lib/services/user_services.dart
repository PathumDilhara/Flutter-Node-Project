import 'dart:convert';

import 'package:flutter_client/models/user_model.dart';
import 'package:http/http.dart' as http;

const String baseUrl = "http://192.168.211.201:5000/api/users";

class UserServices {
  // Create user - Call to end point that created by node
  Future<void> createUser(UserModel userModel) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: <String, String>{
          'Content-Type':
              'application/json; charset=UTF-8', // What kind of data we pass-->json, what type of encoder we use---> UTF 8 bit
        },
        body: json.encode(userModel.toJson()),
      );

      // Check in userController(nodeServers) we return status
      if (response.statusCode != 201) {
        print('Failed to create user : ${response.statusCode}');
        throw Exception('Failed to create user');
      } else {
        print('################ User created successful');
      }
    } catch (err) {
      print("############## Error creating user : $err");
      rethrow;
    }
  }

  // Method to get all users
  Future<List<UserModel>> getAllUsers() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);

        return data.map((json) => UserModel.fromJson(json)).toList();
      } else{
        print("############ Failed to load users : ${response.statusCode}");
        throw Exception("Failed to load users");
      }
    } catch (err) {
      print("################# Error fetching users : $err");
      rethrow;
    }
  }
}
