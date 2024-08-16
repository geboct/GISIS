import 'package:flutter/material.dart';
import 'package:gsis/models/logged_in_user_model.dart';
import 'package:gsis/provider/userProvider.dart';
import 'package:gsis/screens/admin/employee_management.dart';
import 'package:gsis/screens/admin/view_citizenship_form_entries.dart';
import 'package:gsis/screens/admin/view_internship_pass_entries.dart';
import 'package:gsis/screens/admin/view_multiple_journey_visa_entries.dart';
import 'package:gsis/screens/admin/view_work_permit_entries.dart';
import 'package:provider/provider.dart';

import '../login.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  LoggedInUserModel? user;

  @override
  Widget build(BuildContext context) {
    user = Provider.of<LoggedInUserProvider>(context, listen: false).user;
    return Scaffold(
      backgroundColor: Colors.green.shade900,
      body: Column(
        children: [
          SafeArea(
            child: Container(
              height: 120,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Text(
                            'Welcome ${user!.fullName.toString().toUpperCase()}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.green.shade900,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines:
                                2, // Adjust this if you want to allow more lines
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Text(
                            'Mail: ${user!.email}\nID: ${user!.id}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.green.shade900,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    margin: EdgeInsets.only(right: 30),
                    color: Colors.white,
                    child: Image.asset('assets/images/gis.png'),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 10,
            decoration: BoxDecoration(color: Colors.white),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                children: [
                  _buildDashboardCard(
                    context,
                    icon: Icons.people,
                    title: 'User Management',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const EmployeeManagementScreen(),
                        ),
                      );
                    },
                  ),
                  /*_buildDashboardCard(
                    context,
                    icon: Icons.description,
                    title: 'Document Verification',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DocumentVerificationScreen(),
                        ),
                      );
                    },
                  ),*/
                  _buildDashboardCard(
                    context,
                    icon: Icons.card_membership,
                    title: 'Citizenship Forms',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewCitizenshipFormEntries(),
                        ),
                      );
                    },
                  ),
                  _buildDashboardCard(
                    context,
                    icon: Icons.work,
                    title: 'Work Permits',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewWorkPermitEntries(),
                        ),
                      );
                    },
                  ),
                  _buildDashboardCard(
                    context,
                    icon: Icons.school,
                    title: 'Internship/Student Pass',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewInternshipPassEntries(),
                        ),
                      );
                    },
                  ),
                  _buildDashboardCard(
                    context,
                    icon: Icons.airplane_ticket,
                    title: 'Multiple Journey Visas',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ViewMultipleJourneyVisaEntries(),
                        ),
                      );
                    },
                  ),
                  /*_buildDashboardCard(
                    context,
                    icon: Icons.bar_chart,
                    title: 'Reports',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReportsScreen(),
                        ),
                      );
                    },
                  ),*/
                  _buildDashboardCard(
                    context,
                    icon: Icons.logout,
                    title: 'Logout',
                    onTap: () async {
                      // Navigate to login screen
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                        (Route<dynamic> route) => false,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 35,
                color: Colors.green.shade900,
              ),
              const SizedBox(height: 16),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
