import 'package:flutter/material.dart';

class SupportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Support/Help Desk'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Contact Information:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Phone: +1234567890'),
            Text('Email: support@immigrationservice.com'),
            SizedBox(height: 20),
            Text(
              'Frequently Asked Questions (FAQs):',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  ExpansionTile(
                    title: Text('How do I apply for a visa?'),
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'To apply for a visa, you need to fill out the visa application form, gather required documents, and submit your application to the immigration office.',
                        ),
                      ),
                    ],
                  ),
                  ExpansionTile(
                    title: Text('What is the processing time for an application?'),
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'The processing time for applications varies depending on the type of application and current workload. You can check the status of your application in the Application Status section.',
                        ),
                      ),
                    ],
                  ),
                  ExpansionTile(
                    title: Text('How can I renew my visa?'),
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'You can renew your visa by submitting a visa renewal application form and required documents to the immigration office before the expiration date of your current visa.',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
