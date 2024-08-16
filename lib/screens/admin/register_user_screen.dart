import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterUserScreen extends StatefulWidget {
  @override
  State<RegisterUserScreen> createState() => _RegisterUserScreenState();
}

class _RegisterUserScreenState extends State<RegisterUserScreen> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _passportNumberController = TextEditingController();

  final TextEditingController _yellowFeverCardController = TextEditingController();

  final TextEditingController _visaController = TextEditingController();

  Future<void> _registerUser() async {
    final response = await http.post(
      Uri.parse('http://localhost/gsis-backend/register_user.php'),
      body: {
        'name': _nameController.text,
        'passport_number': _passportNumberController.text,
        'yellow_fever_card': _yellowFeverCardController.text,
        'visa': _visaController.text,
        'role': 'immigrant',
      },
    );

    final responseData = json.decode(response.body);
    if (responseData['success']) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User registered successfully')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to register user')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _passportNumberController,
              decoration: InputDecoration(labelText: 'Passport Number'),
            ),
            TextField(
              controller: _yellowFeverCardController,
              decoration: InputDecoration(labelText: 'Yellow Fever Card'),
            ),
            TextField(
              controller: _visaController,
              decoration: InputDecoration(labelText: 'Visa'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _registerUser,
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
