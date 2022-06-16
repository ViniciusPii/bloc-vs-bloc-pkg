part of 'list_users_bloc.dart';

abstract class ListUsersEvent {}

class LoadListUsersEvent extends ListUsersEvent {}

class AddListUsersEvent extends ListUsersEvent {
  AddListUsersEvent({
    required this.user,
  });

  final UserModel user;
}

class RemoveListUsersEvent extends ListUsersEvent {
  RemoveListUsersEvent({
    required this.user,
  });

  final UserModel user;
}
