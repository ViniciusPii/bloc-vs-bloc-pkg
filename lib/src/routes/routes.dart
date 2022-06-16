import 'package:poc_crud_bloc_pkg_bloc/src/modules/crud/list_users/list_users_page.dart';

class Routes {
  static const String listUsers = '/list-users';

  final routes = {
    listUsers: (context) => const ListUsersPage(),
  };
}
