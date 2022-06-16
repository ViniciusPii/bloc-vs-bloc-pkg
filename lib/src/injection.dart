import 'package:get_it/get_it.dart';
import 'package:poc_crud_bloc_pkg_bloc/src/modules/crud/list_users/controller/list_users_bloc.dart';
import 'package:poc_crud_bloc_pkg_bloc/src/repositories/user/user_repository.dart';
import 'package:poc_crud_bloc_pkg_bloc/src/repositories/user/user_repository_impl.dart';
import 'package:poc_crud_bloc_pkg_bloc/src/services/user/user_service.dart';
import 'package:poc_crud_bloc_pkg_bloc/src/services/user/user_service_impl.dart';

injection() {
  final getIt = GetIt.I;

  //repositories
  getIt.registerLazySingleton<UserRepository>(() => UserRepositoryImpl());

  //services
  getIt.registerLazySingleton<UserService>(() => UserServiceImpl(userRepository: getIt()));

  //controllers
  getIt.registerFactory<ListUsersBloc>(() => ListUsersBloc(userService: getIt()));
}
