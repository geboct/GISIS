import 'dart:convert'; // For JSON decoding

import 'package:flutter/material.dart';
import 'package:gsis/widgets/dblink.dart';
import 'package:http/http.dart' as http;

class ViewCitizenshipFormEntries extends StatefulWidget {
  const ViewCitizenshipFormEntries({super.key});

  @override
  State<ViewCitizenshipFormEntries> createState() =>
      _ViewCitizenshipFormEntriesState();
}

class _ViewCitizenshipFormEntriesState
    extends State<ViewCitizenshipFormEntries> {
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
          DBLink().showDBLink('get_citizenship_entries'),
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
        title: const Text('Citizenship Form Entries'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _hasError
              ? Center(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Failed to load data.'),
                    TextButton(
                      onPressed: () => _fetchEntries(),
                      child: Text('Refresh'),
                    ),
                  ],
                ))
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
                          'Passport Number: ${entry['passport_number'] ?? 'N/A'}\n'
                          'Nationality: ${entry['nationality'] ?? 'N/A'}',
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
            _buildDetailText('Full Name:', entry?['full_name']),
            _buildDetailText('Date of Birth:', entry?['date_of_birth']),
            _buildDetailText('Place of Birth:', entry?['place_of_birth']),
            _buildDetailText('Gender:', entry?['gender']),
            _buildDetailText('Marital Status:', entry?['marital_status']),
            _buildDetailText('Nationality:', entry?['nationality']),
            _buildDetailText('Passport Number:', entry?['passport_number']),
            _buildDetailText('Date of Issue:', entry?['date_of_issue']),
            _buildDetailText('Expiry Date:', entry?['expiry_date']),
            _buildDetailText('Place of Issue:', entry?['place_of_issue']),
            _buildDetailText('Occupation:', entry?['occupation']),
            _buildDetailText(
                'Contact Person Name:', entry?['contact_person_name']),
            _buildDetailText(
                'Contact Person Phone:', entry?['contact_person_phone']),
            SizedBox(height: 20),
            // Display photos if available
            if (entry?['passport_photo_path'] != null)
              Image.network(GetImagesLink()
                  .showDBLink(imagePath: entry!['passport_photo_path'])),
            if (entry?['nationality_id_path'] != null)
              Image.network(entry!['nationality_id_path']),
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
