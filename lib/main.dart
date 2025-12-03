import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provide/firebase_options.dart';
import 'package:provide/utils/routes/routes.dart';
import 'package:provide/utils/routes/routes_name.dart';
import 'package:provide/view/Artist/artist_home_view.dart';
import 'package:provide/view/DJ/dj_home_view.dart';
import 'package:provide/view/Prodicer/producer_home_view.dart';
import 'package:provide/view/auth/loginview.dart';
import 'package:provide/view/auth/role_wrapper.dart';
import 'package:provide/view/user/home_screen.dart';

import 'package:provide/viewmodel/auth_viewmodel.dart';
import 'package:provide/viewmodel/login_provider.dart';
import 'package:provide/viewmodel/logout_viewmodel.dart';
import 'package:provide/viewmodel/signup_provider.dart';
import 'package:provide/viewmodel/role_selection_provider.dart';
import 'package:provide/services/track_service.dart';
import 'package:provide/services/music_player_service.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Seed dummy tracks to Firebase if database is empty
  try {
    await TrackService().seedDummyTracks();
  } catch (e) {
    debugPrint('Error seeding tracks: $e');
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewmodel()),
        ChangeNotifierProvider(create: (_) => LogoutViewmodel()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => SignupProvider()),
        ChangeNotifierProvider(create: (_) => RoleSelectionProvider()),
        ChangeNotifierProvider(create: (_) => MusicPlayerService()),
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
      home: RoleWrapper(),
      routes: {
        '/login': (context) => const Loginview(),
        '/userHome': (context) => const HomeView(),
        '/djHome': (context) => const DjHomeView(),
        '/producerHome': (context) => const ProducerHomeView(),
        '/artistHome': (context) => const ArtistHomeView(),
      },
      // initialRoute: RoutesName.login,
      onGenerateRoute: Routes.generateRoutes,
    );
  }
}
