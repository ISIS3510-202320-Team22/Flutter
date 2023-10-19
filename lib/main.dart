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
    final AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        darkTheme: ThemeData.dark()
            .copyWith(useMaterial3: true, colorScheme: kDarkColorScheme),
        theme: ThemeData().copyWith(
            useMaterial3: true,
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
                // Do login to check user data is valid

                return const Login();
              } else {
                // User was logged in, check if user data is still valid
                try {
                  FirebaseAuth.instance.currentUser!.reload();
                } catch (e) {
                  // User data is invalid, do login
                  return const Login();
                }

                print(snapshot.data);
                return const Home();
              }
            }));
  }
}
