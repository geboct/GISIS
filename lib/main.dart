import 'package:flutter/material.dart';
import 'package:gsis/provider/userProvider.dart';
import 'package:gsis/screens/login.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    OKToast(
      child: MultiProvider(providers: [
        ChangeNotifierProvider(create: (_) => LoggedInUserProvider()),
      ], child: const MyApp()),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the entry of the application
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GSIS',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginScreen(),//Navigates to the login screen

    );
  }
}
