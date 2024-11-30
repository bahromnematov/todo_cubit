import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_cubit/data/constants/tab_title_constants.dart';
import 'package:todo_cubit/logic/blocs/completed_todos/completed_todos_bloc.dart';

import 'package:todo_cubit/logic/blocs/todo/todo_bloc.dart';

import '../../logic/blocs/active_todos/active_todos_bloc.dart';
import '../widgets/manage_todo.dart';
import '../widgets/search_bar.dart';
import '../widgets/todo_list_item.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  var _init = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_init) {
      // context.read<TodoCubit>().getTodos();
      context.read<TodoBloc>().add(LoadTodosEvent());
      // context.read<ActiveTodosCubit>().getActiveTodos();
      context.read<ActiveTodosBloc>().add(LoadActiveTodosEvent());
      // context.read<CompletedTodosCubit>().getCompletedTodos();
      context.read<CompletedTodosBloc>().add(LoadCompletedTodosEvent());
    }
    _init = true;
  }

  void openManageTodo() {
    showModalBottomSheet(
        isDismissible: false, context: context, builder: (ctx) => ManageTodo());
  }

  void openSearchBar(BuildContext context) {
    showSearch(context: context, delegate: SearchBarItem());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: TabTitleConstants.tabs.length,
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.blue,
            actions: [
              IconButton(
                  onPressed: () {
                    openSearchBar(context);
                  },
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  )),
              IconButton(
                  onPressed: () {
                    openManageTodo();
                  },
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  ))
            ],
            bottom: TabBar(
              indicatorColor: Colors.white,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white.withOpacity(0.7),
              tabs: TabTitleConstants.tabs
                  .map((e) => Tab(
                        text: e,
                      ))
                  .toList(),
            ),
            title: const Text(
              "Todo Cubit",
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: TabBarView(
            children: [
              BlocBuilder<TodoBloc, TodoState>(
                builder: (context, state) {
                  if (state is TodosLoaded) {
                    return state.todos.isEmpty
                        ? const Center(
                            child: Text("No Todos"),
                          )
                        : ListView.builder(
                            itemCount: state.todos.length,
                            itemBuilder: (context, index) => TodoListItem(
                                  todo: state.todos[index],
                                ));
                  }
                  return const Center(
                    child: Text("No todos"),
                  );
                },
              ),
              BlocBuilder<ActiveTodosBloc, ActiveTodosState>(
                builder: (context, state) {
                  if (state is ActiveTodosLoaded) {
                    return state.todos.isEmpty
                        ? const Center(
                            child: Text("No Todos"),
                          )
                        : ListView.builder(
                            itemCount: state.todos.length,
                            itemBuilder: (context, index) => TodoListItem(
                                  todo: state.todos[index],
                                ));
                  } else {
                    return const Center(
                      child: Text("No Todods"),
                    );
                  }
                },
              ),
              BlocBuilder<CompletedTodosBloc, CompletedTodosState>(
                builder: (context, state) {
                  if (state is CompletedTodosLoaded) {
                    return state.todos.isEmpty
                        ? const Center(
                            child: Text("No Completed Todo"),
                          )
                        : ListView.builder(
                            itemCount: state.todos.length,
                            itemBuilder: (context, index) => TodoListItem(
                                  todo: state.todos[index],
                                ));
                  }
                  return const Center(
                    child: Text("No Completed Todo"),
                  );
                },
              ),
            ],
          )),
    );
  }
}
