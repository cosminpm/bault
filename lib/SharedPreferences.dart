import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  late final SharedPreferences sp;

  Future init() async {
    sp = await SharedPreferences.getInstance();
  }

  Future<dynamic> getUserAccounts() async {
    String encodedMap = sp.getString('userAccounts') ?? "";
    return json.decode(encodedMap);
  }

  Future<void> setUserAccounts(Map<dynamic, dynamic> userAccounts) async {
    String encodedMap = json.encode(userAccounts);
    await sp.setString('userAccounts', encodedMap);
  }
}