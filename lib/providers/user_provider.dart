import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_app/models/user.dart';
import 'package:flutter_todo_app/providers/auth_provider.dart';

final userProvider = StreamProvider.autoDispose<User?>((ref){
    final user = ref.watch(authProvider).value;

    if(user != null){
        return FirebaseFirestore.instance.collection("users").doc(user.uid).snapshots().map((doc){
            if (doc.exists){
                return User.fromFirestore(doc);
            }
            return null;
        });
    }else{
        return Stream.value(null);
    }
});