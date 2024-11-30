import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_cubit/logic/cubits/todo/todo_cubit.dart';

class SearchBarItem extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      TextButton(
          onPressed: () {
            query = "";
          },
          child: Text("Clear"))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back_ios));
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isNotEmpty) {
      final todos = context.read<TodoCubit>().searchTodods(query);
      return todos.isEmpty
          ? Center(child: Text("Can't fineds Todos"))
          : ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(todos[index].title),
                );
              },
            );
    } else {
      return Container();
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isNotEmpty) {
      final todos = context.read<TodoCubit>().searchTodods(query);
      return todos.isEmpty
          ? Center(child: Text("Can't fineds Todos"))
          : ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(todos[index].title),
                );
              },
            );
    } else {
      return Container();
    }
  }
}
