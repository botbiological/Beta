import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provide/model/mytrackmodel.dart';
import 'package:provide/res/components/app_color.dart';
import 'package:provide/utils/routes/responsive.dart';
import 'package:provide/view/user/profile_view.dart';
import 'package:provide/viewmodel/track_viewmodel.dart';
import 'package:provide/widgets/custom_circle_avatar.dart';
import 'package:provide/widgets/text_widget.dart';

class ArtistMytracksView extends StatefulWidget {
  const ArtistMytracksView({super.key});

  @override
  State<ArtistMytracksView> createState() => _ArtistMytracksViewState();
}

class _ArtistMytracksViewState extends State<ArtistMytracksView> {
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
            horizontal: Responsive.w(5),
            vertical: Responsive.h(4),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextWidget(
          text: "Competitions",
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        Row(
          // Using MainAxisAlignment instead of non-existent spacing property
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
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
      onTap: isUploading ? null : onUpload,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          color: AppColor.seconadryColor,
        ),
        child: Padding(
          padding: Responsive.padding(left: 2, top: 1, bottom: 1, right: 1),
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
                    color: AppColor.textColor.withValues(alpha: 0.7),
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
