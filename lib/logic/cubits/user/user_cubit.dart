import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo_cubit/data/models/user.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit()
      : super(UserInitial(
          User(id: 'user1', name: "User1"),
        ));

  User get currentUser {
    return state.user!;
  }
}
