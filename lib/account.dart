import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'accountConfig.dart';
import 'const.dart';

List<dynamic> createAllAccounts(Map<String, String> accounts) {
  List<Widget> result = [];
  for (String social in accounts.keys) {
    String account = accounts[social]!;
    result.add(createAccount(account, social));
  }

  return result;
}

dynamic createAccount(String account, String type) {
  String link = accountToLink(account, type);
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(
        accountsConfigurations[type]![ICON],
        size: 30,
      ),
      TextButton(
        child: Text(account, style: myTextStyle),
        onPressed: () => openLink(link),
      ),
      SizedBox(
        height: 30,
        child: FittedBox(
          fit: BoxFit.fill,
          child: Switch(
            activeColor: Colors.black87,
            value: true,
            onChanged: (bool value1) {},
          ),
        ),
      ),    ],
  );
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
