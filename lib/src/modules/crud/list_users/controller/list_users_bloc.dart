import 'package:bloc/bloc.dart';
import 'package:poc_crud_bloc_pkg_bloc/src/modules/crud/list_users/controller/list_users_event.dart';
import 'package:poc_crud_bloc_pkg_bloc/src/modules/crud/list_users/controller/list_users_state.dart';
import 'package:poc_crud_bloc_pkg_bloc/src/services/user/user_service.dart';

class ListUsersBloc extends Bloc<ListUsersEvent, ListUsersState> {
  ListUsersBloc({
    required UserService userService,
  })  : _userService = userService,
        super(ListUsersInitialState()) {
    on<LoadListUsersEvent>(
      (event, emit) async {
        emit(
          ListUsersLoadingState(),
        );
        await Future.delayed(const Duration(milliseconds: 800));
        try {
          // throw Exception();
          emit(
            ListUsersSuccessState(
              users: _userService.getUsers(),
            ),
          );
        } on Exception {
          emit(
            ListUsersErrorState(message: 'Erro ao carregar lista'),
          );
        }
      },
    );

    on<AddListUsersEvent>(
      (event, emit) => emit(
        ListUsersSuccessState(
          users: _userService.addUser(event.user),
        ),
      ),
    );

    on<RemoveListUsersEvent>(
      (event, emit) => emit(
        ListUsersSuccessState(
          users: _userService.removeUser(event.user),
        ),
      ),
    );
  }

  final UserService _userService;
}
