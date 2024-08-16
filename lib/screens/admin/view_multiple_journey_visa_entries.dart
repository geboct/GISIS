import 'dart:convert'; // For JSON decoding

import 'package:flutter/material.dart';
import 'package:gsis/widgets/dblink.dart';
import 'package:http/http.dart' as http;

class ViewMultipleJourneyVisaEntries extends StatefulWidget {
  const ViewMultipleJourneyVisaEntries({super.key});

  @override
  State<ViewMultipleJourneyVisaEntries> createState() =>
      _ViewMultipleJourneyVisaEntriesState();
}

class _ViewMultipleJourneyVisaEntriesState
    extends State<ViewMultipleJourneyVisaEntries> {
  List<Map<String, dynamic>> _entries = [];
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _fetchEntries();
  }

  Future<void> _fetchEntries() async {
    try {
      final response = await http.get(
        Uri.parse(
          DBLink().showDBLink('get_multiple_visa_entries'),
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          _entries = data.map((item) => item as Map<String, dynamic>).toList();
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
        _hasError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Multiple Journey Visa Entries'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _hasError
              ? Center(child: Text('Failed to load data.'))
              : ListView.builder(
                  itemCount: _entries.length,
                  itemBuilder: (context, index) {
                    final entry = _entries[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        title: Text(entry['full_name'] ?? 'Unknown'),
                        subtitle: Text(
                          'Application Number: ${entry['application_number'] ?? 'N/A'}\n'
                          'Visa Type: ${entry['type_of_visa'] ?? 'N/A'}\n'
                          'Email: ${entry['email'] ?? 'N/A'}',
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.visibility),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    EntryDetailScreen(entry: entry),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}

class EntryDetailScreen extends StatelessWidget {
  final Map<String, dynamic>? entry;

  const EntryDetailScreen({Key? key, this.entry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entry Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildDetailText(
                'Application Number:', entry?['application_number']),
            _buildDetailText('Visa Type:', entry?['type_of_visa']),
            _buildDetailText('Full Name:', entry?['full_name']),
            _buildDetailText('Gender:', entry?['gender']),
            _buildDetailText('Age:', entry?['age']),
            _buildDetailText('Nationality:', entry?['nationality']),
            _buildDetailText('Occupation:', entry?['occupation']),
            _buildDetailText('Country of Birth:', entry?['country_of_birth']),
            _buildDetailText(
                'Country of Residence:', entry?['country_of_residence']),
            _buildDetailText('Email:', entry?['email']),
            _buildDetailText('Passport Number:', entry?['passport_number']),
            _buildDetailText('Place of Issue:', entry?['place_of_issue']),
            _buildDetailText('Date of Issue:', entry?['date_of_issue']),
            _buildDetailText('Expiry Date:', entry?['expiry_date']),
            _buildDetailText('Reason for Entry:', entry?['reason_for_entry']),
            _buildDetailText(
                'Proposed Date of Entry:', entry?['proposed_date_of_entry']),
            _buildDetailText('Duration of Stay (in days):',
                entry?['duration_of_stay_in_days']),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailText(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        '$label ${value ?? 'N/A'}',
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
