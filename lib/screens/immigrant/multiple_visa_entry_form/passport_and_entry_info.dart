import 'package:flutter/material.dart';
import 'package:gsis/widgets/dblink.dart';
import 'package:gsis/widgets/toastmessage.dart';
import 'package:http/http.dart' as http;

class PassportEntryDetailsScreen extends StatefulWidget {
  final String applicationNumber;
  final String typeOfVisa;
  final String fullName;
  final String gender;
  final String age;
  final String nationality;
  final String occupation;

  PassportEntryDetailsScreen({
    required this.applicationNumber,
    required this.typeOfVisa,
    required this.fullName,
    required this.gender,
    required this.age,
    required this.nationality,
    required this.occupation,
  });

  @override
  _PassportEntryDetailsScreenState createState() =>
      _PassportEntryDetailsScreenState();
}

class _PassportEntryDetailsScreenState
    extends State<PassportEntryDetailsScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for each form field
  final TextEditingController countryOfBirthController =
      TextEditingController();
  final TextEditingController countryOfResidenceController =
      TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passportNumberController =
      TextEditingController();
  final TextEditingController placeOfIssueController = TextEditingController();
  final TextEditingController dateOfIssueController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController reasonForEntryController =
      TextEditingController();
  final TextEditingController proposedDateOfEntryController =
      TextEditingController();
  final TextEditingController durationOfStayController =
      TextEditingController();

  bool processing = false;

  // Function to select date
  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    DateTime currentDate = DateTime.now();
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (selectedDate != null && selectedDate != currentDate) {
      setState(() {
        controller.text =
            "${selectedDate.toLocal()}".split(' ')[0]; // Format as YYYY-MM-DD
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
        ),
        title: Text(
          'Passport and Entry Details',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green.shade900,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 10),

              _buildTextField(countryOfBirthController, 'Country of Birth'),
              const SizedBox(height: 20),
              _buildTextField(
                  countryOfResidenceController, 'Country of Residence'),
              const SizedBox(height: 20),
              _buildTextField(emailController, 'Email'),
              const SizedBox(height: 20),
              _buildTextField(passportNumberController, 'Passport Number'),
              const SizedBox(height: 20),
              _buildTextField(placeOfIssueController, 'Place of Issue'),
              const SizedBox(height: 20),
              _buildDateField(dateOfIssueController, 'Date of Issue'),
              const SizedBox(height: 20),
              _buildDateField(expiryDateController, 'Expiry Date'),
              const SizedBox(height: 20),
              _buildTextField(reasonForEntryController, 'Reason for Entry'),
              const SizedBox(height: 20),
              _buildTextField(
                  proposedDateOfEntryController, 'Proposed Date of Entry'),
              const SizedBox(height: 20),
              _buildTextField(
                  durationOfStayController, 'Duration of Stay (in days)'),
              SizedBox(height: 20),
              processing == true
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _submitForm();
                        }
                      },
                      child: Text('Submit'),
                    ),
              const SizedBox(height: 20),

            ],
          ),
        ),
      ),
    );
  }

  // Method to build a date field
  Widget _buildDateField(TextEditingController controller, String label) {
    return GestureDetector(
      onTap: () => _selectDate(context, controller),
      child: AbsorbPointer(
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select $label';
            }
            return null;
          },
        ),
      ),
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
    countryOfBirthController.dispose();
    countryOfResidenceController.dispose();
    emailController.dispose();
    passportNumberController.dispose();
    placeOfIssueController.dispose();
    dateOfIssueController.dispose();
    expiryDateController.dispose();
    reasonForEntryController.dispose();
    proposedDateOfEntryController.dispose();
    durationOfStayController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        processing = true;
      });
      // Gather form data
      final Map<String, String> formData = {
        'application_number': widget.applicationNumber,
        'type_of_visa': widget.typeOfVisa,
        'full_name': widget.fullName,
        'gender': widget.gender,
        'age': widget.age,
        'nationality': widget.nationality,
        'occupation': widget.occupation,
        'country_of_birth': countryOfBirthController.text,
        'country_of_residence': countryOfResidenceController.text,
        'email': emailController.text,
        'passport_number': passportNumberController.text,
        'place_of_issue': placeOfIssueController.text,
        'date_of_issue': dateOfIssueController.text,
        'expiry_date': expiryDateController.text,
        'reason_for_entry': reasonForEntryController.text,
        'proposed_date_of_entry': proposedDateOfEntryController.text,
        'duration_of_stay': durationOfStayController.text,
      };

      // Replace with your server URL
      final String url = DBLink().showDBLink('submit_multiple_visa_entry');

      try {
        final response = await http.post(
          Uri.parse(url),
          body: formData,
        );
        if (response.statusCode == 200) {
          setState(() {
            processing = false;
          });
          ShowToastMessage()
              .showMessage(message: 'Form submitted successfully');
        } else {
          setState(() {
            processing = false;
          });
          ShowToastMessage().showMessage(message: 'Failed to submit form');
        }
      } catch (e) {
        setState(() {
          processing = false;
        });
        ShowToastMessage().showMessage(message: 'Server Error');
      }
    }
  }
}
