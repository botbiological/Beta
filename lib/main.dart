import 'package:flutter/material.dart';
import 'package:provide/view/Artist/competitions_view.dart';
import 'package:provide/viewmodel/auth_viewmodel.dart';
import 'package:provide/viewmodel/login_provider.dart';
import 'package:provide/viewmodel/signup_provider.dart';
import 'package:provide/viewmodel/role_selection_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewmodel()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => SignupProvider()),
        ChangeNotifierProvider(create: (_) => RoleSelectionProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CompetitionScreen(),
      // initialRoute: RoutesName.login,
      // onGenerateRoute: Routes.generateRoutes,
    );
  }
}
