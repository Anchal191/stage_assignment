import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stage_assignment/Repoistory/sharedPrefProvider.dart';

import '../UI/Auth/sigIn.dart';
import '../UI/Auth/signUp.dart';
import '../UI/HomeScreen/homePage.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? _user;
  TokenProvider? _tokenProvider;

  AuthProvider() {
    _tokenProvider = TokenProvider();
  }
  TokenProvider? get tokenProvider => _tokenProvider;
  User? get user => _user;

  Future<void> signUpWithEmailAndPassword(BuildContext context,String email, String password) async {
    try {
      final UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      _user = userCredential.user;
      if (_user != null) {
        final String token = await _user!.getIdToken();
        _tokenProvider!.saveToken(token);
        print('cvghbjn');
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => HomePage()),
                (route) => false);
      } else {
        print('dfgh');
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => SignUpPage()),
                (route) => false);
      }

      print(_user);
      notifyListeners();
    } catch (e) {
      print('Sign-up error: $e');
    }
  }

  Future<void> signInWithEmailAndPassword(BuildContext context,String email, String password) async {
    try {
      final UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      _user = userCredential.user;
      if (_user != null) {
        final String token = await _user!.getIdToken();
        _tokenProvider!.saveToken(token);
        print('cvghbjn');
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => HomePage()),
                (route) => false);
      } else {
        print('dfgh');
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => SigIn()),
                (route) => false);
      }

         print(_user);
      notifyListeners();
    } catch (e) {
      print('Sign-in error: $e');
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    _user = null;
    notifyListeners();
  }

}


