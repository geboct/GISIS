import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gsis/models/documentModel.dart';
import 'package:gsis/screens/admin/addNewEmigrantOrImmigrant.dart';
import 'package:gsis/widgets/dblink.dart';
import 'package:http/http.dart' as http;

class ViewImmigrants extends StatefulWidget {
  const ViewImmigrants({Key? key}) : super(key: key);

  @override
  State<ViewImmigrants> createState() => _ViewImmigrantsState();
}

class _ViewImmigrantsState extends State<ViewImmigrants> {
  TextEditingController searchUserController = TextEditingController();
  bool gettingImmigrants = false;
  List<DocumentModel> allImmigrants = [];
  List<DocumentModel> searchedImmigrants = [];

  @override
  void initState() {
    super.initState();
    getImmigrants();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white,
        ),
        backgroundColor: Colors.green.shade900,
        title: const Text(
          'Immigrants Management',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () => getImmigrants(),
            icon: const Icon(
              Icons.refresh,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: gettingImmigrants
          ? const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            Text('Getting Immigrants'),
          ],
        ),
      )
          : Column(
        children: [
          Container(
            height: 50,
            margin: const EdgeInsets.only(top: 10, left: 16, right: 16),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: TextFormField(
              controller: searchUserController,
              onChanged: (val) => searchUser(),
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                labelText: 'Search Immigrant',
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: searchedImmigrants.isEmpty
                ? const Center(
              child: Text('No Immigrants found.'),
            )
                : ListView.builder(
              itemCount: searchedImmigrants.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.person),
                    title: Text(searchedImmigrants[index].name),
                    subtitle: Text(
                        searchedImmigrants[index].passportNumber),
                    trailing: PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == 'view') {
                          _viewUser(
                              context, searchedImmigrants[index]);
                        } else if (value == 'edit') {
                          _editUser(
                              context, searchedImmigrants[index]);
                        } else if (value == 'delete') {
                          _deleteUser(
                              context, searchedImmigrants[index]);
                        }
                      },
                      itemBuilder: (BuildContext context) {
                        return [
                          const PopupMenuItem<String>(
                            value: 'view',
                            child: Text('View'),
                          ),
                          const PopupMenuItem<String>(
                            value: 'edit',
                            child: Text('Edit'),
                          ),
                          const PopupMenuItem<String>(
                            value: 'delete',
                            child: Text('Delete'),
                          ),
                        ];
                      },
                    ),
                    onTap: () {
                      _viewUser(context, searchedImmigrants[index]);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        hoverColor: Colors.green.shade900,
        elevation: 1,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  NewEmigrantOrImmigrantScreen(type: 'Immigrant'),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _viewUser(BuildContext context, DocumentModel user) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('User Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name: ${user.name}'),
              Text('Passport Number: ${user.passportNumber}'),
              Text('Yellow Fever Card: ${user.yellowFeverCard}'),
              Text('Visa: ${user.visa}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _editUser(BuildContext context, DocumentModel user) {
    final _formKey = GlobalKey<FormState>();
    String name = user.name;
    String passportNumber = user.passportNumber;
    String yellowFeverCard = user.yellowFeverCard;
    String visa = user.visa;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit User'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  initialValue: name,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    name = value!;
                  },
                ),
                TextFormField(
                  initialValue: passportNumber,
                  decoration:
                  const InputDecoration(labelText: 'Passport Number'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a passport number';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    passportNumber = value!;
                  },
                ),
                TextFormField(
                  initialValue: yellowFeverCard,
                  decoration:
                  const InputDecoration(labelText: 'Yellow Fever Card'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter yellow fever card details';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    yellowFeverCard = value!;
                  },
                ),
                TextFormField(
                  initialValue: visa,
                  decoration: const InputDecoration(labelText: 'Visa'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter visa details';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    visa = value!;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  // Perform edit operation and update the user details
                  Navigator.pop(context);
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _deleteUser(BuildContext context, DocumentModel user) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Document'),
          content: Text('Are you sure you want to delete ${user.name}?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {

                // Perform delete operation
                bool success = await _deleteDocument(user.passportNumber);

                if (success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Document deleted successfully')),
                  );
                  // Refresh the list of emigrants after deletion
                  getImmigrants();
                  Navigator.pop(context); // Close the alert dialog

                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to delete document')),
                  );
                }
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  Future<bool> _deleteDocument(String passportNumber) async {
    try {
      String url = DBLink().showDBLink('deleteDocument');
      final response = await http.post(
        Uri.parse(url),
        body: {
          'passportNumber': passportNumber,
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return responseData['success'];
      } else {
        throw Exception('Failed to delete document');
      }
    } catch (e) {
      print('Error deleting document: $e');
      return false;
    }
  }


  void searchUser() {
    List<DocumentModel> searchResults = [];
    if (searchUserController.text.isEmpty) {
      searchResults = allImmigrants;
    } else {
      searchResults = allImmigrants
          .where((user) =>
      user.passportNumber.toLowerCase().contains(
        searchUserController.text.toLowerCase(),
      ) ||
          user.name
              .toLowerCase()
              .contains(searchUserController.text.toLowerCase()))
          .toList();
    }
    setState(() {
      searchedImmigrants = searchResults;
    });
  }

  void getImmigrants() async {
    setState(() {
      gettingImmigrants = true;
    });

    String url = DBLink().showDBLink('getAllImmigrants');
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<DocumentModel> allImmigrantsFromDB = [];
        List responseData = jsonDecode(response.body) as List;
        for (int i = 0; i < responseData.length; i++) {
          allImmigrantsFromDB.add(
            DocumentModel(
              passportNumber: responseData[i]['passportNumber'],
              name: responseData[i]['name'],
              yellowFeverCard: responseData[i]['yellowFeverCard'],
              visa: responseData[i]['visa'],
              type: responseData[i]['type'],
              status: responseData[i]['status'],
            ),
          );
        }
        setState(() {
          allImmigrants = allImmigrantsFromDB;
          searchedImmigrants = allImmigrantsFromDB;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Server error: ${response.statusCode}')),
        );
      }
    } catch (e) {
      print('Exception occurred while fetching Immigrants: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Exception occurred while fetching Immigrants.')),
      );
    } finally {
      setState(() {
        gettingImmigrants = false;
      });
    }
  }
}
