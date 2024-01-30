import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'accountConfig.dart';
import 'const.dart';
import 'main.dart';

class AccountManager {
  Map<String, dynamic> accountMap = {};
  List<dynamic> accountsWidget = [];
  late final Function onUpdate;

  AccountManager(Map<String, dynamic> accountsMap, Function onUpdate){
    this.accountMap = accountsMap;
    this.onUpdate = onUpdate;
    this.accountsWidget;
  }

  List<Widget> createAllAccounts(
      Map<String, dynamic> accounts) {
    List<Widget> result = [];
    for (String social in accounts.keys) {
      String account = accounts[social]!['account'];
      result
          .add(AccountWidget(account: account, type: social, onUpdate: onUpdate));
    }
    return result;
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
  bool switchValue = true;
  double _containerHeight = 40.0; // Initial height of the container

  @override
  Widget build(BuildContext context) {
    String link = accountToLink(widget.account, widget.type);

    return AnimatedContainer(
      height: switchValue ? _containerHeight : 0,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: Visibility(
        visible: switchValue,
        maintainSize: false,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center, // Adjusted alignment
          children: [
            Spacer(flex: 1),
            SizedBox(
              width: 40.0, // Adjust width as needed
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
                setState(() {
                  switchValue = false;
                  _containerHeight = 0.0;
                  widget.onUpdate(); // <-- NOT DETECTED HERE
                });
                userAccount[widget.type]!['visibility'] = 0;
              },
              icon: Icon(FontAwesomeIcons.circleMinus),
            ),
            Spacer(
              flex: 1,
            ),
          ],
        ),
      ),
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
