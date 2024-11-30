part of 'completed_todos_bloc.dart';

@immutable
sealed class CompletedTodosEvent {}

class LoadCompletedTodosEvent extends CompletedTodosEvent {}
