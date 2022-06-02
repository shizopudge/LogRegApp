import 'package:flutter/material.dart';
import 'package:logregapp/authService.dart';
import 'package:logregapp/landing.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'appUser.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(LogRegApp());
}

class LogRegApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<appUser?>.value(
      value: AuthService().currentUser,
      initialData: null,
      child: MaterialApp(
          title: 'Log/Reg App',
          theme: ThemeData(
            primaryColor: Color.fromRGBO(50, 65, 85, 1),
            textTheme: TextTheme(subtitle1: TextStyle(color: Colors.white)),
          ),
          home: Landing()),
    );
  }
}
