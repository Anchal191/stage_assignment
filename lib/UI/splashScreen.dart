import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Repoistory/sharedPrefProvider.dart';


class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tokenProvider = Provider.of<TokenProvider>(context, listen: false);
    tokenProvider.loadToken(context);
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}