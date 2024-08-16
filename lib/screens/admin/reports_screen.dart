/*
import 'dart:convert';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:gsis/widgets/dblink.dart';
import 'package:http/http.dart' as http;

class ReportsScreen extends StatefulWidget {
  @override
  _ReportsScreenState createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  String selectedReportType = 'Daily'; // Default report type
  bool isLoading = false;
  List<Map<String, dynamic>> reportData = [];

  @override
  void initState() {
    super.initState();
    _fetchReportData(selectedReportType);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reports'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Filters for generating reports
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  value: selectedReportType,
                  hint: Text('Select Report Type'),
                  items: <String>['Daily', 'Monthly', 'Yearly']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedReportType = value!;
                      isLoading = true;
                    });
                    _fetchReportData(value!);
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isLoading = true;
                    });
                    _fetchReportData(selectedReportType);
                  },
                  child: Text('Generate Report'),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Placeholder for charts and data tables
            Expanded(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: reportData.length,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              reportData[index]['label'],
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            // Example chart
                            Container(
                              height: 200,
                              child: charts.BarChart(
                                _createSampleData(reportData[index]),
                                animate: true,
                              ),
                            ),
                            SizedBox(height: 20),
                            // Example data table
                            DataTable(
                              columns: [
                                DataColumn(label: Text('Field')),
                                DataColumn(label: Text('Value')),
                              ],
                              rows: [
                                DataRow(cells: [
                                  DataCell(Text('Value')),
                                  DataCell(Text(
                                      reportData[index]['value'].toString())),
                                ]),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // Sample data for charts
  List<charts.Series<ReportData, String>> _createSampleData(
      Map<String, dynamic> data) {
    final reportData = [
      ReportData(data['label'], data['value']),
    ];

    return [
      charts.Series<ReportData, String>(
        id: 'Reports',
        domainFn: (ReportData data, _) => data.label,
        measureFn: (ReportData data, _) => data.value,
        data: reportData,
      )
    ];
  }

  // Fetch report data from PHP endpoint
  Future<void> _fetchReportData(String reportType) async {
    final url = Uri.parse(
      DBLink().showDBLink('getReportData'),
    );
    print('Fetching data from URL: $url with report type: $reportType');
    final response = await http.post(
      url,
      body: {'reportType': reportType},
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if (responseData['success']) {
        List<dynamic> data = responseData['data'];
        setState(() {
          reportData = List<Map<String, dynamic>>.from(
              data.map((item) => Map<String, dynamic>.from(item)));
          isLoading = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseData['message'])),
        );
        setState(() {
          isLoading = false;
        });
      }
    } else {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch data: ${response.statusCode}')),
      );
      setState(() {
        isLoading = false;
      });
    }
  }
}

class ReportData {
  final String label;
  final int value;

  ReportData(this.label, this.value);
}
*/
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gsis/widgets/dblink.dart';
import 'package:gsis/widgets/toastmessage.dart';
import 'package:http/http.dart' as http;

class ReportsScreen extends StatefulWidget {
  @override
  _ReportsScreenState createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  String selectedReportType = 'Daily'; // Default report type
  bool isLoading = false;
  List<Map<String, dynamic>> reportData = [];

  @override
  void initState() {
    super.initState();
    _fetchReportData(selectedReportType);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reports'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Filters for generating reports
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  value: selectedReportType,
                  hint: Text('Select Report Type'),
                  items: <String>['Daily', 'Monthly', 'Yearly']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedReportType = value!;
                      isLoading = true;
                    });
                    _fetchReportData(value!);
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isLoading = true;
                    });
                    _fetchReportData(selectedReportType);
                  },
                  child: Text('Generate Report'),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Placeholder for charts and data tables
            Expanded(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: reportData.length,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              reportData[index]['label'],
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            // Example chart
                           /* Container(
                              height: 200,
                              child: charts.BarChart(
                                _createSampleData(reportData[index]),
                                animate: true,
                              ),
                            ),*/
                            SizedBox(height: 20),
                            // Example data table
                            DataTable(
                              columns: [
                                DataColumn(label: Text('Field')),
                                DataColumn(label: Text('Value')),
                              ],
                              rows: [
                                DataRow(cells: [
                                  DataCell(Text('Total')),
                                  DataCell(Text(
                                      reportData[index]['total'].toString())),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text('Approved')),
                                  DataCell(Text(reportData[index]['approved']
                                      .toString())),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text('Rejected')),
                                  DataCell(Text(reportData[index]['rejected']
                                      .toString())),
                                ]),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
/*
  // Sample data for charts
  List<charts.Series<ReportData, String>> _createSampleData(
      Map<String, dynamic> data) {
    final reportData = [
      ReportData('Total', data['total']),
      ReportData('Approved', data['approved']),
      ReportData('Rejected', data['rejected']),
    ];

    return [
      charts.Series<ReportData, String>(
        id: 'Reports',
        domainFn: (ReportData data, _) => data.label,
        measureFn: (ReportData data, _) => data.value,
        data: reportData,
      )
    ];
  }*/

  // Fetch report data from PHP endpoint
  Future<void> _fetchReportData(String reportType) async {
    final url = Uri.parse(
      DBLink().showDBLink('getReportData'),
    );
    ShowToastMessage().showMessage(
        message: 'Fetching data with report type: $reportType');
    final response = await http.post(
      url,
      body: {'reportType': reportType},
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if (responseData['success']) {
        List<dynamic> data = responseData['data'];
        setState(() {
          reportData = List<Map<String, dynamic>>.from(
              data.map((item) => Map<String, dynamic>.from(item)));
          isLoading = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseData['message'])),
        );
        setState(() {
          isLoading = false;
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch data: ${response.statusCode}')),
      );
      setState(() {
        isLoading = false;
      });
    }
  }
}

class ReportData {
  final String label;
  final int value;

  ReportData(this.label, this.value);
}
