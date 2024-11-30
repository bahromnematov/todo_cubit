part of 'user_bloc.dart';

@immutable
sealed class UserState {
  final User? user;

  const UserState({this.user});
}

final class UserInitial extends UserState {
  UserInitial(User user) : super(user: user);
}
