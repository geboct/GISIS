import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'citizenship_form_second_screen.dart';

class CitizenshipFormFirstScreen extends StatefulWidget {
  @override
  _CitizenshipFormFirstScreenState createState() =>
      _CitizenshipFormFirstScreenState();
}

class _CitizenshipFormFirstScreenState
    extends State<CitizenshipFormFirstScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _placeOfBirthController = TextEditingController();
  final TextEditingController _passportNumberController =
      TextEditingController();
  final TextEditingController _dateOfIssueController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _placeOfIssueController = TextEditingController();
  final TextEditingController _occupationController = TextEditingController();
  final TextEditingController _contactPersonNameController =
      TextEditingController();
  final TextEditingController _contactPersonPhoneController =
      TextEditingController();
  final TextEditingController _nationalityController = TextEditingController();

  DateTime? _dateOfBirth;
  DateTime? _dateOfIssue;
  DateTime? _expiryDate;

  String? _gender;
  String? _maritalStatus;

  final List<String> _genders = ['Male', 'Female', 'Other'];
  final List<String> _maritalStatuses = [
    'Single',
    'Married',
    'Divorced',
    'Widowed'
  ];

  Future<void> _selectDate(BuildContext context,
      TextEditingController controller, DateTime? selectedDate) async {
    final DateTime now = DateTime.now();
    final DateTime initialDate = selectedDate ?? now;
    final DateTime firstDate = DateTime(1900);
    final DateTime lastDate = now;

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (pickedDate != null && pickedDate != initialDate) {
      setState(() {
        selectedDate = pickedDate;
        _dateOfIssue = pickedDate;
        controller.text = DateFormat('yyyy-MM-dd').format(selectedDate!);
      });
    }
  }

  Future<void> _selectExpiryDate(BuildContext context,
      TextEditingController controller, DateTime? selectedDate) async {
    final DateTime now = DateTime.now();
    final DateTime initialDate = DateTime(
        _dateOfIssue!.year + 1, _dateOfIssue!.month, _dateOfIssue!.day);
    final DateTime firstDate = DateTime(
        _dateOfIssue!.year + 1, _dateOfIssue!.month, _dateOfIssue!.day);
    final DateTime lastDate = DateTime(4050);

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (pickedDate != null && pickedDate != initialDate) {
      setState(() {
        selectedDate = pickedDate;

        controller.text = DateFormat('yyyy-MM-dd').format(selectedDate!);
      });
    }
  }

  void _navigateToSecondScreen() {
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CitizenshipFormSecondScreen(
            fullName: _fullNameController.text,
            dateOfBirth: _dateOfBirthController.text,
            placeOfBirth: _placeOfBirthController.text,
            gender: _gender!,
            maritalStatus: _maritalStatus!,
            nationality: _nationalityController.text,
            passportNumber: _passportNumberController.text,
            dateOfIssue: _dateOfIssueController.text,
            expiryDate: _expiryDateController.text,
            placeOfIssue: _placeOfIssueController.text,
            occupation: _occupationController.text,
            contactPersonName: _contactPersonNameController.text,
            contactPersonPhone: _contactPersonPhoneController.text,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
        ),
        backgroundColor: Colors.green.shade900,
        title: const Text(
          'Citizenship Form-Step 1',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _fullNameController,
                  decoration: const InputDecoration(
                    labelText: 'Full Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _dateOfBirthController,
                  decoration: const InputDecoration(
                    labelText: 'Date of Birth',
                    border: OutlineInputBorder(),
                  ),
                  readOnly: true,
                  onTap: () => _selectDate(
                      context, _dateOfBirthController, _dateOfBirth),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select your date of birth';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _placeOfBirthController,
                  decoration: const InputDecoration(
                    labelText: 'Place of Birth',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your place of birth';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _gender,
                  decoration: const InputDecoration(
                    labelText: 'Gender',
                    border: OutlineInputBorder(),
                  ),
                  items: _genders.map((String gender) {
                    return DropdownMenuItem<String>(
                      value: gender,
                      child: Text(gender),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _gender = newValue;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select your gender';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _maritalStatus,
                  decoration: const InputDecoration(
                    labelText: 'Marital Status',
                    border: OutlineInputBorder(),
                  ),
                  items: _maritalStatuses.map((String status) {
                    return DropdownMenuItem<String>(
                      value: status,
                      child: Text(status),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _maritalStatus = newValue;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select your marital status';
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
                      return 'Please enter your nationality';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
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
                const SizedBox(height: 16),
                TextFormField(
                  controller: _dateOfIssueController,
                  decoration: const InputDecoration(
                    labelText: 'Date of Issue (YMD)',
                    border: OutlineInputBorder(),
                  ),
                  readOnly: true,
                  onTap: () => _selectDate(
                      context, _dateOfIssueController, _dateOfIssue),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select the date of issue';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _expiryDateController,
                  decoration: const InputDecoration(
                    labelText: 'Expiry Date (YMD)',
                    border: OutlineInputBorder(),
                  ),
                  readOnly: true,
                  onTap: () => _selectExpiryDate(
                      context, _expiryDateController, _expiryDate),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select the expiry date';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _placeOfIssueController,
                  decoration: const InputDecoration(
                    labelText: 'Place of Issue',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the place of issue';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _occupationController,
                  decoration: const InputDecoration(
                    labelText: 'Occupation',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your occupation';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _contactPersonNameController,
                  decoration: const InputDecoration(
                    labelText: 'Contact Person Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the contact person\'s name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _contactPersonPhoneController,
                  decoration: const InputDecoration(
                    labelText: 'Contact Person Phone Number',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the contact person\'s phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _navigateToSecondScreen,
                  child: const Text('Continue to Next Screen'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
