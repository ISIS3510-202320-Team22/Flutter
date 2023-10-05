// Create a login page widget. This widget will be used to display the login form and handle the login process.
// This widgets uses bloc pattern to handle the login process. The bloc pattern is a state management pattern that helps to manage the state of the application.
// Path: lib/components/auth/ui/login.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guarap/components/auth/ui/text_field_input.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              Flexible(flex: 2, child: Container()),
              // GUARAP
              Text(
                "Guarap",
                style: GoogleFonts.pattaya(color: Colors.black, fontSize: 40),
              ),
              const SizedBox(height: 64),
              // Email Text Field Input
              TextFieldInput(
                hintText: "Enter your email",
                textInputType: TextInputType.emailAddress,
                controller: _emailController,
              ),
              const SizedBox(height: 16),
              // Password Text Field Input
              TextFieldInput(
                hintText: "Enter your password",
                textInputType: TextInputType.visiblePassword,
                controller: _passwordController,
                isPassword: true,
              ),
              const SizedBox(height: 16),
              // Login Button
              InkWell(
                onTap: () {}, // TODO: Implement login
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
                    onTap: () {}, // TODO: Implement forgot password
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
              const SizedBox(height: 16),
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
                    onTap: () {}, // TODO: Implement sign up
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
  }
}
