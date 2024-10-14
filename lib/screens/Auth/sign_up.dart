import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  bool _showPassword = false;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Center(
            child: Text("Create an account", style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),)
          ),

          const SizedBox(height: 16,),
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: "Name",
              prefixIcon: Icon(Icons.person_2_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25))
              )
            ),
          ),
          const SizedBox(height: 16,),
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration:  const InputDecoration(
              labelText: "Email",
              prefixIcon: Icon(Icons.email_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25))
              )
            ),
          ),
          const SizedBox(height: 16,),
          Stack(
            children: [
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: "Password",
                  prefixIcon: Icon(Icons.lock_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  )
                ),
                obscureText: _showPassword ? false : true,
              ),
              Positioned(
                top: 5,
                right: 5,
                child: IconButton(onPressed: (){
                setState(() {
                  _showPassword = !_showPassword;
                });
              }, icon: Icon(!_showPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined)))
            ],
          ),
          const SizedBox(height: 16,),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white
            ),
            onPressed: (){

          }, child: const Text("Sign up"))
        ],
      ));
  }
}