import 'package:flutter/foundation.dart';
import 'package:flutter_client/models/user_model.dart';
import 'package:flutter_client/services/user_services.dart';

class UserProvider with ChangeNotifier {
  final UserServices _userServices = UserServices();
  final List<UserModel> _users = [];

  // Getter
  List<UserModel> get users => _users;

  // TODO : Fetch users when the provider is initialized

  // Create user
  Future<void> addUser(UserModel userModel) async {
    try {
      await _userServices.createUser(userModel);
      _users.add(userModel);
    } catch (err) {
      print("################ Failed to add user : $err");
    }
  }
}
