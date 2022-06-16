import 'package:flutter/material.dart';
import 'package:poc_crud_bloc_pkg_bloc/src/core/theme/app_theme.dart';
import 'package:poc_crud_bloc_pkg_bloc/src/routes/routes.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: Routes().routes,
      theme: AppTheme.defaultTheme,
      initialRoute: Routes.listUsers,
      debugShowCheckedModeBanner: false,
    );
  }
}
