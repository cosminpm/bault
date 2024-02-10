import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';

class SharedPref {
  late final SharedPreferences sp;

  Future init() async {
    sp = await SharedPreferences.getInstance();
  }

  Future<Map<dynamic, dynamic>> getUserAccounts(userAccounts) async {
    String encodedMap = sp.getString('userAccounts') ?? "";
    if (encodedMap == ""){
      return userAccounts;
    }
    return json.decode(encodedMap);
  }

  Future<void> setUserAccounts(Map<dynamic, dynamic> userAccounts) async {
    String encodedMap = json.encode(userAccounts);
    await sp.setString('userAccounts', encodedMap);
  }
}