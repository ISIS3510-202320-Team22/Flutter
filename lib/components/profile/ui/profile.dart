import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guarap/components/auth/bloc/auth_bloc.dart';
import 'package:guarap/components/auth/ui/login_screen.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _Profile();
}

class _Profile extends State<Profile> {
  final AuthBloc authBloc = AuthBloc();
  bool _isLoading = false;

  void printCurrentUserUID() {
    if (FirebaseAuth.instance.currentUser != null) {
      // ignore: avoid_print
      print(FirebaseAuth.instance.currentUser?.email);
    }
  }

  @override
  Widget build(context) {
    printCurrentUserUID();  // Call the function here

    return BlocConsumer<AuthBloc, AuthState>(
      bloc: authBloc,
      listenWhen: (previous, current) => current is AuthActionState,
      buildWhen: (previous, current) => current is! AuthActionState,
      listener: (context, state) {
        if (state is LogoutSuccessfulState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Login()));
        } else if (state is LogoutFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Logout failed. Try again."),
            ),
          );
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case LogoutAttemptState:
            _isLoading = true;
            break;
          default:
            _isLoading = false;
            break;
        }
        return Scaffold(
            appBar: AppBar(
              title: Text(
                "Profile",
                style: GoogleFonts.arima(
                    color: Colors.black,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
            ),
            body: SafeArea(
                child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    width: double.infinity,
                    // Login Button
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 64),
                          Icon(  // This line adds the user icon
                            Icons.person,  // This is a Material icon
                            size: 100,  // Adjust the size as needed
                            color: Colors.black,  // Adjust the color as needed
                          ),
                          const SizedBox(height: 16),  // Optional: add some spacing
                          Text(
                              FirebaseAuth.instance.currentUser?.email ?? 'No email',  // This line will display the UID
                              style: TextStyle(fontSize: 20),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Spacer(),
                                //const SizedBox(height: 16),  // Optional: add some spacing
                                InkWell(
                                  onTap: () {
                                    _isLoading = true;
                                    authBloc.add(LogoutEvent());
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                    decoration: const ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(4)),
                                      ),
                                      color: Color(0xFFAB003E),
                                    ),
                                    child: !_isLoading
                                        ? Text(
                                            "Logout",
                                            style: GoogleFonts.roboto(
                                                color: Colors.white, fontSize: 18),
                                          )
                                        : const CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                  ),
                                ),
                                  const SizedBox(height: 48),  // Adjust this value to control the distance from the bottom
                              ],
                            ),
                          ),
                        ]))));
      },
    );
  }
}