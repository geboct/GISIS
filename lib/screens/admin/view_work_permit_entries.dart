import 'dart:convert'; // For JSON decoding
import 'package:flutter/material.dart';
import 'package:gsis/widgets/dblink.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class ViewWorkPermitEntries extends StatefulWidget {
  const ViewWorkPermitEntries({super.key});

  @override
  State<ViewWorkPermitEntries> createState() => _ViewWorkPermitEntriesState();
}

class _ViewWorkPermitEntriesState extends State<ViewWorkPermitEntries> {
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
        Uri.parse(DBLink().showDBLink('get_work_permit_entries')),
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
        title: const Text('Work Permit Entries'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _hasError
          ? const Center(child: Text('Failed to load data.'))
          : ListView.builder(
        itemCount: _entries.length,
        itemBuilder: (context, index) {
          final entry = _entries[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              title: Text('Immigrant ID: ${entry['immigrant_id'] ?? 'Unknown'}'),
              subtitle: Text('Upload Date: ${entry['upload_date'] ?? 'Unknown'}'),
              trailing: IconButton(
                icon: const Icon(Icons.visibility),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WorkPermitDetailScreen(entry: entry),
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

class WorkPermitDetailScreen extends StatelessWidget {
  final Map<String, dynamic>? entry;

  const WorkPermitDetailScreen({super.key, this.entry});

  Future<bool> requestPermission() async {
    PermissionStatus status = await Permission.mediaLibrary.request();

    if (status.isGranted) {
      return true;
    } else if (status.isDenied) {
      status = await Permission.storage.request();

      return false;
    } else if (status.isPermanentlyDenied) {
      openAppSettings(); // Prompt user to open settings
      return false;
    }

    return false;
  }

  Future<void> _downloadFile(BuildContext context, String fileUrl, String fileName) async {
    try {
      final hasPermission = await requestPermission();
      if (hasPermission) {
        // Get the external storage directory
        final directory = Directory('/storage/emulated/0/Download');
        final filePath = '${directory?.path}/$fileName';

        // Download the file
        final response = await http.get(Uri.parse(fileUrl));
        if (response.statusCode == 200) {
          final file = File(filePath);
          await file.writeAsBytes(response.bodyBytes);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Downloaded $fileName to $filePath')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to download file: ${response.reasonPhrase}')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Storage permission denied')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error downloading file: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final fileUrl = GetImagesLink().showDBLink(imagePath: entry?['file_path']);
    final fileName = fileUrl?.split('/').last ?? 'file.pdf'; // Extract file name

    return Scaffold(
      appBar: AppBar(
        title: const Text('Work Permit Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildDetailText('Immigrant ID:', entry?['immigrant_id']),
            _buildDetailText('File Path:', fileUrl),
            _buildDetailText('Upload Date:', entry?['upload_date']),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => _downloadFile(context, fileUrl ?? '', fileName),
              icon: const Icon(Icons.download),
              label: const Text('Download File'),
            ),
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
