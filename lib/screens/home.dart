import 'package:flutter/material.dart';
import 'package:flutter_todo_app/services/auth_service.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: ()async{
      await AuthService.signOut();
    }, child: const Text("Log out", style: TextStyle(color: Colors.red),));
  }
}