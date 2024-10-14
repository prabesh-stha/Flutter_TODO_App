import 'package:flutter/material.dart';
import 'package:flutter_todo_app/screens/Auth/sign_in.dart';
import 'package:flutter_todo_app/screens/Auth/sign_up.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  bool _isSignIn = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: const Text("TO DO"),
        centerTitle: true,
      ),
      body:SingleChildScrollView(
         child: Container(
        padding:const EdgeInsets.symmetric(vertical: 48, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Welcome", style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold
            ),),
            const SizedBox(height: 20,),
            if(!_isSignIn)
              const SignIn()
            else
              const SignUp(),

              const SizedBox(height: 16,),

              Text(!_isSignIn ? "Create an account?": "Already have an account?"),
              TextButton(onPressed: (){
                setState(() {
                  _isSignIn = !_isSignIn;
                });
              }, child: Text(!_isSignIn ? "Sign up" : "Sign in"))
              
          ],
        ),
      ),
      )
    );
  }
}