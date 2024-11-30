part of 'active_todos_bloc.dart';

@immutable
sealed class ActiveTodosState {}

final class ActiveTodosInitial extends ActiveTodosState {}

class ActiveTodosLoaded extends ActiveTodosState {
  final List<Todo> todos;

  ActiveTodosLoaded(this.todos);
}