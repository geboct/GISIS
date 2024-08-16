import 'package:flutter/material.dart';
import 'package:gsis/widgets/dblink.dart';
import 'package:gsis/widgets/toastmessage.dart';
import 'package:http/http.dart' as http;

class NewEmigrantOrImmigrantScreen extends StatefulWidget {
  final String type;

  NewEmigrantOrImmigrantScreen({required this.type});

  @override
  State<NewEmigrantOrImmigrantScreen> createState() =>
      _NewEmigrantOrImmigrantScreenState();
}

class _NewEmigrantOrImmigrantScreenState
    extends State<NewEmigrantOrImmigrantScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _passportNumberController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _yellowFeverCardController =
      TextEditingController();
  final TextEditingController _visaController = TextEditingController();
  String _yellowFeverCard = 'Valid';
  String _visa = 'Valid';
  bool registering = false;

  void _registerUser(context) async {
    try {
      setState(() {
        registering = true;
      });
      if (_formKey.currentState!.validate()) {
        String url = DBLink().showDBLink('insertNewDocument');
        final response = await http.post(Uri.parse(url), body: {
          'type': widget.type,
          'passportNumber': _passportNumberController.text,
          'name': _nameController.text,
          'yellowFeverCard': _yellowFeverCardController.text,
          'visa': _visaController.text,
        });
        if (response.statusCode == 200) {
          // Handle successful registration
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('New ${widget.type} registered successfully.'),
          ));
          setState(() {
            registering = false;
          });
        } else {
          setState(() {
            registering = false;
          });
          // Handle errors
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:
                  Text('Failed to register ${widget.type}. Please try again.'),
            ),
          );
        }
      }
    } catch (e) {
      ShowToastMessage().showMessage(message: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white,
        ),
        backgroundColor: Colors.green.shade900,
        title: Text(
          'Register New ${widget.type}',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                height: 50,
                child: TextFormField(
                  controller: _passportNumberController,
                  decoration: const InputDecoration(
                    labelText: 'Passport Number',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a passport number';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 50,
                child: TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 55,
                child: DropdownButtonFormField<String>(
                  value: _yellowFeverCard,
                  decoration: const InputDecoration(
                    labelText: 'Yellow Fever Card',
                    border: OutlineInputBorder(),
                  ),
                  items: ['Valid', 'Invalid'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _yellowFeverCard = value!;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select yellow fever card details';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 55,
                child: DropdownButtonFormField<String>(
                  value: _visa,
                  decoration: const InputDecoration(
                    labelText: 'Visa',
                    border: OutlineInputBorder(),
                  ),
                  items: ['Valid', 'Invalid'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _visa = value!;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select visa details';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  if (_passportNumberController.text.isEmpty) {
                    ShowToastMessage()
                        .showMessage(message: 'Passport Number is required');
                    return;
                  }
                  if (_nameController.text.isEmpty) {
                    ShowToastMessage().showMessage(
                        message: 'Name of Passport Holder is required');
                    return;
                  }
                  _registerUser(context);
                },
                child: registering
                    ? CircularProgressIndicator()
                    : Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.green.shade900,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            )),
                        child: Center(
                          child: Text(
                            'Register ${widget.type}',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
