import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_cubit/data/models/todo.dart';

import '../todo/todo_bloc.dart';

part 'active_todos_event.dart';

part 'active_todos_state.dart';

class ActiveTodosBloc extends Bloc<ActiveTodosEvent, ActiveTodosState> {
  final TodoBloc todoBloc;
  late final StreamSubscription todoBlocSubscription;

  ActiveTodosBloc(this.todoBloc) : super(ActiveTodosInitial()) {
    todoBlocSubscription = todoBloc.stream.listen((event) {
      add(LoadActiveTodosEvent());
    });
    on<LoadActiveTodosEvent>(_getActiveTodos);
  }

  void _getActiveTodos(
      LoadActiveTodosEvent event, Emitter<ActiveTodosState> emit) {
    final todos = todoBloc.state.todos!.where((todo) => !todo.isDone).toList();
    emit(ActiveTodosLoaded(todos));
  }

  @override
  Future<void> close() {
    todoBlocSubscription.cancel();
    return super.close();
  }
}
