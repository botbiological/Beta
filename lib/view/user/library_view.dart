import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provide/model/librarymodel.dart';
import 'package:provide/res/components/app_color.dart';
import 'package:provide/utils/routes/responsive.dart';
import 'package:provide/view/user/my_tracks_view.dart';
import 'package:provide/view/user/playlist_view.dart';
import 'package:provide/view/user/saved_artists_view.dart';
import 'package:provide/viewmodel/libary_viewmodel.dart';
import 'package:provide/widgets/custom_circle_avatar.dart';
import 'package:provide/widgets/text_widget.dart';

class LibraryView extends StatefulWidget {
  const LibraryView({super.key});

  @override
  State<LibraryView> createState() => _LibraryViewState();
}

class _LibraryViewState extends State<LibraryView> {
  final LibraryViewModel _viewModel = LibraryViewModel();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);

    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: SafeArea(
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            // Using SliverAppBar for better scrolling behavior
            SliverAppBar(
              backgroundColor: AppColor.primaryColor,
              pinned: true,
              floating: true,
              expandedHeight: Responsive.h(10),
              flexibleSpace: FlexibleSpaceBar(
                background: Container(color: AppColor.primaryColor),
              ),
              title: _buildHeader(),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: Responsive.padding(left: 1, right: 1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Library sections
                    ..._buildLibrarySections(),

                    // Divider with proper theming
                    Divider(
                      height: Responsive.h(3),
                      color: Colors.white.withValues(alpha:  0.2),
                    ),

                    // Recently played section
                    Padding(
                      padding: EdgeInsets.only(bottom: Responsive.h(1)),
                      child: Text(
                        "Recently played",
                        style: GoogleFonts.onest(
                          color: Colors.white,
                          fontSize: Responsive.textScaleFactor * 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // List of tracks with proper sliver implementation
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final track = _viewModel.recentlyPlayed[index];
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: Responsive.h(0.5)),
                  child: PlayCard(track: track),
                );
              }, childCount: _viewModel.recentlyPlayed.length),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Library',
          style: GoogleFonts.onest(
            color: Colors.white,
            fontSize: Responsive.textScaleFactor * 20,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.30,
          ),
        ),
        Row(
          children: [
            // Added proper spacing between icons
            CustomTinyCircleAvatar(
              baseColor: AppColor.textColor.withValues(alpha: 0.1),
              iconPadding: const EdgeInsets.all(5),
              imageUrl: "assets/icons/notification.svg",
              isAsset: true,
              bgColor: const Color(0x1AFFFFFF),
            ),
            SizedBox(width: Responsive.w(2)),
            CustomTinyCircleAvatar(
              baseColor: AppColor.textColor.withValues(alpha: 0.1),
              bgColor: const Color(0x1AFFFFFF),
              imageUrl: "assets/icons/profile.svg",
              isAsset: true,
            ),
          ],
        ),
      ],
    );
  }

  List<Widget> _buildLibrarySections() {
    return _viewModel.librarySections.map((section) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: Responsive.h(1)),
        child: ClickText(
          text: section,
          onTap: () => _handleSectionTap(section),
        ),
      );
    }).toList();
  }

void _handleSectionTap(String section) {
  Widget destination;
  
  switch (section) {
    case "Playlist":
      destination = const PlaylistView();
      break;
    case "My Tracks":
      destination = const MytracksView();
      break;
    case "Saved Artists":
      destination = const SavedArtistsView();
      break;
    default:
      // Fallback to a default screen or show error
      return;
  }
  
  Navigator.push(
    context, 
    MaterialPageRoute(builder: (_) => destination)
  );
  
  debugPrint('Tapped on: $section');
}
}

class PlayCard extends StatelessWidget {
  final LibraryTrack track;

  const PlayCard({super.key, required this.track});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: const Color(0x1AFFFFFF),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            // Improved image widget with error handling
            _buildTrackImage(),
            SizedBox(width: Responsive.w(2)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text: track.title,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: Responsive.h(0.5)),
                  TextWidget(
                    text: "By ${track.artist}",
                    fontSize: 8,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(height: Responsive.h(0.5)),
                  TextWidget(
                    text: "Produced by: ${track.producer}",
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ),
            Column(
              children: [
                TextWidget(text: _formatStreams(track.streams), fontSize: 10),
                SizedBox(height: Responsive.h(0.5)),
                Text(
                  _formatDuration(track.duration),
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.6),
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrackImage() {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey[300],
      ),
      child: track.imageAsset.endsWith('.svg')
          ? SvgPicture.asset(track.imageAsset)
          : Image.asset(track.imageAsset, fit: BoxFit.cover),
    );
  }

  String _formatStreams(int streams) {
    if (streams >= 1000000) {
      return '${(streams / 1000000).toStringAsFixed(1)}M Streams';
    } else if (streams >= 1000) {
      return '${(streams / 1000).toStringAsFixed(1)}K Streams';
    }
    return '$streams Streams';
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }
}

class ClickText extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const ClickText({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: GoogleFonts.onest(
                color: Colors.white,
                fontSize: Responsive.textScaleFactor * 14,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.30,
              ),
            ),
            SvgPicture.asset(
              "assets/icons/Arrow.svg",
              color: Colors.white.withValues(alpha: 0.7),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provide/res/components/app_color.dart';
// import 'package:provide/utils/routes/responsive.dart';
// import 'package:provide/widgets/custom_circle_avatar.dart';
// import 'package:provide/widgets/text_widget.dart';

// class LibraryView extends StatelessWidget {
//   const LibraryView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     Responsive.init(context);
//     return Scaffold(
//       backgroundColor: AppColor.primaryColor,
//       body: SafeArea(
//         child: ListView(
//           children: [
//             Padding(
//               padding: Responsive.padding(left: 1, right: 1, bottom: 1, top: 1),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Library',
//                         style: GoogleFonts.onest(
//                           color: Colors.white,
//                           fontSize: Responsive.textScaleFactor * 20,
//                           fontWeight: FontWeight.w600,
//                           letterSpacing: -0.30,
//                         ),
//                       ),
//                       Row(
//                         children: [
//                           CustomTinyCircleAvatar(
//                             baseColor: AppColor.textColor.withValues(
//                               alpha: 0.1,
//                             ),

//                             iconPadding: EdgeInsets.all(5),
//                             imageUrl: "assets/icons/notification.svg",
//                             isAsset: true,
//                             bgColor: Color(0x1AFFFFFF),
//                           ),

//                           CustomTinyCircleAvatar(
//                             baseColor: AppColor.textColor.withValues(
//                               alpha: 0.1,
//                             ),
//                             bgColor: Color(0x1AFFFFFF),
//                             imageUrl: "assets/icons/profile.svg",
//                             isAsset: true,
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   ClickText(text: "Playlist", onTap: () {}),
//                   ClickText(text: "My Tracks", onTap: () {}),
//                   ClickText(text: "Saved Artists", onTap: () {}),

//                   Row(children: [Expanded(child: Divider())]),

//                   TextWidget(text: "Recently played"),

//                   ListView.builder(
//                     shrinkWrap: true,
//                     physics: NeverScrollableScrollPhysics(),
//                     itemCount: 10,
//                     itemBuilder: ((context, index) {
//                       return Padding(
//                         padding: EdgeInsets.symmetric(
//                           vertical: Responsive.h(0.5),
//                         ), // Add vertical spacing
//                         child: PlayCard(),
//                       );
//                     }),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class PlayCard extends StatelessWidget {
//   const PlayCard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(18),
//         color: Color(0x1AFFFFFF),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Row(
//           children: [
//             Image.asset("assets/icons/Component 1 (1).png"),
//             // SvgPicture.asset("assets/images/Component 1.png"),
//             SizedBox(width: Responsive.w(2)),
//             Column(
//               spacing: Responsive.h(1),
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 TextWidget(
//                   text: "No Sleep Tonight",
//                   fontSize: 14,
//                   fontWeight: FontWeight.w600,
//                 ),

//                 TextWidget(
//                   text: "By Young Blaze",
//                   fontSize: 8,
//                   fontWeight: FontWeight.w400,
//                 ),
//                 Row(
//                   children: [
//                     TextWidget(
//                       text: "Produced by: Khaled",
//                       fontSize: 10,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             Spacer(),
//             Column(children: [TextWidget(text: "32.4K Streams", fontSize: 10)]),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ClickText extends StatelessWidget {
//   final String text;
//   final VoidCallback onTap;
//   const ClickText({super.key, required this.text, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     Responsive.init(context);
//     return GestureDetector(
//       onTap: onTap,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             text,
//             style: GoogleFonts.onest(
//               color: Colors.white,
//               fontSize: Responsive.textScaleFactor * 14,
//               fontWeight: FontWeight.bold,
//               letterSpacing: -0.30,
//             ),
//           ),
//           SvgPicture.asset("assets/icons/Arrow.svg"),
//         ],
//       ),
//     );
//   }
// }
