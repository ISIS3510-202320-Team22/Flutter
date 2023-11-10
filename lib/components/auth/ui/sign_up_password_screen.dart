import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guarap/components/auth/bloc/auth_bloc.dart';
import 'package:guarap/components/auth/ui/login_screen.dart';
import 'package:guarap/components/auth/ui/sign_up_welcome_screen.dart';
import 'package:guarap/components/auth/ui/text_field_input.dart';

class SignUpPassword extends StatefulWidget {
  final String email;
  final String username;

  const SignUpPassword(
      {super.key, required this.email, required this.username});

  @override
  State<SignUpPassword> createState() => _SignUpPasswordState();
}

class _SignUpPasswordState extends State<SignUpPassword> {
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final AuthBloc authBloc = AuthBloc();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics analytics = FirebaseAnalytics.instance;
    return BlocConsumer<AuthBloc, AuthState>(
      bloc: authBloc,
      listenWhen: (previous, current) => current is AuthActionState,
      buildWhen: (previous, current) => current is! AuthActionState,
      listener: (context, state) async {
        if (state is NavigateToLoginPageActionState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Login()));
          analytics.logEvent(
            name: 'screen_view',
            parameters: {
              'firebase_screen': "Login",
              'firebase_screen_class': Login,
            },
          );
        } else if (state is NavigateToWelcomePageActionState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SignUpWelcome(
                      authBloc: authBloc, username: state.username)));
          analytics.logEvent(
            name: 'screen_view',
            parameters: {
              'firebase_screen': "SignUpWelcome",
              'firebase_screen_class': SignUpWelcome,
            },
          );
        } else if (state is SignUpFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case ValidatingState:
            _isLoading = true;
          default:
            _isLoading = false;
        }
        return Scaffold(
          body: SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              width: double.infinity,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(flex: 1, child: Container()),
                    // Title
                    Text(
                      "Create Password",
                      style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 36,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    // Description
                    Text(
                      "You will use this Password to sign in to your account",
                      style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.normal),
                    ),
                    const SizedBox(height: 16),
                    // Text Field Input
                    TextFieldInput(
                      hintText: "Password",
                      textInputType: TextInputType.visiblePassword,
                      isPassword: true,
                      controller: _passwordController,
                      validatorMessage: "Please enter your Password",
                    ),
                    const SizedBox(height: 16),
                    // Next Button
                    InkWell(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          authBloc.add(SignUpValidatePasswordEvent(
                              email: widget.email,
                              username: widget.username,
                              password: _passwordController.text));
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                            color: const Color(0xFFAB003E),
                            borderRadius: BorderRadius.circular(8)),
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
                                  "Next",
                                  style: GoogleFonts.roboto(
                                      color: Colors.white, fontSize: 18),
                                )
                              : const CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                        ),
                      ),
                    ),
                    Flexible(flex: 1, child: Container()),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
