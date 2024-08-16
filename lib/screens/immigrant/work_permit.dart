import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gsis/provider/userProvider.dart';
import 'package:gsis/widgets/dblink.dart';
import 'package:gsis/widgets/toastmessage.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:path_provider_windows/path_provider_windows.dart';
import 'package:provider/provider.dart';

class WorkPermitFormScreen extends StatefulWidget {
  @override
  _WorkPermitFormScreenState createState() => _WorkPermitFormScreenState();
}

class _WorkPermitFormScreenState extends State<WorkPermitFormScreen> {
  PathProviderWindows pathProviderWindows = PathProviderWindows();
  bool processing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.white,),
        backgroundColor: Colors.green.shade900,
        title: const Text(
          'Work Permit Form',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            processing == true
                ? const Column(
                    children: [
                      CircularProgressIndicator(),
                      Text('Downloading...'),
                    ],
                  )
                : ElevatedButton(
                    onPressed: _downloadTemplate,
                    child: const Text('Download Work Permit Form'),
                  ),
            const SizedBox(
              height: 20,
            ),
            processing == true
                ? const Column(
                    children: [
                      CircularProgressIndicator(),
                      Text('Uploading...'),
                    ],
                  )
                : ElevatedButton(
                    onPressed: () => _uploadFilledForm(context),
                    child: const Text('Upload Filled Work Permit Form'),
                  ),
          ],
        ),
      ),
    );
  }

  Future<void> _downloadTemplate() async {
    final url =
        '${ServerLink().showDBLink()}workpermit/file/WORK-PERMIT-APPLICATION-FORM.pdf';
    try {
      setState(() {
        processing = true;
      });
      if (Platform.isAndroid) {
        Directory appDocDir = await getApplicationDocumentsDirectory();

        String appDocPath = appDocDir.path;

        // Create the file path
        String filePath = '$appDocPath/WORK-PERMIT-APPLICATION-FORM.pdf';

        // Download the file
        var response = await http.get(Uri.parse(url));
        File file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);
        setState(() {
          processing = false;
        });
        ShowToastMessage().showMessage(message: 'File downloaded to $filePath');
      } else if (Platform.isWindows) {
        String filePath =
            '${await pathProviderWindows.getDownloadsPath()}/WORK-PERMIT-APPLICATION-FORM.pdf';

        // Download the file
        var response = await http.get(Uri.parse(url));
        File file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);
        ShowToastMessage().showMessage(message: 'File downloaded to $filePath');
        setState(() {
          processing = false;
        });
      }
    } catch (e) {
      setState(() {
        processing = false;
      });
      // Handle any errors
      ShowToastMessage().showMessage(message: 'Error downloading file');
    }
  }

  Future<void> _uploadFilledForm(context) async {
    try {
      setState(() {
        processing = true;
      });
      // Pick the file
      FilePickerResult? result = await FilePicker.platform
          .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
      if (result != null) {
        File file = File(result.files.single.path!);
        String fileName = file.path.split('/').last;

        // Prepare the file to upload
        var request = http.MultipartRequest('POST',
            Uri.parse('${ServerLink().showDBLink()}upload_work_permit.php'));
        request.files.add(
            await http.MultipartFile.fromPath('work_permit_file', file.path));
        request.fields['immigrant_id'] =
            Provider.of<LoggedInUserProvider>(context, listen: false)
                .user
                .id; // replace with actual immigrant_id

        // Send the file
        var response = await request.send();

        if (response.statusCode == 200) {
          ShowToastMessage().showMessage(message: 'File uploaded successfully');
          setState(() {
            processing = false;
          });
        } else {
          ShowToastMessage().showMessage(message: 'Failed to upload file');
          setState(() {
            processing = false;
          });
        }
      } else {
        setState(() {
          processing = false;
        });
        ShowToastMessage().showMessage(message: 'No file selected');
      }
    } catch (e) {
      setState(() {
        processing = false;
      });
      ShowToastMessage().showMessage(message: 'Error uploading file');
    }
  }
}
