import 'package:flutter/material.dart';
import 'package:gsis/models/logged_in_user_model.dart';

class ProfileScreen extends StatelessWidget {
  final LoggedInUserModel user;

  ProfileScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/gis.jpg'),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text('Nationality:Ghanaian'),
                  Text('Status: Wanted'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Card(
                child: ListTile(
              title: const Text(
                'Username',
              ),
              subtitle: Text(user.username),
            )),
            Card(
                child: ListTile(
              title: const Text('Email'),
              subtitle: Text(user.email),
            )),
            const Card(
              child: ListTile(
                title: Text('Phone'),
                subtitle: Text('0243930223'),
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                editProfile(context);
              },
              child: Container(
                height: 50,
                margin: const EdgeInsets.only(top: 30),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(50),
                    ),
                    color: Colors.green[900]),
                child: const Center(
                  child: Text(
                    'Edit',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///**
  ///
  ///Edit Profile
  ///**///

  editProfile(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String name = '';
    String email = '';
    String phoneNumber = '';

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit My Profile'),
          actionsAlignment: MainAxisAlignment.center,
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Name'),
                  initialValue: name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    name = value!;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Email'),
                  initialValue: email,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    email = value!;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Phone Number'),
                  initialValue: phoneNumber,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    if (!RegExp(r'^\d{10,}$').hasMatch(value)) {
                      return 'Please enter a valid phone number';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    phoneNumber = value!;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  // Handle form submission
                  print('Name: $name');
                  print('Email: $email');
                  print('Phone Number: $phoneNumber');
                  Navigator.pop(context);
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
  }

