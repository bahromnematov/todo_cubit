import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:todo_cubit/data/models/todo.dart';

import '../user/user_cubit.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  final UserCubit userCubit;

  TodoCubit({required this.userCubit})
      : super(TodoInitial([
          Todo(
              id: UniqueKey().toString(),
              title: 'Go Home',
              isDone: false,
              userId: 'user1'),
          Todo(
              id: UniqueKey().toString(),
              title: 'Go Shopping',
              isDone: true,
              userId: 'user1'),
          Todo(
              id: UniqueKey().toString(),
              title: 'Go Swimming',
              isDone: false,
              userId: 'user1'),
          Todo(
              id: UniqueKey().toString(),
              title: 'Go Football',
              isDone: false,
              userId: 'user1'),
        ]));

  void getTodos() {
    //filter by userId
    final user = userCubit.currentUser;
    final todos = state.todos!.where((todo) => todo.userId == user.id).toList();
    emit(TodosLoaded(todos));
  }

  void addTodo(String title) {
    try {
      final todo = Todo(id: UniqueKey().toString(), title: title, userId: '1');
      final todos = state.todos;
      todos!.add(todo);
      emit(TodoAdded());
      emit(TodosLoaded(todos));
    } catch (e) {
      emit(TodoError('Error occured!'));
    }
  }

  void editTodo(Todo todo) {
    try {
      final todos = state.todos;
      final index = todos!.indexWhere((element) => element.id == todo.id);
      todos[index] = todo;
      // todos.add(todo);
      emit(TodoEdited());
      emit(TodosLoaded(todos));
    } catch (e) {
      emit(TodoError('Error occured!'));
    }
  }

  void toggleTodo(String id) {
    final todos = state.todos!.map((todo) {
      if (todo.id == id) {
        return Todo(
            id: id,
            title: todo.title,
            isDone: !todo.isDone,
            userId: todo.userId);
      }
      return todo;
    }).toList();
    emit(TodoToggled());
    emit(TodosLoaded(todos));
  }

  void deleteTodo(String id) {
    final todos = state.todos;
    todos!.removeWhere((todo) => todo.id == id);
    emit(TodoDeleted());
    emit(TodosLoaded(todos));
  }

  List<Todo> searchTodods(String title) {
    return state.todos!
        .where((element) =>
            element.title.toLowerCase().contains(title.toLowerCase()))
        .toList();
  }
}
