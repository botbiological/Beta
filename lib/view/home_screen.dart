import 'package:flutter/material.dart';
import 'package:provide/res/components/custom_bottom_navigation_bar.dart';
import 'package:provide/view/Artist/artist_home_view.dart';
import 'package:provide/view/Artist/competitions_view.dart';
import 'package:provide/view/Artist/insides_view.dart';
import 'package:provide/view/Artist/my_tracks_view.dart';
import 'package:provide/view/Artist/upload_view.dart';
import 'package:provide/view/DJ/dj_home_view.dart';
import 'package:provide/view/DJ/insides_view_dj.dart';
import 'package:provide/view/DJ/my_track_view_dj.dart';
import 'package:provide/view/Prodicer/compition_view.dart';
import 'package:provide/view/Prodicer/indies_view.dart';
import 'package:provide/view/Prodicer/my_tracks_viewe.dart';
import 'package:provide/view/Prodicer/producer_home_view.dart';
import 'package:provide/view/user/chat_view.dart';
import 'package:provide/view/user/competitions_view.dart';
import 'package:provide/view/user/home_screen.dart';
import 'package:provide/view/user/library_view.dart';
import 'package:provide/viewmodel/role_selection_provider.dart';


class MainPage extends StatefulWidget {
  final String role;
  const MainPage({super.key, required this.role});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  // Return screens based on role
  List<Widget> getPagesForRole(String role) {
    switch (role.toLowerCase()) {
      case 'user':
        return [
          HomeView(),
          CompetitionsView(),
          UploadView(),
          LibraryView(),
          ChatView(),
        ];

      case 'artist':
        return [
          ArtistHomeView(),
          ArtistMytracksView(),
          InsidesView(),
          CompetitionScreen(),
          ChatView(),
        ];

      case 'producer':
        return [
          ProducerHomeView(),
          ProducerMytracksView(),
          ProducerInsidesView(),
          ProducerCompetitionScreen(),
          ChatView(),
        ];

      case 'dj':
        return [
          DjHomeView(),
          MyTrackViewDj(),
          InsidesViewDj(),
          ProducerCompetitionScreen(),
          ChatView(),
        ];

      default:
        return [
          Center(child: Text("Invalid role: $role")),
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final pages = getPagesForRole(widget.role);

    return Scaffold(
      backgroundColor: Colors.black,
      body: pages[_selectedIndex],

      bottomNavigationBar: CustomBottomNavBar(
        role: widget.role,
        selectedIndex: _selectedIndex,
        onTap: (index) {
          setState(() => _selectedIndex = index);
        },
      ),
    );
  }
}




// class MainPage extends StatefulWidget {
//   String? role;
//   MainPage({super.key, this.role});

//   @override
//   State<MainPage> createState() => _MainPageState();
// }

// class _MainPageState extends State<MainPage> {
//   int _selectedIndex = 0;
//   RoleSelectionProvider? roleProvider;

//   List<Widget> getPagesForRole(String role) {
//     switch (role.toLowerCase()) {
//       case 'user':
//         return [
//           HomeView(),
//           CompetitionsView(),
//           UploadView(),
//           LibraryView(),
//           ChatView(),
//         ];
//       case 'artist':
//         return [
//           ArtistHomeView(),
//           ArtistMytracksView(),
//           InsidesView(),
//           CompetitionScreen(),
//           ChatView(),
//         ];
//       case 'producer':
//         return [
//           ProducerHomeView(),
//           ProducerMytracksView(),
//           ProducerInsidesView(),
//           ProducerCompetitionScreen(),
//           ChatView(),
//         ];
//       default: // DJ or others
//         return [
//           DjHomeView(),
//           MyTrackViewDj(),
//           InsidesViewDj(),
//           ProducerCompetitionScreen(),
//           ChatView(),
//         ];
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final _pages = getPagesForRole(widget.role ?? '');

//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: _pages[_selectedIndex],

//       bottomNavigationBar: CustomBottomNavBar(
//         selectedIndex: _selectedIndex,
//         role: widget.role ?? 'User',
//         onTap: (index) {
//           setState(() {
//             _selectedIndex = index;
//           });
//         },
//       ),
//     );
//   }
// }
