import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provide/model/playlistmodel.dart';
import 'package:provide/res/components/app_color.dart';
import 'package:provide/utils/routes/responsive.dart';
import 'package:provide/viewmodel/playlist_viewmodel.dart';
import 'package:provide/widgets/custom_circle_avatar.dart';
import 'package:provide/widgets/text_widget.dart';

class PlaylistView extends StatelessWidget {
  const PlaylistView({super.key});

  @override
  Widget build(BuildContext context) {
    try {
      Responsive.init(context);
      final PlaylistViewModel viewModel = PlaylistViewModel();

      debugPrint(
        'PlaylistView: Building with ${viewModel.tracks.length} tracks',
      );

      return Scaffold(
        backgroundColor: AppColor.primaryColor,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: Responsive.h(1),

              horizontal: Responsive.w(5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header section
                _buildHeader(),
                SizedBox(height: Responsive.h(2)),

                // Playlist info section (would be dynamic in a real app)
                _buildPlaylistInfo(),
                SizedBox(height: Responsive.h(3)),

                // Tracks list with expandable space
                Expanded(
                  child: ListView.separated(
                    itemCount: viewModel.tracks.length,
                    separatorBuilder: (context, index) =>
                        SizedBox(height: Responsive.h(1.5)),
                    itemBuilder: (context, index) {
                      final track = viewModel.tracks[index];
                      return PlaylistTrackCard(
                        track: track,
                        onOptionsTap: () => _showTrackOptions(context, track),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } catch (e) {
      debugPrint('PlaylistView build error: $e');
      return Scaffold(
        backgroundColor: AppColor.primaryColor,
        body: Center(
          child: Text(
            'Error loading playlist: $e',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );
    }
  }

  Widget _buildHeader() {
    return Builder(
      builder: (context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
              SizedBox(width: Responsive.w(2)),
              TextWidget(
                text: "Playlist",
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
          Row(
            // Using proper spacing instead of non-existent 'spacing' property
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
      ),
    );
  }

  Widget _buildPlaylistInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Playlist cover image
        Center(
          child: Container(
            width: Responsive.w(40),
            height: Responsive.w(40),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: const Color(0x1AFFFFFF),
              image: const DecorationImage(
                image: AssetImage("assets/images/vinyl.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SizedBox(height: Responsive.h(2)),

        // Playlist title and info
        Center(
          child: TextWidget(
            text: "Chill Vibes",
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: Responsive.h(0.5)),

        Center(
          child: TextWidget(
            text: "25 tracks • 1h 45m",
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: AppColor.textColor.withOpacity(0.7),
          ),
        ),
        SizedBox(height: Responsive.h(2)),

        // Playlist actions
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildActionButton(
              icon: Icons.play_arrow_rounded,
              label: "Play",
              onTap: () => _playPlaylist(),
            ),
            SizedBox(width: Responsive.w(4)),
            _buildActionButton(
              icon: Icons.shuffle_rounded,
              label: "Shuffle",
              onTap: () => _shufflePlaylist(),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.w(4),
          vertical: Responsive.h(1),
        ),
        decoration: BoxDecoration(
          color: AppColor.seconadryColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(icon, size: 20, color: Colors.white),
            SizedBox(width: Responsive.w(1.5)),
            TextWidget(text: label, fontSize: 12, fontWeight: FontWeight.w500),
          ],
        ),
      ),
    );
  }

  void _playPlaylist() {
    // Implement playlist play functionality
    debugPrint('Playing playlist');
  }

  void _shufflePlaylist() {
    // Implement shuffle functionality
    debugPrint('Shuffling playlist');
  }

  void _showTrackOptions(BuildContext context, PlaylistTrack track) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColor.primaryColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(Responsive.w(4)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.play_arrow, color: Colors.white),
                title: const Text(
                  'Play',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _playTrack(track);
                },
              ),
              ListTile(
                leading: const Icon(Icons.add, color: Colors.white),
                title: const Text(
                  'Add to queue',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _addToQueue(track);
                },
              ),
              ListTile(
                leading: const Icon(Icons.playlist_add, color: Colors.white),
                title: const Text(
                  'Add to playlist',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _addToOtherPlaylist(track);
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.white),
                title: const Text(
                  'Remove from playlist',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _removeFromPlaylist(track);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _playTrack(PlaylistTrack track) {
    // Implement track play functionality
    debugPrint('Playing track: ${track.title}');
  }

  void _addToQueue(PlaylistTrack track) {
    // Implement add to queue functionality
    debugPrint('Adding to queue: ${track.title}');
  }

  void _addToOtherPlaylist(PlaylistTrack track) {
    // Implement add to other playlist functionality
    debugPrint('Adding to other playlist: ${track.title}');
  }

  void _removeFromPlaylist(PlaylistTrack track) {
    // Implement remove from playlist functionality
    debugPrint('Removing from playlist: ${track.title}');
  }
}

class PlaylistTrackCard extends StatelessWidget {
  final PlaylistTrack track;
  final VoidCallback onOptionsTap;

  const PlaylistTrackCard({
    super.key,
    required this.track,
    required this.onOptionsTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: const Color(0x1AFFFFFF),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            // Track image with error handling
            _buildTrackImage(),
            SizedBox(width: Responsive.w(2)),
            // Track info
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
                  SizedBox(height: Responsive.h(0.5)),
                  TextWidget(
                    text: _formatDuration(track.duration),
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: AppColor.textColor.withOpacity(0.7),
                  ),
                ],
              ),
            ),
            // Options button
            GestureDetector(
              onTap: onOptionsTap,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset("assets/icons/three_dot.svg"),
              ),
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

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:provide/res/components/app_color.dart';
// import 'package:provide/utils/routes/responsive.dart';
// import 'package:provide/widgets/custom_circle_avatar.dart';
// import 'package:provide/widgets/text_widget.dart';

// class PlaylistView extends StatelessWidget {
//   const PlaylistView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     Responsive.init(context);
//     return Scaffold(
//       backgroundColor: AppColor.primaryColor,
//       body: SafeArea(
//         child: Padding(
//           padding: Responsive.padding(left: 1, right: 1, bottom: 1, top: 1),
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   TextWidget(
//                     text: "Playlist",
//                     fontSize: 20,
//                     fontWeight: FontWeight.w600,
//                   ),

//                   Row(
//                     spacing: 5,
//                     children: [
//                       CustomTinyCircleAvatar(
//                         baseColor: AppColor.textColor.withValues(alpha: 0.1),
//                         iconPadding: EdgeInsets.all(5),
//                         imageUrl: "assets/icons/notification.svg",
//                         isAsset: true,
//                         bgColor: Color(0x1AFFFFFF),
//                       ),
//                       CustomTinyCircleAvatar(
//                         baseColor: AppColor.textColor.withValues(alpha: 0.1),
//                         bgColor: Color(0x1AFFFFFF),
//                         imageUrl: "assets/icons/profile.svg",
//                         isAsset: true,
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               SizedBox(height: Responsive.h(2)),
//               PlayListCard(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class PlayListCard extends StatelessWidget {
//   const PlayListCard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(18),
//         color: Color(0x1AFFFFFF),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(10.0),
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
//             Column(children: [SvgPicture.asset("assets/icons/three_dot.svg")]),
//           ],
//         ),
//       ),
//     );
//   }
// }
