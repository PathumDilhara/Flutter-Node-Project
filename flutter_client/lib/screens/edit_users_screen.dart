import 'package:flutter/material.dart';
import 'package:flutter_client/models/user_model.dart';
import 'package:provider/provider.dart';

import '../provider/user_provider.dart';

class EditUsersScreen extends StatefulWidget {
  final UserModel user;
  const EditUsersScreen({super.key, required this.user});

  @override
  State<EditUsersScreen> createState() => _EditUsersScreenState();
}

class _EditUsersScreenState extends State<EditUsersScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController = TextEditingController();
  late TextEditingController _emailController = TextEditingController();
  late TextEditingController _ageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Assigning initial values
    _nameController = TextEditingController(text: widget.user.name);
    _emailController = TextEditingController(text: widget.user.email);
    _ageController = TextEditingController(text: widget.user.age.toString());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit info")),
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
                      id: widget.user.id,
                      name: _nameController.text,
                      email: _emailController.text,
                      age: int.parse(_ageController.text),
                    );
                    try {
                      await Provider.of<UserProvider>(
                        context,
                        listen: false,
                      ).updateUser(newUser);
                      if(context.mounted){
                        if(context.mounted) Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("User updated"),
                            backgroundColor: Colors.grey,
                          ),
                        );

                        _nameController.clear();
                        _emailController.clear();
                        _ageController.clear();
                      }

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
                child: Text("Edit User"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
