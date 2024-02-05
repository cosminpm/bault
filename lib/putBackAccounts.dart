import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'account.dart';
import 'accountConfig.dart';
import 'main.dart';

class BackAccountPopUp extends StatefulWidget {
  final AccountManager accountManager;

  const BackAccountPopUp({
    required this.accountManager,
    Key? key,
  }) : super(key: key);

  @override
  _BackAccountPopUp createState() => _BackAccountPopUp();
}

class _BackAccountPopUp extends State<BackAccountPopUp> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  Widget contentBox(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              icon: Icon(FontAwesomeIcons.xmark),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...addMultipleAccounts(userAccount, accountsConfigurations),
            ],
          )
        ],
      ),
    );
  }

  Widget addOneAccount(String id, Map<String, dynamic> accountConfig, account) {
    return IconButton(
      icon: Icon(
        accountConfig[ICON],
        size: 30,
      ),
      onPressed: () {
        widget.accountManager.putBackButton(account);
        setState(() {});
      },
    );
  }

  List<Widget> addMultipleAccounts(Map<String, dynamic> userAccount,
      Map<String, dynamic> accountConfigurations) {
    List<Widget> result = [];
    for (String account in userAccount.keys) {
      if (userAccount[account]['visibility'] == 0 && userAccount[account]['account'] != "") {
        result.add(
            addOneAccount(account, accountConfigurations[account], account));
        result.add(SizedBox(height: 10));
      }
    }
    if (result.length == 0) {
      result.add(Text('You added all socials to your QR'));
    }


    return result;
  }
}
