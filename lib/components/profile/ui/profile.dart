import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  @override
  Widget build(context) {
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
            body: SafeArea(
                child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    width: double.infinity,
                    // Login Button
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 64),
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
                        ]))));
      },
    );
  }
}
