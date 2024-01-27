import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'accountConfig.dart';


List<Widget> createAllAccounts(Map<String, String> accounts){
  List<Widget> result = [];
  for (String social in accounts.keys){
    String account = accounts[social]!;
    result.add(createAccount(account, social));
  }

  return result;
}

Widget createAccount(String account, String type) {
  String link = accountToLink(account, type);
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(
        accounts[type]![ICON],
        size: 30,
      ),
      TextButton(child: Text(account), onPressed: () => openLink(link))
    ],
  );
}

String accountToLink(String account, String type){
  return accounts[type]?[URL].replaceAll(ACCOUNT_VAR, account);
}

Future<void> openLink(String link) async {
  final url = Uri.parse(link);

  if (await canLaunchUrl(url)) {
    await launchUrl(url, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $url';
  }
}