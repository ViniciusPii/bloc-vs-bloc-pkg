import 'package:poc_crud_bloc_pkg_bloc/src/models/user_model.dart';

class ListUsersState {
  ListUsersState({
    required this.users,
  });

  List<UserModel> users;
}

class ListUsersInitialState extends ListUsersState {
  ListUsersInitialState() : super(users: []);
}

class ListUsersLoadingState extends ListUsersState {
  ListUsersLoadingState() : super(users: []);
}

class ListUsersSuccessState extends ListUsersState {
  ListUsersSuccessState({required List<UserModel> users}) : super(users: users);
}

class ListUsersErrorState extends ListUsersState {
  ListUsersErrorState({
    required this.message,
  }) : super(users: []);

  final String message;
}
