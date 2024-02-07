import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';

class SharedPref {
  late final SharedPreferences sp;

  Future init() async {
    sp = await SharedPreferences.getInstance();
  }

  Future<dynamic> getUserAccounts(userAccounts) async {
    print("DEBUG: GET PREFERENCES");
    String encodedMap = sp.getString('userAccounts') ?? "";
    if (encodedMap == ""){
      return userAccounts;
    }
    print("DEBUG: GET PREFERENCES");
    print(encodedMap);
    return json.decode(encodedMap);
  }

  Future<void> setUserAccounts(Map<dynamic, dynamic> userAccounts) async {
    String encodedMap = json.encode(userAccounts);
    print("DEBUG: SET PREFERENCES");

    print(encodedMap);
    await sp.setString('userAccounts', encodedMap);
  }
}