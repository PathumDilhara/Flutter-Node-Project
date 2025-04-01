import 'package:flutter/material.dart';
import 'package:flutter_client/provider/user_provider.dart';
import 'package:flutter_client/screens/add_user_screen.dart';
import 'package:provider/provider.dart';

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
      body: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          if (userProvider.users.isEmpty) {
            return CircularProgressIndicator();
          }
          return ListView.builder(
            itemCount: userProvider.users.length,
            itemBuilder: (context, index) {
              final user = userProvider.users[index];
              return ListTile(title: Text(user.name),
              subtitle: Text(user.email),
              trailing: IconButton(
                // Todo : Delete the user
                  onPressed: () {
                
              }, icon: Icon(Icons.delete)),);
            },
          );
        },
      ),
    );
  }
}
