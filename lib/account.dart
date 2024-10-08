import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'SharedPreferences.dart';
import 'accountConfig.dart';
import 'const.dart';
import 'main.dart';

class AccountManager {
  Map<String, dynamic> accountWidgetMap = {};
  late SharedPref pf;
  late Function onUpdate; // Callback function to trigger UI update

  AccountManager(Map<dynamic, dynamic> accountsMap, SharedPref pf, Function onUpdate){
    this.pf = pf;
    this.onUpdate = onUpdate;
  }

  List<Widget> createAllAccounts(
      Map<dynamic, dynamic> accounts) {
    List<Widget> result = [];
    for (String social in accounts.keys) {
      String account = accounts[social]!['account'];
      if (accounts[social]!['visibility'] == 1){
        Widget w = AccountWidget(account: account, type: social, onUpdate: onUpdate,);
        result.add(w);
        accountWidgetMap[social] = w;
      }
    }
    return result;
  }

  void putBackButton(social){
    userAccounts[social]!['visibility'] = 1;
  }
}

class AccountWidget extends StatefulWidget {
  final String account;
  final String type;
  final Function onUpdate;
  const AccountWidget({
    required this.account,
    required this.type,
    required this.onUpdate,
    Key? key,
  }) : super(key: key);

  @override
  _AccountWidgetState createState() => _AccountWidgetState();
}

class _AccountWidgetState extends State<AccountWidget> {
  @override
  Widget build(BuildContext context) {
    String link = accountToLink(widget.account, widget.type);

    return AnimatedContainer(
      height: 40,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: CreateRowIcon(link),
    );
  }

  Row CreateRowIcon(String link){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Spacer(flex: 1),
        SizedBox(
          width: 40.0,
          child: Icon(
            accountsConfigurations[widget.type]![ICON],
            size: 30,
          ),
        ),
        Expanded(
          child: TextButton(
            child: Text(widget.account, style: myTextStyle),
            onPressed: () => openLink(link),
          ),
        ),
        IconButton(
          onPressed: () {
            userAccounts[widget.type]!['visibility'] = 0;
            widget.onUpdate();
            },
          icon: Icon(FontAwesomeIcons.circleMinus),

        ),
        Spacer(flex: 1),

      ],
    );
  }
}




String accountToLink(String account, String type) {
  return accountsConfigurations[type]?[URL].replaceAll(ACCOUNT_VAR, account);
}

Future<void> openLink(String link) async {
  final url = Uri.parse(link);

  if (await canLaunchUrl(url)) {
    await launchUrl(url, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $url';
  }
}

Map createInitialEmptyAccounts(Map accountsConfigurations){
  Map result = {};
  for (String config in accountsConfigurations.keys){
    result[config] = {'account' : "", 'visibility': 0};
  }
  return result;
}