import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:guarap/components/home/ui/home.dart';
import 'package:guarap/components/auth/ui/login.dart';

var kColorScheme = ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(
        0, 0, 0, 0)); // Define the color palette for the app

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:ThemeData().copyWith(useMaterial3: true, colorScheme: kColorScheme),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const Home();
          } else {
            return const Login();
          }
          
        }
      ) 
    ),
  );
}
