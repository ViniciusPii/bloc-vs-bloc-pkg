import 'package:poc_crud_bloc_pkg_bloc/src/models/user_model.dart';
import 'package:poc_crud_bloc_pkg_bloc/src/repositories/user/user_repository.dart';
import 'package:poc_crud_bloc_pkg_bloc/src/services/user/user_service.dart';

class UserServiceImpl implements UserService {
  UserServiceImpl({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  final UserRepository _userRepository;

  @override
  List<UserModel> getUsers() => _userRepository.getUsers();

  @override
  List<UserModel> addUser(UserModel user) => _userRepository.addUser(user);

  @override
  List<UserModel> removeUser(UserModel user) => _userRepository.removeUser(user);
}
