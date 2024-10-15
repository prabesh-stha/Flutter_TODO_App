import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_app/models/todo.dart';
import 'package:flutter_todo_app/providers/auth_provider.dart';
import 'package:flutter_todo_app/services/todo_service.dart';

final todoProvider = StreamProvider.autoDispose<List<Todo>>((ref) {
  final user = ref.watch(authProvider).asData?.value;

  if(user != null){
    return TodoService.fetchTodos(user.uid);
  }
  else{
    return Stream.value([]);
  }
});