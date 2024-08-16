import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gsis/widgets/dblink.dart';
import 'package:gsis/widgets/toastmessage.dart';
import 'package:http/http.dart' as http;

class StudentPassForm extends StatefulWidget {
  @override
  _StudentPassFormState createState() => _StudentPassFormState();
}

class _StudentPassFormState extends State<StudentPassForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _applicationNumberController =
      TextEditingController();
  final TextEditingController _studentNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nationalityController = TextEditingController();
  final TextEditingController _institutionNameController =
      TextEditingController();
  final TextEditingController _educationalDurationController =
      TextEditingController();
  final TextEditingController _admissionNumberController =
      TextEditingController();
  final TextEditingController _studentDeclarationController =
      TextEditingController();
  final TextEditingController _academicQualificationController =
      TextEditingController();

  String _gender = 'Male';
  bool processing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Student Pass Form',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green.shade900,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _applicationNumberController,
                decoration: const InputDecoration(
                  labelText: 'Application Number',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter application number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _studentNameController,
                decoration: const InputDecoration(
                  labelText: 'Student Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter student name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField(
                value: _gender,
                items: ['Male', 'Female'].map((String category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _gender = newValue!;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Gender',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email Address',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter email address';
                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nationalityController,
                decoration: const InputDecoration(
                  labelText: 'Nationality',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter nationality';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _institutionNameController,
                decoration: const InputDecoration(
                  labelText: 'Institution Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter institution name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _educationalDurationController,
                decoration: const InputDecoration(
                  labelText: 'Educational Duration',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter educational duration';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _admissionNumberController,
                decoration: const InputDecoration(
                  labelText: 'Admission Number',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter admission number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _studentDeclarationController,
                decoration: const InputDecoration(
                  labelText: 'Student Declaration',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter student declaration';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _academicQualificationController,
                decoration: const InputDecoration(
                  labelText: 'Academic Qualification',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter academic qualification';
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
                          _showConfirmationDialog(context);
                        }
                      },
                      child: const Text('Submit'),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Submission'),
          content: const Text('Are you sure you want to submit this form?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                submitStudentPassForm(context);
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  Future<void> submitStudentPassForm(context) async {
    final formData = {
      'application_number': _applicationNumberController.text,
      'student_name': _studentNameController.text,
      'gender': _gender,
      'email': _emailController.text,
      'nationality': _nationalityController.text,
      'institution_name': _institutionNameController.text,
      'educational_duration': _educationalDurationController.text,
      'admission_number': _admissionNumberController.text,
      'student_declaration': _studentDeclarationController.text,
      'academic_qualification': _academicQualificationController.text,
    };

    String url = DBLink().showDBLink('submit_student_pass_form');
    setState(() {
      processing = true;
    });
    try {
      final response = await http.post(Uri.parse(url), body: formData);

      final responseData = json.decode(response.body);
      if (responseData['success']) {
        // Handle successful submission
        setState(() {
          processing = false;
        });
        ShowToastMessage().showMessage(message: responseData['message']);
        Navigator.pop(context);
      } else {
        // Handle failure
        setState(() {
          processing = false;
        });
        ShowToastMessage().showMessage(message: responseData['message']);
        Navigator.pop(context);
      }
    } catch (e) {
      setState(() {
        processing = false;
      });
      ShowToastMessage().showMessage(message: 'Server Error');
    }
  }
}
