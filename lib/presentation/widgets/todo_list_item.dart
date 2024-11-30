import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_cubit/logic/blocs/todo/todo_bloc.dart';
import 'package:todo_cubit/logic/cubits/todo/todo_cubit.dart';

import '../../data/models/todo.dart';
import 'manage_todo.dart';

class TodoListItem extends StatelessWidget {
  final Todo todo;

  const TodoListItem({super.key, required this.todo});

  void openManageTodo(BuildContext context) {
    showModalBottomSheet(
        isDismissible: false,
        context: context,
        builder: (ctx) => ManageTodo(
              todo: todo,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: IconButton(
        onPressed: () => context.read<TodoBloc>().add(ToggleTodoEvent(todo.id)),
        icon: Icon(todo.isDone
            ? Icons.check_box_outlined
            : Icons.check_box_outline_blank),
      ),
      title: Text(
        todo.title,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 18,
          decoration:
              todo.isDone ? TextDecoration.lineThrough : TextDecoration.none,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
              onPressed: () =>
                  context.read<TodoBloc>().add(DeleteTodoEvent(todo.id)),
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              )),
          IconButton(
              onPressed: () => openManageTodo(context),
              icon: const Icon(Icons.edit)),
        ],
      ),
    );
  }
}
