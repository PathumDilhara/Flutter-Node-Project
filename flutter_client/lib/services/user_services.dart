import 'dart:convert';

import 'package:flutter_client/models/user_model.dart';
import 'package:http/http.dart' as http;

// const String baseUrl = "http://192.168.144.201:5000/api/users";
const String baseUrl = "http://192.168.199.201:5000/api/users"; // for real devices

// 10.0.2.2 = host machine's localhost from emulator’s point of view.
// const String baseUrl = "http://10.0.2.2:5000/api/users"; // for emulators only

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
      rethrow; // rethrows the original exception without losing the stack trace.
    }
  }

  // Method to get all users
  Future<List<UserModel>> getAllUsers() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);

        return data.map((json) => UserModel.fromJson(json)).toList();
      } else {
        print("############ Failed to load users : ${response.statusCode}");
        throw Exception("Failed to load users");
      }
    } catch (err) {
      print("################# Error fetching users : $err");
      rethrow;
    }
  }

  // Method to update/edit the user
  Future<void> updateUser(UserModel user) async {
    try {
      final response = await http.put(
        Uri.parse("$baseUrl/update/${user.id}"),// this will send data to node sever node server responsible for handling db
        headers: <String, String>{
          'Content-Type':
              'application/json; charset=UTF-8', // What kind of data we pass-->json, what type of encoder we use---> UTF 8 bit
        },
        body: json.encode(user.toJson()),
      );
      
      if(response.statusCode != 200){
        print("Failed to update the user : ${response.statusCode}");
        throw Exception("Failed to update the user");
      }
    } catch (err) {
      print("######## Error updating user $err");
    }
  }

  // Method to delete a user
  Future<void> deleteUser(String userId) async {
    try {
      // Check in node_server controller.js we have request id as param
      final response = await http.delete(
        Uri.parse("$baseUrl/delete/$userId"),
      ); // http://192.168.144.201:5000/api/users/delete/:id

      if (response.statusCode != 200) {
        print("################# Failed to delete the user $userId");
        throw Exception("failed to deleted");
      }
    } catch (err) {
      print("################## Error deleting user : $err");
      rethrow;
    }
  }
}
