import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_cubit/logic/blocs/active_todos/active_todos_bloc.dart';
import 'package:todo_cubit/logic/blocs/completed_todos/completed_todos_bloc.dart';
import 'package:todo_cubit/logic/blocs/todo/todo_bloc.dart';
import 'package:todo_cubit/logic/blocs/user/user_bloc.dart';
import 'package:todo_cubit/logic/cubits/active_todos/active_todos_cubit.dart';
import 'package:todo_cubit/logic/cubits/completed_todos/completed_todos_cubit.dart';
import 'package:todo_cubit/logic/cubits/todo/todo_cubit.dart';
import 'package:todo_cubit/logic/cubits/user/user_cubit.dart';
import 'package:todo_cubit/presentation/screens/todo_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider(
        //   create: (ctx) => UserCubit(),
        // ),
        // BlocProvider(
        //   create: (ctx) => TodoCubit(userCubit: ctx.read<UserCubit>()),
        // ),
        // BlocProvider(
        //   create: (ctx) => ActiveTodosCubit(ctx.read<TodoCubit>()),
        // ),
        // BlocProvider(
        //   create: (ctx) => CompletedTodosCubit(ctx.read<TodoCubit>()),
        // ),
        BlocProvider(create: (ctx) => UserBloc()),
        BlocProvider(create: (ctx) => TodoBloc(ctx.read<UserBloc>())),
        BlocProvider(create: (ctx) => ActiveTodosBloc(ctx.read<TodoBloc>())),
        BlocProvider(create: (ctx) => CompletedTodosBloc(ctx.read<TodoBloc>()))
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            // colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
            useMaterial3: true,
          ),
          home: TodoScreen()),
    );
  }
}
