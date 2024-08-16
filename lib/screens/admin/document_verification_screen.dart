import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gsis/models/documentModel.dart';
import 'package:gsis/screens/admin/addNewEmigrantOrImmigrant.dart';
import 'package:gsis/widgets/dblink.dart';
import 'package:http/http.dart' as http;

class DocumentVerificationScreen extends StatefulWidget {
  @override
  _DocumentVerificationScreenState createState() =>
      _DocumentVerificationScreenState();
}

class _DocumentVerificationScreenState
    extends State<DocumentVerificationScreen> {
  final TextEditingController _passportNumberController =
      TextEditingController();
  DocumentModel? _foundDocument;
  bool _isLoading = false;

  Future<void> _searchDocument() async {
    setState(() {
      _isLoading = true;
    });
    String url = DBLink().showDBLink('searchDocument');
    final response = await http.post(
      Uri.parse(url),
      body: {'passportNumber': _passportNumberController.text},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['success']) {
        _foundDocument = DocumentModel(
            passportNumber: data['document']['passportNumber'].toString(),
            name: data['document']['name'],
            yellowFeverCard: data['document']['yellowFeverCard'],
            visa: data['document']['visa'],
            status: data['document']['status'],
            type: data['document']['type']);
      } else {
        _foundDocument = null;
      }
    } else {
      // Handle server error
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _approveDocument() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Approve Document'),
          content: const Text('Are you sure you want to approve this document?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Approve the document and update the backend
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Document approved.'),
                ));
              },
              child: const Text('Approve'),
            ),
          ],
        );
      },
    );
  }

  void _registerNewImmigrantOrEmigrant(String type) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => NewEmigrantOrImmigrantScreen(type: type)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.white,),
        backgroundColor: Colors.green.shade900,
        title: const Text(
          'Document Verification',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _passportNumberController,
              decoration: InputDecoration(
                labelText: 'Enter Passport Number',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _searchDocument,
                ),
              ),
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : _foundDocument != null
                    ? Card(
                        child: ListTile(
                          leading: const Icon(Icons.description),
                          title: Text(_foundDocument!.name),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'Passport Number: ${_foundDocument!.passportNumber}'),
                              Text(
                                  'Yellow Fever Card: ${_foundDocument!.yellowFeverCard}'),
                              Text('Visa: ${_foundDocument!.visa}'),
                              Text('Status: ${_foundDocument!.status}'),
                            ],
                          ),

                        ),
                      )
                    : Column(
                        children: [
                          const Text(
                              'No document found for the given passport number.'),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              _registerNewImmigrantOrEmigrant('Immigrant');
                            },
                            child: const Text('Register New Immigrant'),
                          ),
                          const SizedBox(height: 15),
                          ElevatedButton(
                            onPressed: () {
                              _registerNewImmigrantOrEmigrant('Emigrant');
                            },
                            child: const Text('Register New Emigrant'),
                          ),
                        ],
                      ),
          ],
        ),
      ),
    );
  }
}

