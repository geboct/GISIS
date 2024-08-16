import 'dart:convert'; // For JSON decoding

import 'package:flutter/material.dart';
import 'package:gsis/widgets/dblink.dart';
import 'package:http/http.dart' as http;

import '../../models/imigrantprofile.dart';
import 'edit_profile.dart'; // Make sure this is correctly implemented

class ImmigrantProfileScreen extends StatefulWidget {
  final String immigrantId;

  const ImmigrantProfileScreen({Key? key, required this.immigrantId})
      : super(key: key);

  @override
  _ImmigrantProfileScreenState createState() => _ImmigrantProfileScreenState();
}

class _ImmigrantProfileScreenState extends State<ImmigrantProfileScreen> {
  bool _isLoading = false;
  ImmigrantProfile? profileDetails;

  @override
  void initState() {
    super.initState();
    _fetchImmigrantProfile(widget.immigrantId);
  }

  Future<void> _fetchImmigrantProfile(String immigrantId) async {
    try {
      setState(() {
        _isLoading = true;
      });
      final response = await http.post(
        Uri.parse(DBLink().showDBLink('get_immigrant_profile')),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'immigrant_id': immigrantId,
        }),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Parsed data: $data');

        setState(() {
          profileDetails = ImmigrantProfile.fromJson(data);
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
        throw Exception('Failed to load profile');
      }
    } catch (error) {
      print('Error: $error');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Immigrant Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              if (profileDetails != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfileScreen(
                      profile:profileDetails!,
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : profileDetails == null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('No detail Found'),
                      TextButton(
                        onPressed: () =>
                            _fetchImmigrantProfile(widget.immigrantId),
                        child: Text('Refresh'),
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView(
                    children: [
                      _buildDetailText(
                          'Immigrant ID:', profileDetails!.immigrantId),
                      _buildDetailText('Name:', profileDetails!.name),
                      _buildDetailText(
                          'Nationality:', profileDetails!.nationality),
                      _buildDetailText('Email:', profileDetails!.email),
                      _buildDetailText(
                          'Place of Birth:', profileDetails!.placeOfBirth),
                      _buildDetailText(
                          'Date of Birth:', profileDetails!.dateOfBirth),
                      _buildDetailText(
                          'Passport:', profileDetails!.passportNumber),
                      _buildDetailText(
                          'Phone Number:', profileDetails!.phoneNumber),
                    ],
                  ),
                ),
    );
  }

  Widget _buildDetailText(String label, String value) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Card(
          child: ListTile(
            title: Text(
              '$label $value',
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ));
  }
}
