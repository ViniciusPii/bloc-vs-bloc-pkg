import 'package:poc_crud_bloc_pkg_bloc/src/models/user_model.dart';

abstract class UserRepository {
  List<UserModel> getUsers();
  List<UserModel> addUser(UserModel user);
  List<UserModel> removeUser(UserModel user);
}
