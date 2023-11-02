import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guarap/components/auth/bloc/auth_bloc.dart';
import 'package:guarap/components/auth/ui/login_screen.dart';
import 'package:guarap/components/auth/ui/sign_up_password_screen.dart';
import 'package:guarap/components/auth/ui/text_field_input.dart';

class SignUpUsername extends StatefulWidget {
  final String email;

  const SignUpUsername({super.key, required this.email});

  @override
  State<SignUpUsername> createState() => _SignUpUsernameState();
}

class _SignUpUsernameState extends State<SignUpUsername> {
  final TextEditingController _usernameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final AuthBloc authBloc = AuthBloc();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      bloc: authBloc,
      listenWhen: (previous, current) => current is AuthActionState,
      buildWhen: (previous, current) => current is! AuthActionState,
      listener: (context, state) {
        if (state is NavigateToLoginPageActionState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Login()));
        } else if (state is NavigateToPasswordPageActionState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SignUpPassword(
                        email: state.email,
                        username: state.username,
                      )));
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
                      "Create username",
                      style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 36,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    // Description
                    Text(
                      "You will use this username to sign in to your account",
                      style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.normal),
                    ),
                    const SizedBox(height: 16),
                    // Text Field Input
                    TextFieldInput(
                      hintText: "Username",
                      textInputType: TextInputType.name,
                      controller: _usernameController,
                      validatorMessage: "Please enter your username",
                    ),
                    const SizedBox(height: 16),
                    // Next Button
                    InkWell(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          authBloc.add(SignUpValidateUsernameEvent(
                              email: widget.email,
                              username: _usernameController.text));
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
