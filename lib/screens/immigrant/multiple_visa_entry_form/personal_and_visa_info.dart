import 'package:flutter/material.dart';
import 'package:gsis/screens/immigrant/multiple_visa_entry_form/passport_and_entry_info.dart';

class PersonalVisaInfoScreen extends StatefulWidget {
  @override
  _PersonalVisaInfoScreenState createState() => _PersonalVisaInfoScreenState();
}

class _PersonalVisaInfoScreenState extends State<PersonalVisaInfoScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for each form field
  final TextEditingController applicationNumberController =
  TextEditingController();
  final TextEditingController typeOfVisaController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController nationalityController = TextEditingController();
  final TextEditingController occupationController = TextEditingController();

  String? _selectedGender; // Variable to hold the selected gender

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
        ),
        backgroundColor: Colors.green.shade900,
        title: Text(
          'Personal and Visa Information',
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField(
                  applicationNumberController, 'Application Number'),
             const SizedBox(height: 20,),
              _buildTextField(typeOfVisaController, 'Type of Visa'),
              const SizedBox(height: 20,),
              _buildTextField(fullNameController, 'Full Name'),
              const SizedBox(height: 20,),
              _buildGenderDropdown(),
              const SizedBox(height: 20,),
              _buildTextField(ageController, 'Age'),
              const SizedBox(height: 20,),
              _buildTextField(nationalityController, 'Nationality'),
              const SizedBox(height: 20,),
              _buildTextField(occupationController, 'Occupation'),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Navigate to the next screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PassportEntryDetailsScreen(
                          applicationNumber: applicationNumberController.text,
                          typeOfVisa: typeOfVisaController.text,
                          fullName: fullNameController.text,
                          gender: _selectedGender!,
                          age: ageController.text,
                          nationality: nationalityController.text,
                          occupation: occupationController.text,
                        ),
                      ),
                    );
                  }
                },
                child: Text('Next'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Method to build a gender dropdown field
  Widget _buildGenderDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedGender,
      decoration: InputDecoration(
        labelText: 'Gender',
        border: OutlineInputBorder(),
      ),
      items: ['Male', 'Female', 'Other']
          .map((gender) => DropdownMenuItem<String>(
        value: gender,
        child: Text(gender),
      ))
          .toList(),
      onChanged: (value) {
        setState(() {
          _selectedGender = value;
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select your gender';
        }
        return null;
      },
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }

  @override
  void dispose() {
    // Dispose of all controllers
    applicationNumberController.dispose();
    typeOfVisaController.dispose();
    fullNameController.dispose();
    ageController.dispose();
    nationalityController.dispose();
    occupationController.dispose();
    super.dispose();
  }
}
