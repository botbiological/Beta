import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provide/model/mytrackmodel.dart';
import 'package:provide/res/components/app_color.dart';
import 'package:provide/utils/routes/responsive.dart';
import 'package:provide/view/Artist/upload_view.dart';
import 'package:provide/view/user/profile_view.dart';
import 'package:provide/viewmodel/track_viewmodel.dart';
import 'package:provide/widgets/custom_circle_avatar.dart';
import 'package:provide/widgets/text_widget.dart';

class MytracksView extends StatefulWidget {
  const MytracksView({super.key});

  @override
  State<MytracksView> createState() => _MytracksViewState();
}

class _MytracksViewState extends State<MytracksView> {
  final MyTracksViewController _controller = MyTracksViewController();
  final ValueNotifier<bool> _isUploading = ValueNotifier(false);

  @override
  void dispose() {
    _isUploading.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);

    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: Responsive.h(4),

            horizontal: Responsive.w(5),
          ),
          child: Column(
            children: [
              // Extracted to a separate method for better readability
              _buildHeader(),
              SizedBox(height: Responsive.h(2)),
              // ValueListenableBuilder for reactive UI updates
              ValueListenableBuilder<bool>(
                valueListenable: _isUploading,
                builder: (context, isUploading, child) {
                  return UploadButton(
                    isUploading: isUploading,
                    onUpload: _handleUpload,
                  );
                },
              ),
              SizedBox(height: Responsive.h(2)),
              // Expanded with ListView for scalability
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: Responsive.w(5)),
                  itemCount: _controller.mytracks.length,
                  separatorBuilder: (context, index) =>
                      SizedBox(height: Responsive.h(1.5)),
                  itemBuilder: (context, index) {
                    final track = _controller.mytracks[index];
                    return PlayListCard(
                      track: track,
                      onOptionsTap: () => _showTrackOptions(track, context),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Responsive.w(5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextWidget(
            text: "My Tracks",
            fontSize: 20,
            fontWeight: FontWeight.w600,
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
      ),
    );
  }

  void _handleUpload() async {
    _isUploading.value = true;
    // Simulate upload process
    await Future.delayed(const Duration(seconds: 2));
    _isUploading.value = false;
    // Show success/error message
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Upload completed')));
  }

  void _showTrackOptions(MyTrack track, BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.play_arrow),
                title: const Text('Play'),
                onTap: () {
                  Navigator.pop(context);
                  // Implement play functionality
                },
              ),
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Edit'),
                onTap: () {
                  Navigator.pop(context);
                  // Implement edit functionality
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('Delete'),
                onTap: () {
                  Navigator.pop(context);
                  // Implement delete functionality
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class UploadButton extends StatelessWidget {
  final bool isUploading;
  final VoidCallback onUpload;

  const UploadButton({
    super.key,
    required this.isUploading,
    required this.onUpload,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UploadView()),
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Responsive.w(5)),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            color: AppColor.seconadryColor,
          ),
          child: Padding(
            padding: Responsive.padding(left: 2, top: 2, bottom: 2, right: 1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isUploading)
                  const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    ),
                  )
                else
                  SvgPicture.asset("assets/icons/add.svg"),
                SizedBox(width: Responsive.w(2)),
                TextWidget(text: isUploading ? "Uploading..." : "Upload"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PlayListCard extends StatelessWidget {
  final MyTrack track;
  final VoidCallback onOptionsTap;

  const PlayListCard({
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
            // Using a proper image widget with error handling
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

//Code Version 1.0.0

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:provide/res/components/app_color.dart';
// import 'package:provide/utils/routes/responsive.dart';
// import 'package:provide/widgets/custom_circle_avatar.dart';
// import 'package:provide/widgets/text_widget.dart';

// class MytracksView extends StatelessWidget {
//   const MytracksView({super.key});
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
//                     text: "My Tracks",
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
//               UploadButton(),
//               SizedBox(height: Responsive.h(2)),
//               PlayListCard(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class UploadButton extends StatelessWidget {
//   const UploadButton({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(28),
//         color: AppColor.seconadryColor,
//       ),
//       child: Padding(
//         padding: Responsive.padding(left: 1, right: 1, bottom: 2, top: 2),

//         child: Row(
//           spacing: Responsive.w(2),
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SvgPicture.asset("assets/icons/add.svg"),
//             TextWidget(text: "Upload"),
//           ],
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
