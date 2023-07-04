import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stage_assignment/UI/Auth/sigIn.dart';

import 'Repoistory/authProvider.dart';
import 'Repoistory/sharedPrefProvider.dart';
import 'Repoistory/taskProvider.dart';
import 'UI/Auth/signUp.dart';
import 'UI/splashScreen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => AuthProvider()),
    ChangeNotifierProvider(create: (_) => TokenProvider()),
    ChangeNotifierProvider(create: (_) => TaskProvider()),
  ],child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        "/sigInPage": (_) => SigIn()
      },
      home:  SplashScreen(),
    );
  }
}

