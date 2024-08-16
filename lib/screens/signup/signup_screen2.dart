import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gsis/screens/login.dart';
import 'package:gsis/widgets/dblink.dart';
import 'package:gsis/widgets/toastmessage.dart';
import 'package:http/http.dart' as http;

class SignupScreen2 extends StatefulWidget {
  final String fullName;
  final String dateOfBirth;
  final String nationality;
  final String phoneNumber;
  final String placeOfBirth;

  SignupScreen2({
    required this.fullName,
    required this.dateOfBirth,
    required this.nationality,
    required this.phoneNumber,
    required this.placeOfBirth,
  });

  @override
  _SignupScreen2State createState() => _SignupScreen2State();
}

class _SignupScreen2State extends State<SignupScreen2> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _passportNumberController = TextEditingController();
  TextEditingController _dateOfIssueController = TextEditingController();
  TextEditingController _expiryDateController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool processing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signup - Step 2'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _passportNumberController,
                decoration: const InputDecoration(
                  labelText: 'Passport Number',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your passport number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _dateOfIssueController,
                decoration: const InputDecoration(
                  labelText: 'Date of Issue',
                  border: OutlineInputBorder(),
                ),
                onTap: () async {
                  DateTime? date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (date != null) {
                    _dateOfIssueController.text =
                        date.toLocal().toString().split(' ')[0];
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your passport issue date';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _expiryDateController,
                decoration: const InputDecoration(
                  labelText: 'Expiry Date',
                  border: OutlineInputBorder(),
                ),
                onTap: () async {
                  DateTime? date = await showDatePicker(
                    context: context,
                    initialDate:
                        DateTime.now().add(const Duration(days: 365 * 10)),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (date != null) {
                    _expiryDateController.text =
                        date.toLocal().toString().split(' ')[0];
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your passport expiry date';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  // Regular expression for validating an email address
                  final emailRegex = RegExp(
                    r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
                    caseSensitive: false,
                  );
                  if (!emailRegex.hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }

                  // Password length validation
                  if (value.length < 8) {
                    return 'Password must be at least 8 characters long';
                  }

                  // Check for at least one uppercase letter
                  if (!RegExp(r'(?=.*[A-Z])').hasMatch(value)) {
                    return 'Password must include at least one uppercase letter';
                  }

                  // Check for at least one lowercase letter
                  if (!RegExp(r'(?=.*[a-z])').hasMatch(value)) {
                    return 'Password must include at least one lowercase letter';
                  }

                  // Check for at least one special character
                  if (!RegExp(r'(?=.*[@$!%*?&])').hasMatch(value)) {
                    return 'Password must include at least one special character';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 20),
              processing == true
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          signup(
                            widget.fullName,
                            widget.dateOfBirth,
                            widget.nationality,
                            widget.phoneNumber,
                            widget.placeOfBirth,
                            _passportNumberController.text,
                            _dateOfIssueController.text,
                            _expiryDateController.text,
                            _emailController.text,
                            _passwordController.text,
                            context,
                          );
                        }
                      },
                      child: Text('Signup'),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> signup(
    String fullName,
    String dateOfBirth,
    String nationality,
    String phoneNumber,
    String placeOfBirth,
    String passportNumber,
    String dateOfIssue,
    String expiryDate,
    String email,
    String password,
    BuildContext context,
  ) async {
    // API endpoint
    final String url = DBLink().showDBLink('signup');

    // Create the request body
    Map<String, String> body = {
      'fullName': fullName,
      'dateOfBirth': dateOfBirth,
      'nationality': nationality,
      'phoneNumber': phoneNumber,
      'placeOfBirth': placeOfBirth,
      'passportNumber': passportNumber,
      'dateOfIssue': dateOfIssue,
      'expiryDate': expiryDate,
      'email': email,
      'password': password,
    };

    // Send the POST request
    setState(() {
      processing == true;
    });
    try {
      final response = await http.post(
        Uri.parse(url),
        body: body,
      );

      // Decode the response
      var jsonResponse = json.decode(response.body);

      if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
        // Show success message and navigate to the login screen
        ShowToastMessage().showMessage(message: jsonResponse['message']);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
        setState(() {
          processing == false;
        });
      } else {
        ShowToastMessage().showMessage(message: jsonResponse['message']);
        setState(() {
          processing == false;
        });
      }
    } catch (e) {
      // Handle errors
      setState(() {
        processing == false;
      });
      ShowToastMessage().showMessage(message: 'Server Error');
    }
  }
}
