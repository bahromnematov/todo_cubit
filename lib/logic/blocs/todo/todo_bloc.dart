import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:todo_cubit/data/models/todo.dart';

import '../user/user_bloc.dart';

part 'todo_event.dart';

part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final UserBloc userBloc;

  TodoBloc(this.userBloc)
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
        ])) {
    on<LoadTodosEvent>(_getTodos);
    on<AddNewTodoEvent>(_addTodo);
    on<EditTodoEvent>(_editTodo);
    on<ToggleTodoEvent>(_toggleTodo);
    on<DeleteTodoEvent>(_deleteTodo);
  }

  void _getTodos(LoadTodosEvent event, Emitter<TodoState> emit) {
    //filter by userId
    final user = userBloc.currentUser;
    final todos = state.todos!.where((todo) => todo.userId == user.id).toList();
    emit(TodosLoaded(todos));
  }

  void _addTodo(AddNewTodoEvent event, Emitter<TodoState> emit) {
    final user = userBloc.currentUser;
    try {
      final todo =
          Todo(id: UniqueKey().toString(), title: event.title, userId: user.id);
      final todos = state.todos;
      todos!.add(todo);
      emit(TodoAdded());
      emit(TodosLoaded(todos));
    } catch (e) {
      emit(TodoError('Error occured!'));
    }
  }

  void _editTodo(EditTodoEvent event, Emitter<TodoState> emit) {
    try {
      final todos = state.todos!.map((t) {
        if (t.id == event.id) {
          return Todo(id: event.id, title: event.title, userId: t.userId);
        }
        return t;
      }).toList();
      emit(TodoEdited());
      emit(TodosLoaded(todos));
    } catch (e) {
      emit(TodoError('Error occured!'));
    }
  }

  void _toggleTodo(ToggleTodoEvent event, Emitter<TodoState> emit) {
    final todos = state.todos!.map((todo) {
      if (todo.id == event.id) {
        return Todo(
            id: event.id,
            title: todo.title,
            isDone: !todo.isDone,
            userId: todo.userId);
      }
      return todo;
    }).toList();
    emit(TodoToggled());
    emit(TodosLoaded(todos));
  }

  void _deleteTodo(DeleteTodoEvent event, Emitter<TodoState> emit) {
    final todos = state.todos;
    todos!.removeWhere((todo) => todo.id == event.id);
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
