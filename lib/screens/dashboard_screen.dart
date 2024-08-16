import 'package:flutter/material.dart';
import 'package:gsis/screens/application_status_screen.dart';
import 'package:gsis/screens/documents_screen.dart';
import 'package:gsis/screens/profile_screen.dart';
import 'package:gsis/screens/support_screen.dart';

import '../models/logged_in_user_model.dart';

class DashboardScreen extends StatefulWidget {
  final LoggedInUserModel user;

  DashboardScreen({required this.user});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Handle logout
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome, ${widget.user.username}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Card(
              child: ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Profile'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileScreen(
                        user: LoggedInUserModel(
                            id: '7254',
                            username: 'Mrbril',
                            fullName: 'Mrbril',
                            email: 'gebililasalifu@gmail.com'),
                      ),
                    ),
                  );
                  // Navigate to profile screen
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.document_scanner),
                title: const Text('Documents'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DocumentsScreen(),
                    ),
                  );
                  // Navigate to documents screen
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.track_changes),
                title: const Text('Application Status'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ApplicationStatusScreen(),
                    ),
                  );
                  // Navigate to application status screen
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.notifications),
                title: const Text('Notifications'),
                onTap: () {
                  // Navigate to notifications screen
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.help),
                title: const Text('Support/Help Desk'),
                onTap: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SupportScreen(),
                    ),
                  );
                  // Navigate to support/help desk screen
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
