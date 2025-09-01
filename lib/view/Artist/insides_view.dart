import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provide/res/components/app_color.dart';
import 'package:provide/utils/routes/responsive.dart';
import 'package:provide/widgets/custom_circle_avatar.dart';
import 'package:provide/widgets/text_widget.dart';

class InsidesView extends StatelessWidget {
  const InsidesView({super.key});

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            spacing: 5,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              deatilsCard("Total Streams", "12,540"),
              SizedBox(height: Responsive.h(1)),
              deatilsCard("Total Likes", "2134"),
              SizedBox(height: Responsive.h(1)),
              deatilsCard("Follower Growth", "342"),
              Row(children: [Expanded(child: Divider())]),
              TextWidget(text: "Per Track Insides", fontSize: 16),

              SizedBox(
                height: 320,
                child: PageView.builder(
                  itemCount: 5,
                  itemBuilder: ((context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: AppColor.whiteColor.withValues(alpha: 0.10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            spacing: 2,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: Image(
                                  fit: BoxFit.fill,
                                  image: AssetImage(
                                    "assets/images/Component 1 (4).png",
                                  ),
                                ),
                              ),
                              SizedBox(height: Responsive.h(0.5)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextWidget(text: "No Sleep Tonight"),
                                  TextWidget(text: "Hip-Hop"),
                                ],
                              ),
                              Row(children: [Expanded(child: Divider())]),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,

                                children: [
                                  TextWidget(text: "Streams"),
                                  TextWidget(text: "33.2k"),
                                ],
                              ),
                              SizedBox(height: Responsive.h(0.5)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,

                                children: [
                                  TextWidget(text: "Votes"),
                                  TextWidget(text: "9,812"),
                                ],
                              ),
                              SizedBox(height: Responsive.h(0.5)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,

                                children: [
                                  TextWidget(text: "Likes"),
                                  TextWidget(text: "12k"),
                                ],
                              ),
                              SizedBox(height: Responsive.h(0.5)),

                              Row(
                                children: [
                                  TextWidget(text: "View Full Analytic"),
                                  SizedBox(width: Responsive.w(1)),
                                  SvgPicture.asset("assets/icons/Arrow.svg"),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildHeader() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      TextWidget(text: "My Tracks", fontSize: 20, fontWeight: FontWeight.w600),
      Row(
        // Using MainAxisAlignment instead of non-existent spacing property
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomTinyCircleAvatar(
            baseColor: AppColor.textColor.withOpacity(0.1),
            iconPadding: const EdgeInsets.all(5),
            imageUrl: "assets/icons/notification.svg",
            isAsset: true,
            bgColor: const Color(0x1AFFFFFF),
          ),
          SizedBox(width: Responsive.w(2)),
          CustomTinyCircleAvatar(
            baseColor: AppColor.textColor.withOpacity(0.1),
            bgColor: const Color(0x1AFFFFFF),
            imageUrl: "assets/icons/profile.svg",
            isAsset: true,
          ),
        ],
      ),
    ],
  );
}

Widget deatilsCard(String title, String text) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      TextWidget(text: title),
      Row(
        children: [
          TextWidget(text: text),
          SizedBox(width: Responsive.w(1)),
          SvgPicture.asset("assets/icons/Arrow.svg"),
        ],
      ),
    ],
  );
}
















// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provide/model/insides_model.dart';
// import 'package:provide/model/librarymodel.dart';
// import 'package:provide/res/components/app_color.dart';
// import 'package:provide/utils/routes/responsive.dart';
// import 'package:provide/view/user/my_tracks_view.dart';
// import 'package:provide/view/user/playlist_view.dart';
// import 'package:provide/view/user/saved_artists_view.dart';
// import 'package:provide/viewmodel/insides_viewmodel.dart';
// import 'package:provide/viewmodel/libary_viewmodel.dart';
// import 'package:provide/widgets/custom_circle_avatar.dart';
// import 'package:provide/widgets/text_widget.dart';

// class InsidesView extends StatefulWidget {
//   const InsidesView({super.key});

//   @override
//   State<InsidesView> createState() => _InsidesViewState();
// }

// class _InsidesViewState extends State<InsidesView> {
//   final InsidesViewmodel _viewModel = InsidesViewmodel();
//   final ScrollController _scrollController = ScrollController();

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Responsive.init(context);

//     return Scaffold(
//       backgroundColor: AppColor.primaryColor,
//       body: SafeArea(
//         child: CustomScrollView(
//           controller: _scrollController,
//           slivers: [
//             // Using SliverAppBar for better scrolling behavior
//             SliverAppBar(
//               backgroundColor: AppColor.primaryColor,
//               pinned: true,
//               floating: true,
//               expandedHeight: Responsive.h(10),
//               flexibleSpace: FlexibleSpaceBar(
//                 background: Container(color: AppColor.primaryColor),
//               ),
//               title: _buildHeader(),
//             ),
//             SliverToBoxAdapter(
//               child: Padding(
//                 padding: Responsive.padding(left: 1, right: 1),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Library sections
//                     ..._buildLibrarySections(),

//                     // Divider with proper theming
//                     Divider(
//                       height: Responsive.h(3),
//                       color: Colors.white.withValues(alpha:  0.2),
//                     ),

//                     // Recently played section
//                     Padding(
//                       padding: EdgeInsets.only(bottom: Responsive.h(1)),
//                       child: Text(
//                         "Per Track Insides",
//                         style: GoogleFonts.onest(
//                           color: Colors.white,
//                           fontSize: Responsive.textScaleFactor * 16,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             // List of tracks with proper sliver implementation
//             SliverList(
//               delegate: SliverChildBuilderDelegate((context, index) {
//                 final insides = _viewModel.recentlyPlayed[index];
//                 return Padding(
//                   padding: EdgeInsets.symmetric(vertical: Responsive.h(0.5)),
//                   child: PlayCard(insides: insides),
//                 );
//               }, childCount: _viewModel.recentlyPlayed.length),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           'Insides',
//           style: GoogleFonts.onest(
//             color: Colors.white,
//             fontSize: Responsive.textScaleFactor * 20,
//             fontWeight: FontWeight.w600,
//             letterSpacing: -0.30,
//           ),
//         ),
//         Row(
//           children: [
//             // Added proper spacing between icons
//             CustomTinyCircleAvatar(
//               baseColor: AppColor.textColor.withOpacity(0.1),
//               iconPadding: const EdgeInsets.all(5),
//               imageUrl: "assets/icons/notification.svg",
//               isAsset: true,
//               bgColor: const Color(0x1AFFFFFF),
//             ),
//             SizedBox(width: Responsive.w(2)),
//             CustomTinyCircleAvatar(
//               baseColor: AppColor.textColor.withOpacity(0.1),
//               bgColor: const Color(0x1AFFFFFF),
//               imageUrl: "assets/icons/profile.svg",
//               isAsset: true,
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   List<Widget> _buildLibrarySections() {
//     return _viewModel.librarySections.map((section) {
//       return Padding(
//         padding: EdgeInsets.symmetric(vertical: Responsive.h(1)),
//         child: ClickText(
//           text: section,
//           onTap: () => _handleSectionTap(section),
//         ),
//       );
//     }).toList();
//   }

// void _handleSectionTap(String section) {
//   Widget destination;
  
//   switch (section) {
//     case "Total Streams":
//       destination = const PlaylistView();
//       break;
//     case "Total Likes":
//       destination = const MytracksView();
//       break;
//     case "Follower Growth":
//       destination = const SavedArtistsView();
//       break;
//     default:
//       // Fallback to a default screen or show error
//       return;
//   }
  
//   Navigator.push(
//     context, 
//     MaterialPageRoute(builder: (_) => destination)
//   );
  
//   debugPrint('Tapped on: $section');
// }
// }

// class PlayCard extends StatelessWidget {
//   final InsidesModel insides;

//   const PlayCard({super.key, required this.insides});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(18),
//         color: const Color(0x1AFFFFFF),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Row(
//           children: [
//             // Improved image widget with error handling
//             _buildTrackImage(),
//             SizedBox(width: Responsive.w(2)),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   TextWidget(
//                     text: insides.title,
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600,
//                   ),
//                   SizedBox(height: Responsive.h(0.5)),
//                   TextWidget(
//                     text: "By ${insides.artist}",
//                     fontSize: 8,
//                     fontWeight: FontWeight.w400,
//                   ),
//                   SizedBox(height: Responsive.h(0.5)),
//                   TextWidget(
//                     text: "Produced by: ${insides.producer}",
//                     fontSize: 10,
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ],
//               ),
//             ),
//             Column(
//               children: [
//                 TextWidget(text: _formatStreams(insides.streams), fontSize: 10),
//                 SizedBox(height: Responsive.h(0.5)),
//                 Text(
//                   _formatDuration(insides.duration),
//                   style: TextStyle(
//                     color: Colors.white.withOpacity(0.6),
//                     fontSize: 10,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTrackImage() {
//     return Container(
//       width: 50,
//       height: 50,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8),
//         color: Colors.grey[300],
//       ),
//       child: insides.imageAsset.endsWith('.svg')
//           ? SvgPicture.asset(insides.imageAsset)
//           : Image.asset(insides.imageAsset, fit: BoxFit.cover),
//     );
//   }

//   String _formatStreams(int streams) {
//     if (streams >= 1000000) {
//       return '${(streams / 1000000).toStringAsFixed(1)}M Streams';
//     } else if (streams >= 1000) {
//       return '${(streams / 1000).toStringAsFixed(1)}K Streams';
//     }
//     return '$streams Streams';
//   }

//   String _formatDuration(Duration duration) {
//     String twoDigits(int n) => n.toString().padLeft(2, "0");
//     final minutes = twoDigits(duration.inMinutes.remainder(60));
//     final seconds = twoDigits(duration.inSeconds.remainder(60));
//     return "$minutes:$seconds";
//   }
// }

// class ClickText extends StatelessWidget {
//   final String text;
//   final VoidCallback onTap;

//   const ClickText({super.key, required this.text, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     Responsive.init(context);

//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(8),
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               text,
//               style: GoogleFonts.onest(
//                 color: Colors.white,
//                 fontSize: Responsive.textScaleFactor * 14,
//                 fontWeight: FontWeight.bold,
//                 letterSpacing: -0.30,
//               ),
//             ),
//             SvgPicture.asset(
//               "assets/icons/Arrow.svg",
//               color: Colors.white.withOpacity(0.7),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }