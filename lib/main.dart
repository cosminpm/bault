import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qisla/account.dart';
import 'package:qisla/popUpAddAccount.dart';
import 'package:qisla/qr.dart';

Map<String, String> userAccount = {
  "instagram": "yosoycosmin",
  "linkedin": "cosminmp",
  "twitter": "cosminpm"
};

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

IconButton buttonCreateAccount(context) {
  return IconButton(
      icon: Icon(FontAwesomeIcons.plus),
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomPopup(); // Custom popup content
          },
        );
      });
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            createQrImage(userAccount),
            ...createAllAccounts(userAccount),
            buttonCreateAccount(context),
          ],
        ),
      ),
    );
  }
}
