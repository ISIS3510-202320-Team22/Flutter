import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guarap/components/auth/bloc/auth_bloc.dart';
import 'package:guarap/components/auth/ui/text_field_input.dart';

class RecoverAccount extends StatefulWidget {
  const RecoverAccount({super.key});

  @override
  State<RecoverAccount> createState() => _RecoverAccountState();
}

class _RecoverAccountState extends State<RecoverAccount> {
  final AuthBloc authBloc = AuthBloc();
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void initState() {
    authBloc.add(RecoverAccountInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      bloc: authBloc,
      listenWhen: (previous, current) => current is AuthActionState,
      buildWhen: (previous, current) => current is! AuthActionState,
      listener: (context, state) {
        // TODO: implement listener

      },
      builder: (context, state) {
        switch (state.runtimeType){
          case RecoverAccountAttemptState:
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
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  const SizedBox(height: 64),
                    Text(
                    "Find your account",
                    style:
                        GoogleFonts.roboto(color: Colors.black, fontSize: 40),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Enter your email address to recover you account.",
                    style:
                        GoogleFonts.roboto(color: Colors.black, fontSize: 20),
                  ),
                  const SizedBox(height: 64),
                  TextFieldInput(
                    controller: _emailController,
                    hintText: "Enter your email",
                    textInputType: TextInputType.emailAddress,
                    validatorMessage: "Please enter a valid email address"),
                    const SizedBox(height: 16),
                  // Login Button
                  InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        // If form is valid, proceed with login logic
                        authBloc.add(RecoverAccountEvent(email: _emailController.text));
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
                  ],
                )
                
                
              ),
            )),
        );
      },
    );
  }
}
