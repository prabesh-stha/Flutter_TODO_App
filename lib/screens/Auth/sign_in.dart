import 'package:flutter/material.dart';
import 'package:flutter_todo_app/services/auth_service.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _showPassword = false;
  String? _errorFeedback;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Center(
            child: Text("Sign in to your account", style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),)
          ),

          const SizedBox(height: 16,),
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
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
              }, icon: Icon(!_showPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined)),)
            ],
          ),
          const SizedBox(height: 16,),
          if(_errorFeedback != null)
            Center(child: Text(_errorFeedback!, style: const TextStyle(color: Colors.red),),),

          _isLoading ?
          const Center(child: CircularProgressIndicator(),):
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white
            ),
            onPressed: ()async{
              setState(() {
                _isLoading = true;
                _errorFeedback = null;
              });
              final email = _emailController.text.trim();
              final password = _passwordController.text.trim();

              final user = await AuthService.signIn(email, password);

              if(user == null){
                _errorFeedback = "Incorrect user information";
              }
             setState(() {
              _passwordController.text = "";
                _isLoading = false;
             });

          }, child: const Text("Sign in"))
        ],
      ));
  }
}