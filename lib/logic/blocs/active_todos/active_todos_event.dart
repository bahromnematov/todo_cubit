part of 'active_todos_bloc.dart';

@immutable
sealed class ActiveTodosEvent {}

class LoadActiveTodosEvent extends ActiveTodosEvent {}
