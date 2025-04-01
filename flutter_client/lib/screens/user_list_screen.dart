import 'package:flutter/material.dart';
import 'package:flutter_client/screens/add_user.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users List"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddUserScreen()),
              );
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
