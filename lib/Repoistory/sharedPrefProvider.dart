import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../UI/Auth/sigIn.dart';
import '../UI/HomeScreen/homePage.dart';

class TokenProvider with ChangeNotifier {
  String _token = '';


  String get token => _token;

  Future<void> saveToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    _token = token;
    notifyListeners();
  }

  Future<void> loadToken(BuildContext context,) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token') ?? '';
    notifyListeners();
    // Navigate based on token condition
    if (_token.isNotEmpty) {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => HomePage()),(route) => false);
    } else {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => SigIn()),(route) => false);
    }
  }

  Future clearSharedPref(String key) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}