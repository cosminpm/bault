import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qisla/SharedPreferences.dart';
import 'package:qisla/account.dart';
import 'package:qisla/popUpAddAccount.dart';
import 'package:qisla/putBackAccounts.dart';
import 'package:qisla/qr.dart';
import 'accountConfig.dart';

late Map userAccounts;

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

class _MyHomePageState extends State<MyHomePage> {
  late AccountManager accountManager;
  SharedPref sp = SharedPref();
  bool _resourcesInitialized = false;

  @override
  void initState() {
    super.initState();
    initResources();
  }

  void initResources() async {
    userAccounts = createInitialEmptyAccounts(accountsConfigurations);
    await sp.init();
    userAccounts = await sp.getUserAccounts(userAccounts);
    setState(() {
      _resourcesInitialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_resourcesInitialized) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    accountManager = AccountManager(userAccounts, sp, () {
      setState(() {
        sp.setUserAccounts(userAccounts);
      });
    });
    QrWidget qr = QrWidget(
      userAccounts: userAccounts,
      updateQrData: (newData) {
        setState(() {
          sp.setUserAccounts(userAccounts);
        });
      },
    );
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Bault',
                style: TextStyle(
                  fontSize: 80,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                )),
            qr,
            ...accountManager.createAllAccounts(userAccounts),
            SizedBox(height: 10),
            createButtons()
          ],
        ),
      ),
    );
  }

  Row createButtons() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buttonCreateAccount(context),
        buttonPutBackAccount(context, () {
          setState(() {
            sp.setUserAccounts(userAccounts);
          });
        })
      ],
    );
  }

  IconButton buttonCreateAccount(context) {
    return IconButton(
      icon: Icon(FontAwesomeIcons.circlePlus),
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AddAccount(accountManager: accountManager);
          },
        ).then((_) {
          setState(() {
            sp.setUserAccounts(userAccounts);
          });
        });
      },
    );
  }

  IconButton buttonPutBackAccount(context, function) {
    return IconButton(
        icon: Icon(FontAwesomeIcons.arrowUp),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return BackAccountPopUp(
                  accountManager: accountManager,
                );
              }).then((_) {
            setState(() {
              sp.setUserAccounts(userAccounts);
            });
          });
        });
  }
}
