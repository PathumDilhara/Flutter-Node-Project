import 'package:flutter/foundation.dart';
import 'package:flutter_client/models/user_model.dart';
import 'package:flutter_client/services/user_services.dart';

class UserProvider with ChangeNotifier {
  final UserServices _userServices = UserServices();
  List<UserModel> _users = [];

  // Getter
  List<UserModel> get users => _users;

  //  Fetch users when the provider is initialized
  UserProvider() {
    fetchAllUsers();
  }

  // Fetch all users
  Future<void> fetchAllUsers() async {
    try {
      _users = await _userServices.getAllUsers();
      notifyListeners();
    } catch (err) {
      print("############ Failed to fetch all users (provider) : $err");
    }
  }

  // Create user
  Future<void> addUser(UserModel userModel) async {
    try {
      await _userServices.createUser(userModel);
      _users.add(userModel);
      notifyListeners();
    } catch (err) {
      print("################ Failed to add user : $err");
    }
  }

  // Method to update user
  Future<void> updateUser(UserModel user) async {
    try {
      await _userServices.updateUser(user);

      // get the index of updated user
      int index = _users.indexWhere((userInList) => userInList.id == user.id);

      if (index != -1) { // check index is valid
        _users[index] = user;
        notifyListeners();
      }
    } catch (err) {
      print("########## Failed to update the user : $err");
    }
  }

  // Method to delete an user
  Future<void> deleteUser(String userId) async {
    try {
      await _userServices.deleteUser(userId);
      _users.removeWhere((user) => user.id == userId);
      notifyListeners();
    } catch (err) {
      print("############## Error deleting user (provider) : $err");
    }
  }
}
