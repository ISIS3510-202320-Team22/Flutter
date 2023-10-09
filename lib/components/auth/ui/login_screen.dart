import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guarap/components/auth/bloc/auth_bloc.dart';
import 'package:guarap/components/auth/ui/text_field_input.dart';

import '../../home/ui/home.dart';
import 'recover_account_screen.dart';
import 'sign_up_screen.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final AuthBloc authBloc = AuthBloc();
  bool _isLoading = false;
  @override
  void initState() {
    authBloc.add(LoginInitialEvent());
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      bloc: authBloc,
      // Do listen when States are AuthActionState, hence Navigation or other small actions
      listenWhen: (previous, current) => current is AuthActionState,
      // Do build when States are not AuthActionState, hence UI changes
      buildWhen: (previous, current) => current is! AuthActionState,
      listener: (context, state) {
        if (state is LoginNavigateToRecoverPageActionState) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const RecoverAccount()));
        } else if (state is LoginNavigateToSignUpPageActionState) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const SignUp()));
        } else if (state is LoginSuccessfulState) {
          Navigator.push(context, 
              MaterialPageRoute(builder: (context) => const Home()));
        } else if (state is LoginFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              // content: Text(state.errorMessage),
              content: Text("Login failed. Check credentials."),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case LoginAttemptState:
            _isLoading = true;
            break;
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
                  // GUARAP
                  Text(
                    "Guarap",
                    style:
                        GoogleFonts.pattaya(color: Colors.black, fontSize: 40),
                  ),
                  const SizedBox(height: 64),
                  // Email Text Field Input
                  TextFieldInput(
                    hintText: "Enter your email",
                    textInputType: TextInputType.emailAddress,
                    controller: _emailController,
                    validatorMessage: "Please enter a valid email address",
                  ),
                  const SizedBox(height: 16),
                  // Password Text Field Input
                  TextFieldInput(
                    hintText: "Enter your password",
                    textInputType: TextInputType.visiblePassword,
                    controller: _passwordController,
                    isPassword: true,
                    validatorMessage:
                        "Please enter a valid password, min 8 chars long",
                  ),
                  const SizedBox(height: 16),
                  // Login Button
                  InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        // If form is valid, proceed with login logic
                        authBloc.add(LoginEvent(
                            email: _emailController.text,
                            password: _passwordController.text));
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                        color: Color(0xFFAB003E),
                      ),
                      child: !_isLoading
                          ? Text(
                              "Login",
                              style: GoogleFonts.roboto(
                                  color: Colors.white, fontSize: 18),
                            )
                          : const CircularProgressIndicator(
                              color: Colors.white,
                            ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Forgot Password
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          "Forgot your login details? ",
                          style: GoogleFonts.roboto(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          authBloc.add(RecoverAccountTextPressedEvent(
                              email: _emailController.text));
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            "Recover your account.",
                            style: GoogleFonts.roboto(
                              color: Colors.blue,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Flexible(child: Container(), flex: 2),
                  const Divider(
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 16),
                  // Sign Up
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          "Don't have an account? ",
                          style: GoogleFonts.roboto(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          authBloc.add(SignUpTextPressedEvent());
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            "Sign up.",
                            style: GoogleFonts.roboto(
                              color: Colors.blue,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ));
      },
    );
  }
}