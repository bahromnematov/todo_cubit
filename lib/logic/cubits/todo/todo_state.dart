part of 'todo_cubit.dart';

@immutable
abstract class TodoState {
  final List<Todo>? todos;

  const TodoState({this.todos});
}

final class TodoInitial extends TodoState {
  final List<Todo> todos;

  const TodoInitial(this.todos);
}

class TodosLoaded extends TodoState {
  final List<Todo> todos;

  const TodosLoaded(this.todos):super(todos: todos);
}

class TodoAdded extends TodoState {}

class TodoError extends TodoState {
  final String mesasge;

  const TodoError(this.mesasge) : super();
}

class TodoEdited extends TodoState {}

class TodoToggled extends TodoState {}

class TodoDeleted extends TodoState {}
