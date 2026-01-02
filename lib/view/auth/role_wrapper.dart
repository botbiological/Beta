import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provide/res/components/app_color.dart';
import 'package:provide/view/Artist/artist_home_view.dart';
import 'package:provide/view/DJ/dj_home_view.dart';
import 'package:provide/view/Prodicer/producer_home_view.dart';
import 'package:provide/view/auth/loginview.dart';
import 'package:provide/view/home_screen.dart';
import 'package:provide/view/user/home_screen.dart';

class RoleWrapper extends StatelessWidget {
  const RoleWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // 1. Still loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // 2. User not logged in → go to Login screen
        if (!snapshot.hasData) {
          return const Loginview();
        }

        // 3. User logged in → fetch role
        User user = snapshot.data!;

        return FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .get(),
          builder: (context, roleSnapshot) {
            // While fetching role
            if (roleSnapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                backgroundColor: AppColor.darkGray,
                body: Center(
                    child: CircularProgressIndicator(
                  color: AppColor.seconadryColor,
                )),
              );
            }

            // If no role found
            if (!roleSnapshot.hasData || !roleSnapshot.data!.exists) {
              return const Scaffold(
                body: Center(
                  child: Text("No role found for this user."),
                ),
              );
            }

            // Extract role
            String role = roleSnapshot.data!.get("role");

            switch (role) {
              case "dj":
                return MainPage(role: "dj");

              case "producer":
                return MainPage(role: "producer");

              case "artist":
                return MainPage(role: "artist");

              case "user":
                return MainPage(role: "user");

              default:
                return const Scaffold(
                  body: Center(child: Text("Invalid role")),
                );
            }

            // 4. Navigate based on role
            // switch (role) {
            //   case "dj":
            //     return const DjHomeView();

            //   case "producer":
            //     return const ProducerHomeView();

            //   case "artist":
            //     return const ArtistHomeView();

            //   case "user":
            //     return const HomeView();

            //   default:
            //     return const Scaffold(
            //       body: Center(child: Text("Invalid role")),
            //     );
            // }
          },
        );
      },
    );
  }
}
