import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gsis/models/user_model.dart';
import 'package:gsis/screens/admin/addNewEmployee.dart';
import 'package:gsis/widgets/dblink.dart';
import 'package:gsis/widgets/toastmessage.dart';
import 'package:http/http.dart' as http;

class EmployeeManagementScreen extends StatefulWidget {
  const EmployeeManagementScreen({super.key});

  @override
  State<EmployeeManagementScreen> createState() =>
      _EmployeeManagementScreenState();
}

class _EmployeeManagementScreenState extends State<EmployeeManagementScreen> {
  TextEditingController searchUserController = TextEditingController();
  bool gettingEmployees = false, addingEmployee = false;
  List<UserModel> allEmployees = [];

  List<UserModel> searchedEmployees = [];

  @override
  void initState() {
    searchUser();
    getEmployees(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white,
        ),
        backgroundColor: Colors.green.shade900,
        title: const Text(
          'Employee Management',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () => getEmployees(context),
            icon: const Icon(
              Icons.refresh,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: gettingEmployees
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  Text('Getting Employees'),
                ],
              ),
            )
          : addingEmployee
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                    ],
                  ),
                )
              : Column(
                  children: [
                    allEmployees.isEmpty
                        ? Container()
                        : Container(
                            height: 50,
                            margin: const EdgeInsets.only(
                                top: 10, left: 16, right: 16),
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
                                  labelText: 'Search employee'),
                            ),
                          ),
                    const SizedBox(
                      height: 15,
                    ),
                    Expanded(
                      child: Card(
                        color: Colors.white,
                        child: ListView.builder(
                          itemCount: searchedEmployees.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                leading: const Icon(Icons.person),
                                title: Text(searchedEmployees[index].name),
                                subtitle: Text(searchedEmployees[index].email),
                                trailing: PopupMenuButton<String>(
                                  onSelected: (value) {
                                    if (value == 'view') {
                                      _viewUser(
                                          context, searchedEmployees[index]);
                                    } else if (value == 'edit') {
                                      _editUser(
                                          context, searchedEmployees[index]);
                                    } else if (value == 'delete') {
                                      _deleteUserDialog(
                                          context, searchedEmployees[index]);
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
                                  _viewUser(context, searchedEmployees[index]);
                                },
                              ),
                            );
                          },
                        ),
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
              builder: (context) => AddEmployeeScreen(),
            ),
          );
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }

  void _viewUser(BuildContext context, UserModel user) {
    // Handle view user
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
              Text('ID: ${user.id}'),
              Text('Name: ${user.name}'),
              Text('Email: ${user.email}'),
              Text('Phone: ${user.phone}'),
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

  void _editUser(BuildContext context, UserModel user) {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController idController = TextEditingController();
    // Handle edit user
    showDialog(
      context: context,
      builder: (context) {
        final _formKey = GlobalKey<FormState>();
        idController.text = user.id;
        nameController.text = user.name;
        emailController.text = user.email;
        phoneController.text = user.phone;

        return AlertDialog(
          title: const Text('Edit User'),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: idController,
                    enabled: false,
                    //initialValue: name,
                    decoration: const InputDecoration(labelText: 'User ID'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an ID';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      idController.text = value!;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: nameController,
                    //initialValue: name,
                    decoration: const InputDecoration(labelText: 'Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      nameController.text = value!;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: emailController,
                    // initialValue: email,
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an email';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      emailController.text = value!;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: phoneController,
                    //initialValue: phone,
                    decoration: const InputDecoration(labelText: 'Phone'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid Phone Number';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      phoneController.text = value!;
                    },
                  ),
                ],
              ),
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
                  updateUser(id: idController.text,fullName: nameController.text,
                     email:  emailController.text, phone :phoneController.text,context:context);
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _deleteUserDialog(BuildContext context, UserModel user) {
    // Handle delete user
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete User'),
          content: Text('Are you sure you want to delete ${user.name}?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                deleteUser(selectedUser: user);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  deleteUser({required UserModel selectedUser,context}) async {
    String url = DBLink().showDBLink('delete_user');
    try {
      final response =
          await http.post(Uri.parse(url), body: {'id': selectedUser.id});

      if (jsonDecode(response.body) == 'success') {
        Navigator.pop(context);

        getEmployees(context);
        ShowToastMessage()
            .showMessage(message: '${selectedUser.name} Deleted Successfully');
      }
    } catch (err) {
      ShowToastMessage().showMessage(message: 'Server Error');
    }
  }

  searchUser() {
    List<UserModel> searchResults = [];
    if (searchUserController.text.isEmpty) {
      searchResults = allEmployees;
    } else {
      for (var element in allEmployees) {
        if (element.name.toString().toLowerCase().contains(
              searchUserController.text.toLowerCase(),
            )) {
          searchResults.add(element);
        }
      }
    }
    setState(() {
      searchedEmployees = searchResults;
    });
  }

  getEmployees(context) async {
    setState(() {
      gettingEmployees = true;
    });
    String url = DBLink().showDBLink('getAllEMployees');
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List employeesFromDB = [];

      final responseData = jsonDecode(response.body);
      allEmployees.clear();
      if (responseData['success']) {
        employeesFromDB = responseData['employees'];

        for (int i = 0; i < employeesFromDB.length; i++) {
          allEmployees.add(
            UserModel(
              id: employeesFromDB[i]['id'],
              name: employeesFromDB[i]['name'],
              email: employeesFromDB[i]['email'],
              phone: employeesFromDB[i]['phone'],
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseData['message'])),
        );
      }
      setState(() {
        gettingEmployees = false;
      });
    } else {
      setState(() {
        gettingEmployees = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Server error: ${response.statusCode}')),
      );
    }
  }

  void updateUser(
      {required String id,
      required String fullName,
      required String email,
      required String phone,required context}) async {
    try {
      setState(() {
        gettingEmployees = true;
      });
      String url = DBLink().showDBLink('update_user');
      final response = await http.post(
        Uri.parse(url),
        body: {
          'id': id.toString(),
          'name': fullName.toString(),
          'email': email.toString(),
          'phone': phone.toString(),
        },
      );
      if (json.decode(response.body)['success'].toString() == 'true') {
        Navigator.pop(context);

        // Show success message or handle success case
        ShowToastMessage().showMessage(message: 'User updated successfully');
        setState(() {
          gettingEmployees = false;
        });
      } else {
        // Show error message or handle error case
        ShowToastMessage().showMessage(message: 'Failed to update User');

        setState(() {
          gettingEmployees = false;
        });
      }
    } catch (e) {
      ShowToastMessage().showMessage(message: 'Server Error');

      setState(() {
        gettingEmployees = false;
      });
      // Handle other exceptions
    }
  }
}
