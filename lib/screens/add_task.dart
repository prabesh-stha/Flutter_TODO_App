import 'package:flutter/material.dart';
import 'package:flutter_todo_app/services/todo_service.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key, required this.uid});

  final String uid;
 

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
   bool _isLoading = false;
   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _taskController = TextEditingController();
  String? _error;
  @override
  Widget build(BuildContext context) {
    
    return Container(
      height: 500,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
      child: Form(
        key: _formKey,
        child: 
        _isLoading ? const Center(child: CircularProgressIndicator.adaptive(),) :
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if(_error != null)
                Center(child: Text(_error!, style: const TextStyle(color: Colors.red),)),
                TextFormField(
              controller: _taskController,
              decoration: const InputDecoration(
                labelText: "Task Name",
                prefixIcon: Icon(Icons.task_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25))
                )
              ),

            ),
            

            const SizedBox(height: 16,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white
              ),
              onPressed: (){
                setState(() {
                  _error = null;
                });
                  if(_taskController.text.trim().isEmpty){
                    setState(() {
                      _error = "Task should not be empty";
                    });
                   }

                  else {
                        setState(() {
                          _error = null;
                          _isLoading = true;
                        });
                        final task = _taskController.text.trim();
                        TodoService.createNewTodo(task, widget.uid);
                        Navigator.pop(context);
                        setState(() {
                          _isLoading = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Added Successfully", style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),), duration: Duration(seconds: 2), showCloseIcon: true, backgroundColor: Colors.greenAccent, closeIconColor: Color.fromARGB(255, 255, 128, 119),));
                      }
                    },child:const Text("Add task"))
          ],
        ))
      );
  }
}