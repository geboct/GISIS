import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../widgets/dblink.dart';
import '../../widgets/toastmessage.dart';

class AddEmployeeScreen extends StatefulWidget {
  @override
  _AddEmployeeScreenState createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();


  bool _addingEmployee = false;


  void _addEmployeeFunction(
      String fullName,
      String email,
      String phone,
     ) async {
    try {
      setState(() {
        _addingEmployee = true;
      });
      String url = DBLink().showDBLink('addNewEmployee');
      final response = await http.post(
        Uri.parse(url),
        body: {
          'name': fullName,
          'email': email,
          'phone': phone,

        },
      );
      if (json.decode(response.body)['success'].toString() == 'true') {
        // Show success message or handle success case
        ShowToastMessage().showMessage(message: 'User added successfully');
        Navigator.pop(context);
        setState(() {
          _addingEmployee = false;
        });
      } else {
        // Show error message or handle error case
        ShowToastMessage().showMessage(message: 'Failed to add User');

        setState(() {
          _addingEmployee = false;
        });
      }
    } catch (e) {
      print(e);

      ShowToastMessage().showMessage(message: 'Server Error');

      setState(() {
        _addingEmployee = false;
      });
      // Handle other exceptions
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.white,),
        backgroundColor: Colors.green.shade900,
        title: const Text(
          'Add Employee',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _fullNameController,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your full name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),

              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a phone number';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),
              _addingEmployee
                  ? const Center(
                      child: Column(
                        children: [
                          CircularProgressIndicator(),
                          Text('Adding User'),
                        ],
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          _addEmployeeFunction(
                            _fullNameController.text,
                            _emailController.text,
                            _phoneController.text,

                          );
                        }
                      },
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.green.shade900,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Save',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
