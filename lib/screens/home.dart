import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_app/models/todo.dart';
import 'package:flutter_todo_app/providers/todo_provider.dart';
import 'package:flutter_todo_app/providers/user_provider.dart';
import 'package:flutter_todo_app/screens/add_task.dart';
import 'package:flutter_todo_app/services/auth_service.dart';
import 'package:flutter_todo_app/services/todo_service.dart';
import 'package:intl/intl.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  Widget build(BuildContext context) {
    final todos = ref.watch(todoProvider);
    final userProfile = ref.watch(userProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: const Text("Todo's List"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {
            userProfile.when(data: (user){
              if(user != null){
                _showModalBottomSheet(context, user.uid);
              }
            }, error: (error, _) => Center(child: Text("Error: $error"),), loading: () => const Center(child: CircularProgressIndicator()));
            
          }, icon: const Icon(Icons.add_outlined))
        ],
        leading: Builder(builder: (BuildContext content){
          return  IconButton(onPressed: (){
            AuthService.signOut();
          }, icon: const Icon(Icons.logout_outlined, color:  Color.fromARGB(255, 177, 6, 6),));
        }),
      ),
      body: todos.when(
        data: (todoList) {
          todoList.sort((a, b) => a.dateCreated.compareTo(b.dateCreated));

          // Group todos by date
          Map<String, List<Todo>> groupedTodos = {};
          for (var todo in todoList) {
            String formattedDate = DateFormat('yMMMMd').format(todo.dateCreated.toLocal());
            if (groupedTodos[formattedDate] == null) {
              groupedTodos[formattedDate] = [];
            }
            groupedTodos[formattedDate]!.add(todo);
          }

          return ListView.builder(
            itemCount: groupedTodos.keys.length,
            itemBuilder: (context, index) {
              String dateKey = groupedTodos.keys.elementAt(index);
              List<Todo> todosForDate = groupedTodos[dateKey]!;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: Text(
                      dateKey,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ...todosForDate.map((todo) {
                    return Dismissible(
                      key: ValueKey<String>(todo.tid),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: const Icon(Icons.delete_forever_outlined, color: Colors.white),
                      ),
                      onDismissed: (direction) {
                        TodoService.deleteTodo(todo.tid);
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Deleted successfully")));
                      },
                      child: ListTile(
                        title: Text(todo.task),
                        subtitle: Text("Created on: ${DateFormat('jm').format(todo.dateCreated.toLocal())}"),
                        trailing: Checkbox(
                          value: todo.status,
                          onChanged: (value) {
                            TodoService.updateTodoStatus(todo.tid, value!);
                          },
                        ),
                      ),
                    );
                  })
                ],
              );
            },
          );
        },
        error: (error, _) => Center(child: Text("Error: $error")),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}


  void _showModalBottomSheet(BuildContext context, String uid){
    showModalBottomSheet(context: context, builder: (BuildContext context){
      return AddTask(uid: uid);
    });
  }