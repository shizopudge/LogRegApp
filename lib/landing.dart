// ignore_for_file: unused_local_variable, prefer_const_declarations

import 'package:flutter/material.dart';
import 'auth.dart';
import 'home.dart';
import 'appUser.dart';
import 'package:provider/provider.dart';

class Landing extends StatelessWidget {
  const Landing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appUser? user = Provider.of<appUser?>(context);
    final bool isLogedIn = user != null;

    return isLogedIn ? HomePage() : AuthPage();
  }
}
