import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provide/model/mytrackmodel.dart';
import 'package:provide/services/music_player_service.dart';
import 'package:provide/utils/routes/responsive.dart';

class CustomMusicCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String artist;
  final String streams;
  final String? badgeText;
  final MyTrack? track;
  final VoidCallback? onTap;

  const CustomMusicCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.artist,
    required this.streams,
    this.badgeText,
    this.track,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    return Consumer<MusicPlayerService>(
      builder: (context, playerService, child) {
        final isCurrentTrack = track != null && playerService.currentTrack?.id == track!.id;
        final isPlaying = isCurrentTrack && playerService.isPlaying;

        return GestureDetector(
          onTap: () {
            if (onTap != null) {
              onTap!();
            } else if (track != null) {
              playerService.playTrack(track!);
            }
          },
          child: Padding(
            padding: Responsive.padding(left: 1, right: 1, bottom: 1, top: 1),
            child: Container(
              padding: Responsive.padding(left: 1, right: 1, bottom: 1, top: 1),
              width: Responsive.w(40),
              margin: EdgeInsets.symmetric(
                horizontal: Responsive.w(0),
                vertical: Responsive.h(0),
              ),
              decoration: BoxDecoration(
                color: isCurrentTrack 
                    ? Colors.grey.shade800 
                    : Colors.grey.shade900,
                borderRadius: BorderRadius.circular(16),
                border: isCurrentTrack 
                    ? Border.all(color: Colors.red.shade700, width: 2)
                    : null,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// --- Album Cover with Play Button ---
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          imageUrl,
                          height: Responsive.h(17),
                          width: double.infinity,
                          fit: BoxFit.fill,
                          errorBuilder: (context, error, stackTrace) => Container(
                            height: Responsive.h(17),
                            color: Colors.grey.shade800,
                            child: const Icon(Icons.music_note, color: Colors.white, size: 40),
                          ),
                        ),
                      ),

                      /// Play/Pause Button
                      Positioned(
                        bottom: 8,
                        left: 8,
                        child: GestureDetector(
                          onTap: () {
                            if (track != null) {
                              if (isPlaying) {
                                playerService.pause();
                              } else {
                                playerService.playTrack(track!);
                              }
                            }
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(6),
                            child: Icon(
                              isPlaying ? Icons.pause : Icons.play_arrow,
                              color: Colors.black,
                              size: 20,
                            ),
                          ),
                        ),
                      ),

                      /// Badge (Top-right corner)
                      if (badgeText != null)
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              badgeText!,
                              style: TextStyle(
                                fontSize: Responsive.textScaleFactor * 10,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),

                      /// Playing indicator
                      if (isPlaying)
                        Positioned(
                          top: 8,
                          left: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.red.shade700,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.equalizer,
                                  color: Colors.white,
                                  size: 12,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Playing',
                                  style: TextStyle(
                                    fontSize: Responsive.textScaleFactor * 10,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),

                  SizedBox(height: Responsive.h(1.5)),

                  /// --- Title ---
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: Responsive.textScaleFactor * 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  /// --- Artist ---
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    child: Text(
                      "By $artist",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontSize: Responsive.textScaleFactor * 12,
                      ),
                    ),
                  ),

                  /// --- Streams Info ---
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    child: Text(
                      streams,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.6),
                        fontSize: Responsive.textScaleFactor * 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
