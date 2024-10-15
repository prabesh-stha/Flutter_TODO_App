import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_app/models/app_user.dart';
import 'package:flutter_todo_app/providers/user_provider.dart';
import 'package:flutter_todo_app/services/auth_service.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  Widget build(BuildContext context) {
    final userProfile = ref.watch(userProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Container(
        child: Column(
          children: [
            ElevatedButton(onPressed: ()async{
      await AuthService.signOut();
    }, child: const Text("Log out", style: TextStyle(color: Colors.red),)),
            userProfile.when(data: (user){
        if(user == null){
          return const Center(child: Text("User not found."),);
        }
        return Column(
      children: [
        
      Text(user.uid),
      Text(user.email),
      Text(user.name)
      ],
    );
      }, error: (error, _) => Center(child: Text("Error: $error"),), loading: () => const Center(child: CircularProgressIndicator(),))
          ],
        ),
      )
    );
  }
}