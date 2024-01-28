import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'accountConfig.dart';
import 'const.dart';
import 'main.dart';

List<dynamic> createAllAccounts(Map<String, dynamic> accounts,  Function() updateQr) {
  List<Widget> result = [];
  for (String social in accounts.keys) {
    String account = accounts[social]!['account'];
    result.add(AccountWidget(account: account, type: social, updateQr: updateQr));
  }
  return result;
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

class AccountWidget extends StatefulWidget {
  final String account;
  final String type;
  final Function() updateQr;


  const AccountWidget({
    required this.account,
    required this.type,
    required this.updateQr,

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
      height: switchValue ? _containerHeight : 0, // Set height to 0 when switchValue is false
      duration: Duration(milliseconds: 300), // Adjust duration as needed
      curve: Curves.easeInOut, // Optional: Add easing curve
      child: Visibility(
        visible: switchValue,
        maintainSize: false, // Prevents maintaining space when widget is invisible
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              accountsConfigurations[widget.type]![ICON],
              size: 30,
            ),
            TextButton(
              child: Text(widget.account, style: myTextStyle),
              onPressed: () => openLink(link),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  switchValue = false;
                  _containerHeight = 0.0; // Update container height to 0
                });
                widget.updateQr();
                // Update the visibility to 0 in the userAccount map
                userAccount[widget.type]!['visibility'] = 0;
              },
              icon: Icon(FontAwesomeIcons.circleMinus),
            ),
          ],
        ),
      ),
    );
  }
}
