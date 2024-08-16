import 'package:flutter/material.dart';

class Application {
  final String type;
  final String submissionDate;
  final String status;
  final String notes;

  Application({
    required this.type,
    required this.submissionDate,
    required this.status,
    required this.notes,
  });
}

class ApplicationStatusScreen extends StatelessWidget {
  final List<Application> applications = [
    Application(
      type: 'Visa Application',
      submissionDate: '2023-01-15',
      status: 'Under Review',
      notes: 'Your application is being reviewed.',
    ),
    Application(
      type: 'Permanent Residency',
      submissionDate: '2022-10-01',
      status: 'Approved',
      notes: 'Congratulations! Your application has been approved.',
    ),
    Application(
      type: 'Work Permit',
      submissionDate: '2023-02-20',
      status: 'Pending',
      notes: 'Awaiting additional documents.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Application Status'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: applications.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                leading: Icon(Icons.assignment),
                title: Text(applications[index].type),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Submission Date: ${applications[index].submissionDate}'),
                    Text('Status: ${applications[index].status}'),
                    Text('Notes: ${applications[index].notes}'),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
