import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_cubit/data/models/todo.dart';

import '../todo/todo_cubit.dart';

part 'active_todos_state.dart';

class ActiveTodosCubit extends Cubit<ActiveTodosState> {
  late final StreamSubscription todoCubitSubscription;
  final TodoCubit todoCubit;

  ActiveTodosCubit(this.todoCubit) : super(ActiveTodosInitial()) {
    todoCubitSubscription = todoCubit.stream.listen((TodoState state) {
      getActiveTodos();
    });
  }

  void getActiveTodos() {
    final todos = todoCubit.state.todos!.where((todo) => !todo.isDone).toList();
    emit(ActiveTodosLoaded(todos));
  }

  @override
  Future<void> close() {
    todoCubitSubscription.cancel();
    return super.close();
  }
}
