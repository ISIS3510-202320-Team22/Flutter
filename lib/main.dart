import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guarap/components/auth/bloc/auth_bloc.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:guarap/components/home/ui/home.dart';
import 'package:guarap/components/auth/ui/login_screen.dart';

var kColorScheme = ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(
        255, 171, 0, 72)); // Define the color palette for the app
var kDarkColorScheme = ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 171, 0, 72));

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    BlocProvider(
      create: (context) => AuthBloc(),
      child: const GuarapApp(),
    ),
  );
}

class GuarapApp extends StatelessWidget {
  const GuarapApp({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics analytics = FirebaseAnalytics.instance;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        darkTheme: ThemeData.dark().copyWith(
          colorScheme: kDarkColorScheme,
          textTheme: ThemeData.dark().textTheme.copyWith(
              titleLarge: const TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Color.fromARGB(255, 255, 255, 255)),
              titleMedium: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 255, 255, 255)),
              titleSmall: const TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Color.fromARGB(255, 255, 255, 255)),
              bodyMedium: const TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Color.fromARGB(255, 255, 255, 255))),
        ),
        theme: ThemeData().copyWith(
            colorScheme: kColorScheme,
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 171, 0, 72)),
            ),
            textTheme: ThemeData().textTheme.copyWith(
                titleLarge: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: kColorScheme.onSecondaryContainer))),
        themeMode: ThemeMode.system, // use the theme of the app
        home: StreamBuilder(
            stream: FirebaseAuth.instance.idTokenChanges(),
            builder: (context, snapshot) {
              // Snapshot contains user object if user is logged in
              if (!snapshot.hasData || snapshot.hasError) {
                // User was not logged in, do login
                analytics.logEvent(name: 'screen_view', parameters: {
                  'screen_name': 'login',
                });
                return const Login();
              } else {
                // User was logged in, check if user data is still valid
                try {
                  FirebaseAuth.instance.currentUser!.reload();
                } catch (e) {
                  // User data is invalid, do login
                  analytics.logEvent(name: 'screen_view', parameters: {
                    'screen_name': 'login',
                  });
                  return const Login();
                }
                // User data is valid, do home
                analytics.logEvent(name: 'screen_view', parameters: {
                  'screen_name': 'home',
                });
                return const Home();
              }
            }));
  }
}
