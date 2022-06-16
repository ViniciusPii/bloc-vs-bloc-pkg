import 'package:poc_crud_bloc_pkg_bloc/src/models/user_model.dart';

class ListUsersEvent {}

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
