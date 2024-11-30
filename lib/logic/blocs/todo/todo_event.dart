part of 'todo_bloc.dart';

@immutable
sealed class TodoEvent {}

class LoadTodosEvent extends TodoEvent {}

class AddNewTodoEvent extends TodoEvent {
  final String title;

  AddNewTodoEvent(this.title);
}

class EditTodoEvent extends TodoEvent {
  final String id;
  final String title;

  EditTodoEvent(this.title, this.id);
}

class ToggleTodoEvent extends TodoEvent {
  final String id;

  ToggleTodoEvent(this.id);
}

class DeleteTodoEvent extends TodoEvent {
  final String id;

  DeleteTodoEvent(this.id);
}
