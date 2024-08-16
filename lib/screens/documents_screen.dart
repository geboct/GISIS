import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class Document {
  final String name;
  final String status;
  final String details;

  Document({
    required this.name,
    required this.status,
    required this.details,
  });
}

class DocumentsScreen extends StatelessWidget {
  final List<Document> documents = [
    Document(
      name: 'Passport',
      status: 'Uploaded',
      details: 'Name: Salifu Gebilila\nNumber: 476465767\nCountry of Origin: Ghana\nExpiry Date: 12-12-2024',
    ),
    Document(
      name: 'Visa Application',
      status: 'Pending',
      details: 'Submission Date: 2023-01-15\nStatus: Pending documents',
    ),
    Document(
      name: 'Birth Certificate',
      status: 'Uploaded',
      details: 'Name: Salifu Gebilila\nDate of Birth: 12-12-1990\nPlace of Birth: Accra, Ghana',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Documents'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: documents.length,
          itemBuilder: (context, index) {
            return Card(
              child: ExpansionTile(
                leading: Icon(Icons.description),
                title: Text(documents[index].name),
                subtitle: Text('Status: ${documents[index].status}'),
                children: [
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(documents[index].details),
                  ),
                ],
                // onTap: () {
                //   // Handle document view
                // },
              ),
            );
          },
        ),
      ),
      floatingActionButton:SpeedDial(
      icon: Icons.add,
      activeIcon: Icons.close,
      backgroundColor: Colors.blue,
      overlayColor: Colors.black,
      overlayOpacity: 0.5,
      children: [
        SpeedDialChild(
          child: Icon(Icons.description),
          backgroundColor: Colors.green,
          label: 'Add Passport',
          onTap: () {
            // Handle add passport action
            _handleAddDocument(context, 'Passport');
          },
        ),
        SpeedDialChild(
          child: Icon(Icons.description),
          backgroundColor: Colors.orange,
          label: 'Add Visa Application',
          onTap: () {
            // Handle add visa application action
            _handleAddDocument(context, 'Visa Application');
          },
        ),
        SpeedDialChild(
          child: Icon(Icons.description),
          backgroundColor: Colors.red,
          label: 'Add Birth Certificate',
          onTap: () {
            // Handle add birth certificate action
            _handleAddDocument(context, 'Birth Certificate');
          },
        ),
      ],
    ),
    );
  }

  void _handleAddDocument(BuildContext context, String documentType) {
    // Handle adding a new document here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Adding $documentType')),
    );
    // Perform any other actions, such as navigating to a new screen for document upload
  }
}
