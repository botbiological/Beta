import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provide/model/librarymodel.dart';
import 'package:provide/res/components/app_color.dart';
import 'package:provide/utils/routes/responsive.dart';
import 'package:provide/utils/routes/routes_name.dart';
import 'package:provide/view/user/my_tracks_view.dart';
import 'package:provide/view/user/playlist_view.dart';
import 'package:provide/view/user/profile_view.dart';
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Library sections
                  ..._buildLibrarySections(),

                  // Divider with proper theming
                  Divider(
                    height: Responsive.h(3),
                    color: Colors.white.withValues(alpha: 0.2),
                  ),

                  // Recently played section
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: Responsive.h(1),

                      horizontal: Responsive.w(5),
                    ),

                    child: Text(
                      "Recently played",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: Responsive.textScaleFactor * 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // List of tracks with proper sliver implementation
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final track = _viewModel.recentlyPlayed[index];
                return Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: Responsive.h(0.5),

                    horizontal: Responsive.w(5),
                  ),
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
          style: TextStyle(
            color: Colors.white,
            fontSize: Responsive.textScaleFactor * 20,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.30,
          ),
        ),
        Row(
          children: [
            // Added proper spacing between icons
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, RoutesName.notification);
              },
              child: CustomTinyCircleAvatar(
                baseColor: AppColor.textColor.withValues(alpha: 0.1),
                iconPadding: EdgeInsets.all(20),

                imageUrl: "assets/icons/notification.svg",
                isAsset: true,
                bgColor: Color(0x1AFFFFFF),
              ),
            ),
            SizedBox(width: Responsive.w(2)),
            CustomTinyCircleAvatar(
              baseColor: AppColor.textColor.withValues(alpha: 0.1),
              bgColor: Color(0x1AFFFFFF),
              imageUrl: "assets/icons/profile.png",
              isAsset: false,

              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProfileView(), // 👈 destination screen
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  List<Widget> _buildLibrarySections() {
    return _viewModel.librarySections.map((section) {
      return Padding(
        padding: EdgeInsets.symmetric(
          vertical: Responsive.h(1),
          horizontal: Responsive.w(5),
        ),
        child: ClickText(
          text: section,
          onTap: () => _handleSectionTap(section),
        ),
      );
    }).toList();
  }

  void _handleSectionTap(String section) {
    debugPrint('Tapped on: $section');

    Widget destination;

    try {
      switch (section) {
        case "Playlist":
          debugPrint('Navigating to PlaylistView...');
          destination = const PlaylistView();
          break;
        case "My Tracks":
          debugPrint('Navigating to MytracksView...');
          destination = const MytracksView();
          break;
        case "Saved Artists":
          debugPrint('Navigating to SavedArtistsView...');
          destination = const SavedArtistsView();
          break;
        default:
          debugPrint('Unknown section: $section');
          return;
      }

      Navigator.push(context, MaterialPageRoute(builder: (_) => destination))
          .then((_) {
            debugPrint('Returned from $section view');
          })
          .catchError((error) {
            debugPrint('Navigation error: $error');
          });
    } catch (e) {
      debugPrint('Error in _handleSectionTap: $e');
    }
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(
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
    );
  }
}
