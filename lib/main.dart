import 'package:flutter/material.dart';
import 'package:provide/view/Artist/artist_profile_view.dart';
import 'package:provide/view/Artist/artitist_profile_view.dart';
import 'package:provide/view/Artist/competitions_view.dart';
import 'package:provide/view/Artist/edit_profile_artist_view.dart';
import 'package:provide/view/Artist/insides_view.dart';
import 'package:provide/view/Artist/my_tracks_view.dart';
import 'package:provide/view/Artist/profile_setup_view.dart';
import 'package:provide/view/user/artist_profile_public_view.dart';
import 'package:provide/view/user/competitions_view.dart';
import 'package:provide/view/user/edit_profile_view.dart';
import 'package:provide/view/user/library_view.dart';
import 'package:provide/view/user/producer_profile_public_view.dart';
import 'package:provide/view/user/profile_view.dart';
import 'package:provide/view/user/saved_artists_view.dart';
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
