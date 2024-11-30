import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_cubit/logic/blocs/todo/todo_bloc.dart';

import '../../data/models/todo.dart';

class ManageTodo extends StatelessWidget {
  final Todo? todo;

  ManageTodo({super.key, this.todo});

  final _formKey = GlobalKey<FormState>();

  String _title = "";

  void _submit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (todo == null) {
        // context.read<TodoBloc>().addTodo(_title);
        context.read<TodoBloc>().add(AddNewTodoEvent(_title));
      } else {
        // context.read<TodoCubit>().editTodo(Todo(
        //     id: todo!.id, title: _title, isDone: todo!.isDone, userId: '1'));
        context.read<TodoBloc>().add(EditTodoEvent(_title, todo!.id));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print(todo);
    return BlocListener<TodoBloc, TodoState>(
      listener: (context, state) {
        if (state is TodoAdded || state is TodoEdited) {
          Navigator.pop(context);
        } else if (state is TodoError) {
          showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                    title: Text('Eror'),
                    content: Text(state.mesasge),
                  ));
        }
      },
      child: Container(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: todo == null ? "" : todo!.title,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please, enter title";
                  }
                  return null;
                },
                onSaved: (value) {
                  _title = value!;
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "Title"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Cancel")),
                  ElevatedButton(
                      onPressed: () {
                        _submit(context);
                      },
                      child: Text(todo == null ? "ADD" : "EDIT")),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
