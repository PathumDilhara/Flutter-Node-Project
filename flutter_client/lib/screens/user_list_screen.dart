import 'package:flutter/material.dart';
import 'package:flutter_client/provider/user_provider.dart';
import 'package:flutter_client/screens/add_user_screen.dart';
import 'package:flutter_client/screens/edit_users_screen.dart';
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
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: userProvider.users.length,
            itemBuilder: (context, index) {
              final user = userProvider.users[index];
              return ListTile(
                title: Text(user.name),
                subtitle: Text(user.email),
                onTap:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditUsersScreen(user: user),
                      ),
                    ),
                trailing: IconButton(
                  onPressed: () {
                    userProvider.deleteUser(user.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("User deleted successfully")),
                    );
                  },
                  icon: Icon(Icons.delete),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
