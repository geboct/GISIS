import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gsis/screens/admin/admin_dashboard_screen.dart';
import 'package:gsis/screens/immigrant/immigrant_dashboard.dart';
import 'package:gsis/screens/signup/signup_screen1.dart';
import 'package:gsis/widgets/dblink.dart';
import 'package:gsis/widgets/toastmessage.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../models/logged_in_user_model.dart';
import '../provider/userProvider.dart';
import '../services/authservice.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isLoading = false;
  bool _obscurePassword = true;

  String _userType = 'Admin'; // Default selection for dropdown

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 100,
                  child: Image.asset('assets/images/gis.png'),
                ),
                const Card(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        'Welcome to Ghana Immigration Service \nInformation Service',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 50),
                  height: 50,
                  child: TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  height: 50,
                  child: TextField(
                    onEditingComplete: () {
                      login();
                    },
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: const OutlineInputBorder(),
                      suffix: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                        icon: Icon(!_obscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                    ),
                    obscureText: _obscurePassword,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  height: 50,
                  child: DropdownButtonFormField<String>(
                    value: _userType,
                    items: <String>['Admin', 'Immigrant'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _userType = newValue!;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'User Type',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                _isLoading
                    ? const CircularProgressIndicator()
                    : InkWell(
                        onTap: () {
                          if (_emailController.text.isEmpty ||
                              _passwordController.text.isEmpty) {
                            ShowToastMessage()
                                .showMessage(message: 'Fields cannot be empty');
                            return;
                          }
                          login();
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(50),
                              ),
                              color: Colors.green[900]),
                          child: const Center(
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                const SizedBox(height: 10),
                _isLoading == true
                    ? Container()
                    : InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignupScreen1(),
                            ),
                          );
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(50),
                              ),
                              color: Colors.green[900]),
                          child: const Center(
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                  color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }

  login() async {
    setState(() {
      _isLoading = true;
    });

    try {
      String endpoint = _userType == 'Admin' ? 'login' : 'immigrantlogin';
      String url = DBLink().showDBLink(endpoint);

      final response = await http.post(Uri.parse(url), body: {
        'username': _emailController.text,
        'password': _passwordController.text,
      });


      if (jsonDecode(response.body)['success'].toString().toLowerCase() ==
          'true') {
        Provider.of<LoggedInUserProvider>(context, listen: false).addLoggedInUser(
          LoggedInUserModel(
            id: jsonDecode(response.body)['user']['id'].toString(),
            username: jsonDecode(response.body)['user']['username'] ?? '',
            fullName: jsonDecode(response.body)['user']['name'] ?? jsonDecode(response.body)['user']['fullName'],
            email: jsonDecode(response.body)['user']['email'] ?? '',
          ),
        );
        setState(() {
          _isLoading = true;
        });
        if (!mounted) return;
        if (_userType.toString().toUpperCase() == 'ADMIN') {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const AdminDashboardScreen(),
              ),
              (route) => false);
        } else if (_userType.toString().toUpperCase() == 'IMMIGRANT') {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => ImmigrantDashboard(),
              ),
              (route) => false);
        }
      } else {
        ShowToastMessage().showMessage(message: 'Incorrect credentials');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Server / Network Error\n Please check network and try again')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
