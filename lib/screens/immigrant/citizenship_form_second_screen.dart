import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gsis/widgets/dblink.dart';
import 'package:gsis/widgets/toastmessage.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

class CitizenshipFormSecondScreen extends StatefulWidget {
  final String fullName;
  final String dateOfBirth;
  final String placeOfBirth;
  final String gender;
  final String maritalStatus;
  final String nationality;
  final String passportNumber;
  final String dateOfIssue;
  final String expiryDate;
  final String placeOfIssue;
  final String occupation;
  final String contactPersonName;
  final String contactPersonPhone;

  CitizenshipFormSecondScreen({
    required this.fullName,
    required this.dateOfBirth,
    required this.placeOfBirth,
    required this.gender,
    required this.maritalStatus,
    required this.nationality,
    required this.passportNumber,
    required this.dateOfIssue,
    required this.expiryDate,
    required this.placeOfIssue,
    required this.occupation,
    required this.contactPersonName,
    required this.contactPersonPhone,
  });

  @override
  _CitizenshipFormSecondScreenState createState() =>
      _CitizenshipFormSecondScreenState();
}

class _CitizenshipFormSecondScreenState
    extends State<CitizenshipFormSecondScreen> {
  XFile? _passportPhoto;
  XFile? _nationalityID;
  final ImagePicker _picker = ImagePicker();
  bool processing = false;

  Future<void> _pickPassportPhoto() async {
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      final result = await FilePicker.platform.pickFiles(type: FileType.image);
      if (result != null) {
        setState(() {
          _passportPhoto = XFile(result.files.single.path!);
        });
      }
    } else {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      setState(() {
        _passportPhoto = pickedFile;
      });
    }
  }
  Future<void> _pickNationalityID() async {
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      final result = await FilePicker.platform.pickFiles(type: FileType.image);
      if (result != null) {
        setState(() {
          _nationalityID = XFile(result.files.single.path!);
        });
      }
    } else {
      final ImageSource? imageSource = await showDialog<ImageSource>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Select Image Source'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Gallery'),
                  onTap: () {
                    Navigator.pop(context, ImageSource.gallery);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text('Camera'),
                  onTap: () {
                    Navigator.pop(context, ImageSource.camera);
                  },
                ),
              ],
            ),
          );
        },
      );

      if (imageSource != null) {
        final pickedFile = await _picker.pickImage(source: imageSource);
        setState(() {
          _nationalityID = pickedFile;
        });
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.white,),
        backgroundColor: Colors.green.shade900,
        title: const Text(
          'Citizenship Form-Step 2',
          style: TextStyle(
            color: Colors.white,
          ),
        ),      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Upload Passport Photo:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: _pickPassportPhoto,
              child: _passportPhoto == null
                  ? Container(
                      width: 100,
                      height: 100,
                      color: Colors.grey[300],
                      child: const Icon(Icons.camera_alt),
                    )
                  : Image.file(
                      File(_passportPhoto!.path),
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Upload Nationality ID:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: _pickNationalityID,
              child: _nationalityID == null
                  ? Container(
                      width: 100,
                      height: 100,
                      color: Colors.grey[300],
                      child: const Icon(Icons.camera_alt),
                    )
                  : Image.file(
                      File(_nationalityID!.path),
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
            ),
            const SizedBox(height: 20),
            Center(
              child: processing == true
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _submitForm,
                      child: const Text('Submit'),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() async {
    var uri = Uri.parse(
      DBLink().showDBLink('submit_citizenship_form'),
    );
    setState(() {
      processing = true;
    });
    var request = http.MultipartRequest('POST', uri);

    request.fields['full_name'] = widget.fullName;
    request.fields['date_of_birth'] = widget.dateOfBirth;
    request.fields['place_of_birth'] = widget.placeOfBirth;
    request.fields['gender'] = widget.gender;
    request.fields['marital_status'] = widget.maritalStatus;
    request.fields['nationality'] = widget.nationality;
    request.fields['passport_number'] = widget.passportNumber;
    request.fields['date_of_issue'] = widget.dateOfIssue;
    request.fields['expiry_date'] = widget.expiryDate;
    request.fields['place_of_issue'] = widget.placeOfIssue;
    request.fields['occupation'] = widget.occupation;
    request.fields['contact_person_name'] = widget.contactPersonName;
    request.fields['contact_person_phone'] = widget.contactPersonPhone;

    if (_passportPhoto != null) {
      var passportPhoto = await http.MultipartFile.fromPath(
        'passport_photo',
        _passportPhoto!.path,
        contentType: MediaType('image', 'jpeg'),
      );
      request.files.add(passportPhoto);
    }

    if (_nationalityID != null) {
      var nationalityID = await http.MultipartFile.fromPath(
        'nationality_id',
        _nationalityID!.path,
        contentType: MediaType('image', 'jpeg'),
      );
      request.files.add(nationalityID);
    }

    var response = await request.send();

    if (response.statusCode == 200) {
      setState(() {
        processing = false;
      });
      Navigator.pop(context);
      Navigator.pop(context);
      ShowToastMessage().showMessage(message: 'Form submitted successfully!');
    } else {
      setState(() {
        processing = false;
      });
      ShowToastMessage().showMessage(message: 'Failed to submit form.');
    }
  }
}
