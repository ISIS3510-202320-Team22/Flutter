import 'package:flutter/material.dart';
import 'package:guarap/components/auth/ui/login.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  bool isLogged = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email/Pass Auth'),
      ),  
      body: Form(
        key: _formKey,
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                key: const ValueKey('username'),
                decoration: const InputDecoration(hintText: "Enter Username"),
              ), 
              TextFormField(
                key: const ValueKey('email'),
                decoration: const InputDecoration(hintText: "Enter Email"),
              ),
              TextFormField(
                key: const ValueKey('password'),
                decoration: const InputDecoration(hintText: "Enter Password"),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(onPressed: (){}, child: const Text('Signup'))),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: (){
                  setState(() {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const Login()));
                  });
                },
                child: Text("Already have an account? Login")),
            ],
          ),
        )
      )
    );
  }
}