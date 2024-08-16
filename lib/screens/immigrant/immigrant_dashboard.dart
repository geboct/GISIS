import 'package:flutter/material.dart';
import 'package:gsis/provider/userProvider.dart';
import 'package:gsis/screens/immigrant/citizenship_form_first_screen.dart';
import 'package:gsis/screens/immigrant/immigrantprofile.dart';
import 'package:gsis/screens/immigrant/multiple_visa_entry_form/personal_and_visa_info.dart';
import 'package:gsis/screens/immigrant/student_pass_form.dart';
import 'package:gsis/screens/immigrant/work_permit.dart';
import 'package:provider/provider.dart';

import '../login.dart';

class ImmigrantDashboard extends StatelessWidget {
  const ImmigrantDashboard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('assets/images/gis.jpg'),
        title: const Text('GISIS'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'Profile') {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ImmigrantProfileScreen(
                        immigrantId: Provider.of<LoggedInUserProvider>(context,
                                listen: false)
                            .user
                            .id),
                  ),
                );
              } else if (value == 'Logout') {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (Route<dynamic> route) => false,
                );
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem<String>(
                value: 'Profile',
                child: Row(
                  children: [
                    Icon(Icons.person, color: Colors.green.shade900),
                    SizedBox(width: 8),
                    Text('Profile'),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'Logout',
                child: Row(
                  children: [
                    Icon(Icons.logout, color: Colors.green.shade900),
                    SizedBox(width: 8),
                    Text('Logout'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 4.0,
              color: Colors.blue[50],
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Welcome, ${Provider.of<LoggedInUserProvider>(context, listen: false).user.fullName}!',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Select an option to continue:',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            DashboardOption(
              title: 'Citizenship Form',
              icon: Icons.account_balance,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CitizenshipFormFirstScreen(),
                  ),
                );
              },
            ),
            DashboardOption(
              title: 'Work Permit Form',
              icon: Icons.work,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WorkPermitFormScreen(),
                  ),
                );
              },
            ),
            DashboardOption(
              title: 'Internship/Student Pass',
              icon: Icons.school,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StudentPassForm()),
                );
              },
            ),
            DashboardOption(
              title: 'Multiple Journey Visa Forms',
              icon: Icons.airplane_ticket,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PersonalVisaInfoScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardOption extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  DashboardOption(
      {required this.title, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.green[800],
          size: 30,
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 18),
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}

class AccountDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Details'),
      ),
      body: const Center(
        child: Text('Account Details Screen'),
      ),
    );
  }
}
