import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_cubit/data/models/todo.dart';

import '../todo/todo_bloc.dart';

part 'completed_todos_event.dart';

part 'completed_todos_state.dart';

class CompletedTodosBloc
    extends Bloc<CompletedTodosEvent, CompletedTodosState> {
  final TodoBloc todoBloc;
  late final StreamSubscription todoBlocSubscription;

  CompletedTodosBloc(this.todoBloc) : super(CompletedTodosInitial()) {
    todoBlocSubscription = todoBloc.stream.listen((event) {
      add(LoadCompletedTodosEvent());
    });
    on<LoadCompletedTodosEvent>(_getActiveTodos);
  }

  void _getActiveTodos(
      LoadCompletedTodosEvent event, Emitter<CompletedTodosState> emit) {
    final todos = todoBloc.state.todos!.where((todo) => todo.isDone).toList();
    emit(CompletedTodosLoaded(todos));
  }

  @override
  Future<void> close() {
    todoBlocSubscription.cancel();
    return super.close();
  }
}
