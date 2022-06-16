import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:poc_crud_bloc_pkg_bloc/src/core/theme/app_colors.dart';
import 'package:poc_crud_bloc_pkg_bloc/src/core/theme/app_dimension.dart';
import 'package:poc_crud_bloc_pkg_bloc/src/core/theme/app_fonts.dart';
import 'package:poc_crud_bloc_pkg_bloc/src/models/user_model.dart';
import 'package:poc_crud_bloc_pkg_bloc/src/modules/crud/list_users/controller/list_users_event.dart';
import 'package:poc_crud_bloc_pkg_bloc/src/modules/crud/list_users/controller/list_users_state.dart';

import 'controller/list_users_bloc.dart';

class ListUsersPage extends StatefulWidget {
  const ListUsersPage({Key? key}) : super(key: key);

  @override
  State<ListUsersPage> createState() => _ListUsersPageState();
}

class _ListUsersPageState extends State<ListUsersPage> {
  late final ListUsersBloc controller;

  @override
  void initState() {
    super.initState();
    controller = GetIt.I();
    controller.add(LoadListUsersEvent());
  }

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listagem'),
        actions: [
          IconButton(
            onPressed: () => controller.add(
              LoadListUsersEvent(),
            ),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppDimension.size_2,
          horizontal: AppDimension.size_3,
        ),
        child: Column(
          children: [
            Text(
              'Lista de usuários',
              style: AppFonts.titleLarge(),
            ),
            const SizedBox(
              height: AppDimension.size_5,
            ),
            BlocBuilder<ListUsersBloc, ListUsersState>(
              bloc: controller,
              builder: (context, state) {
                final users = state.users;

                if (state is ListUsersLoadingState) {
                  return _buildLoading();
                }

                if (state is ListUsersErrorState) {
                  return _buildError(state);
                }

                if (users.isEmpty) {
                  return _buildEmpty();
                }

                return _buildView(users);
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.add(
          AddListUsersEvent(
            user: UserModel(name: 'Teste Add'),
          ),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }

  Expanded _buildView(List<UserModel> users) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (_, int index) {
          final user = users[index];

          return ListTile(
            title: Text(user.name),
            trailing: IconButton(
              onPressed: () => controller.add(
                RemoveListUsersEvent(user: user),
              ),
              icon: const Icon(
                Icons.delete_forever_outlined,
                color: AppColors.red,
              ),
            ),
          );
        },
        itemCount: users.length,
      ),
    );
  }

  Expanded _buildEmpty() {
    return Expanded(
      child: Center(
        child: Text(
          'Nenhum usuário cadastrado',
          style: AppFonts.titleLarge(),
        ),
      ),
    );
  }

  Expanded _buildError(ListUsersErrorState dataValue) {
    return Expanded(
      child: Center(
        child: Text(
          dataValue.message,
          style: AppFonts.titleLarge(
            color: AppColors.red,
          ),
        ),
      ),
    );
  }

  Expanded _buildLoading() {
    return const Expanded(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
