// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:logregapp/authService.dart';
import 'package:logregapp/messages.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          appBar: AppBar(
            title: Text('Messages'),
            leading: Icon(Icons.mail),
            actions: <Widget>[
              TextButton.icon(
                  onPressed: () {
                    AuthService().logOut();
                  },
                  icon: Icon(
                    Icons.supervised_user_circle,
                    color: Colors.white,
                  ),
                  label: SizedBox.shrink())
            ],
          ),
          body: MessageList()),
    );
  }
}

class MessageList extends StatelessWidget {
  final messages = <Messages>[
    Messages('Mark', 'Bye', false),
    Messages('Olga', 'Its ok.', false),
    Messages('Arthur', 'See you next friday!', false),
    Messages('Bogdan', 'Please...', true),
    Messages('Nikita', 'When will it end???', true),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Container(
      child: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, i) {
          return Card(
              elevation: 2,
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Container(
                  decoration:
                      BoxDecoration(color: Color.fromRGBO(50, 65, 85, 0.9)),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    leading: Container(
                      padding: EdgeInsets.only(right: 12),
                      child: Icon(
                        Icons.mail,
                        color: Colors.white,
                      ),
                      decoration: BoxDecoration(
                          border: Border(
                              right: BorderSide(
                        width: 1,
                        color: Colors.white24,
                      ))),
                    ),
                    title: Text(
                      messages[i].name,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    trailing: Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.white24,
                    ),
                    subtitle: subtitle(context, messages[i]),
                  )));
        },
      ),
    ));
  }
}

Widget subtitle(BuildContext context, Messages Messages) {
  var color = Colors.grey;
  double indicatorLevel = 0;

  switch (Messages.read) {
    case true:
      color = Colors.green;
      indicatorLevel = 1;
      break;
    case false:
      color = Colors.red;
      indicatorLevel = 1;
      break;
  }

  return Row(children: <Widget>[
    Expanded(
        flex: 1,
        child: LinearProgressIndicator(
          backgroundColor: Colors.white,
          value: indicatorLevel,
          valueColor: AlwaysStoppedAnimation(color),
        )),
    SizedBox(width: 10),
    Expanded(
      flex: 3,
      child: Text(
        Messages.lastMessage,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    )
  ]);
}
