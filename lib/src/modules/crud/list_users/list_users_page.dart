import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:poc_crud_bloc_pkg_bloc/src/core/theme/app_colors.dart';
import 'package:poc_crud_bloc_pkg_bloc/src/core/theme/app_dimension.dart';
import 'package:poc_crud_bloc_pkg_bloc/src/core/theme/app_fonts.dart';
import 'package:poc_crud_bloc_pkg_bloc/src/models/user_model.dart';
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
    controller.listUserEventSink.add(LoadListUsersEvent());
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listagem'),
        actions: [
          IconButton(
            onPressed: () => controller.listUserEventSink.add(
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
            StreamBuilder<ListUsersState>(
              stream: controller.listUserStateStream,
              builder: (context, snapshot) {
                final users = snapshot.data?.users ?? [];
                final dataValue = snapshot.data;

                if (dataValue is ListUsersLoadingState) {
                  return _buildLoading();
                }

                if (dataValue is ListUsersErrorState) {
                  return _buildError(dataValue);
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
        onPressed: () => controller.listUserEventSink.add(
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
              onPressed: () => controller.listUserEventSink.add(
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
