import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guarap/components/auth/bloc/auth_bloc.dart';
import 'package:guarap/components/home/ui/home.dart';

class SignUpWelcome extends StatelessWidget {
  final AuthBloc authBloc;
  final String username;
  const SignUpWelcome(
      {super.key, required this.authBloc, required this.username});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      bloc: authBloc,
      listener: (context, state) {
        if (state is SignUpSuccessfulState) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const Home()),
              (route) => false);
        }
      },
      builder: (BuildContext context, AuthState state) {
        return Scaffold(
          body: SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(flex: 1, child: Container()),
                  // Title
                  Text(
                    "Welcome to Guarap, \n$username",
                    style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: 36,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  // Description
                  Text(
                    "Start seeing some posts posted by other users",
                    style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.normal),
                  ),
                  Flexible(flex: 1, child: Container()),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
