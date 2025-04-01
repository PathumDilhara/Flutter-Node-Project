import 'package:flutter/material.dart';
import 'package:flutter_client/models/user_model.dart';
import 'package:flutter_client/provider/user_provider.dart';
import 'package:provider/provider.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add User")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Name
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: "Name"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a name";
                  }

                  return null;
                },
              ),

              // Email
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: "E-mail"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a email";
                  }

                  return null;
                },
              ),

              // Age
              TextFormField(
                controller: _ageController,
                decoration: InputDecoration(labelText: "Age"),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a age";
                  }
                  return null;
                },
              ),

              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final newUser = UserModel(
                      id: "",
                      name: _nameController.text,
                      email: _emailController.text,
                      age: int.parse(_ageController.text),
                    );
                    try {
                      await Provider.of<UserProvider>(
                        context,
                        listen: false,
                      ).addUser(newUser);
                      Navigator.pop(context);
                    } catch (err) {
                      if(context.mounted){
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Error adding user : $err"),
                          backgroundColor: Colors.red,
                        ),
                      );
                      }
                    }
                  }
                },
                child: Text("Add User"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
