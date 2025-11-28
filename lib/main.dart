import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provide/firebase_options.dart';
import 'package:provide/utils/routes/routes.dart';
import 'package:provide/utils/routes/routes_name.dart';

import 'package:provide/viewmodel/auth_viewmodel.dart';
import 'package:provide/viewmodel/login_provider.dart';
import 'package:provide/viewmodel/signup_provider.dart';
import 'package:provide/viewmodel/role_selection_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
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

      initialRoute: RoutesName.login,
      onGenerateRoute: Routes.generateRoutes,
    );
  }
}
