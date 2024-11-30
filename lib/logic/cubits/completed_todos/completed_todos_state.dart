part of 'completed_todos_cubit.dart';

@immutable
sealed class CompletedTodosState {}

final class CompletedTodosInitial extends CompletedTodosState {}

class CompletedTodosLoaded extends CompletedTodosState {
  final List<Todo> todos;

  CompletedTodosLoaded(this.todos);
}
