// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, avoid_unnecessary_containers, sized_box_for_whitespace, use_function_type_syntax_for_parameters
import 'package:flutter/material.dart';
import 'package:logregapp/authService.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'appUser.dart';

class AuthPage extends StatefulWidget {
  AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  late String _email;
  late String _password;
  bool showLogin = true;

  AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    Widget _logo() {
      return Padding(
          padding: EdgeInsets.only(
            top: 25,
            bottom: 10,
          ),
          child: Container(
              child: Align(
            child: Text('Log/Reg App',
                style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          )));
    }

    Widget _input(Icon icon, String hint, TextEditingController controller,
        bool obscure) {
      return Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: TextField(
          controller: controller,
          obscureText: obscure,
          style: TextStyle(fontSize: 20, color: Colors.white),
          decoration: InputDecoration(
              hintStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white30),
              hintText: hint,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 3),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white54, width: 3),
              ),
              prefixIcon: Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: IconTheme(
                    data: IconThemeData(color: Colors.white),
                    child: icon,
                  ))),
        ),
      );
    }

    void _registerbuttonAction() async {
      _email = _emailController.text;
      _password = _passwordController.text;

      if (_email.isEmpty || _password.isEmpty) return;

      appUser? user = await _authService.registerWithEmailAndPassword(
          _email.trim(), _password.trim());

      if (user == null) {
        Fluttertoast.showToast(
          msg:
              'Не получилось зарегистрироваться! Проверьте вводимые пароль/email',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16,
        );
      } else {
        _emailController.clear();
        _passwordController.clear();
      }
    }

    void _loginbuttonAction() async {
      _email = _emailController.text;
      _password = _passwordController.text;

      if (_email.isEmpty || _password.isEmpty) return;

      appUser? user = await _authService.signInWithEmailAndPassword(
          _email.trim(), _password.trim());

      if (user == null) {
        Fluttertoast.showToast(
          msg: 'Не получилось войти! Проверьте вводимые пароль/email',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16,
        );
      } else {
        _emailController.clear();
        _passwordController.clear();
      }
    }

    Widget _button(String text, void func()) {
      return RaisedButton(
          splashColor: Theme.of(context).primaryColor,
          highlightColor: Theme.of(context).primaryColor,
          color: Colors.white,
          onPressed: () {
            func();
          },
          child: Text(
            text,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
                fontSize: 20),
          ));
    }

    Widget _form(String label, void func()) {
      return Container(
          child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 20, top: 10),
            child: _input(
              Icon(Icons.email),
              "EMAIL",
              _emailController,
              false,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: _input(
              Icon(Icons.lock),
              "PASSWORD",
              _passwordController,
              true,
            ),
          ),
          SizedBox(height: 20),
          Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: _button(label, func),
              )),
        ],
      ));
    }

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(children: <Widget>[
        _logo(),
        (showLogin
            ? Column(children: <Widget>[
                _form('LOGIN', _loginbuttonAction),
                Padding(
                  padding: EdgeInsets.only(left: 80, top: 10),
                  child: GestureDetector(
                    child: Text(
                      'Еще не зарегистрированны? Зарегистрируйтесь!',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    onTap: () {
                      setState(() {
                        showLogin = false;
                      });
                    },
                  ),
                )
              ])
            : Column(children: <Widget>[
                _form('Register', _registerbuttonAction),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: GestureDetector(
                    child: Text(
                      'Уже зарегистрированны? Входите!',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    onTap: () {
                      setState(() {
                        showLogin = true;
                      });
                    },
                  ),
                )
              ])),
      ]),
    );
  }
}
