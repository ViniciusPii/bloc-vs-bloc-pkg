import 'dart:async';

import 'package:poc_crud_bloc_pkg_bloc/src/models/user_model.dart';
import 'package:poc_crud_bloc_pkg_bloc/src/modules/crud/list_users/controller/list_users_event.dart';
import 'package:poc_crud_bloc_pkg_bloc/src/modules/crud/list_users/controller/list_users_state.dart';
import 'package:poc_crud_bloc_pkg_bloc/src/services/user/user_service.dart';

class ListUsersBloc {
  ListUsersBloc({
    required UserService userService,
  }) : _userService = userService {
    _listUserEventController.stream.listen(_mapEvent);
  }

  final UserService _userService;

  final _listUserEventController = StreamController<ListUsersEvent>();
  final _listUserStateController = StreamController<ListUsersState>();

  Sink<ListUsersEvent> get listUserEventSink => _listUserEventController.sink;
  Stream<ListUsersState> get listUserStateStream => _listUserStateController.stream;

  _mapEvent(ListUsersEvent event) async {
    List<UserModel> users = [];

    _listUserStateController.add(ListUsersLoadingState());

    await Future.delayed(const Duration(milliseconds: 500));

    try {
      if (event is LoadListUsersEvent) {
        users = _userService.getUsers();
      } else if (event is AddListUsersEvent) {
        users = _userService.addUser(event.user);
      } else if (event is RemoveListUsersEvent) {
        users = _userService.removeUser(event.user);
      }
      // throw Exception();
      _listUserStateController.add(ListUsersSuccessState(users: users));
    } on Exception {
      _listUserStateController.add(ListUsersErrorState(message: 'Erro ao carregar lista'));
    }
  }

  void dispose() {
    _listUserEventController.close();
    _listUserStateController.close();
  }
}
