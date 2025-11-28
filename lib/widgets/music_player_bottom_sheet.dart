import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provide/res/components/app_color.dart';
import 'package:provide/services/music_player_service.dart';
import 'package:provide/utils/routes/responsive.dart';
import 'package:provide/widgets/text_widget.dart';

class MusicPlayerBottomSheet extends StatelessWidget {
  const MusicPlayerBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MusicPlayerService>(
      builder: (context, playerService, child) {
        if (!playerService.hasTrack) {
          return const SizedBox.shrink();
        }

        final track = playerService.currentTrack!;

        return GestureDetector(
          onTap: () => _showFullPlayer(context),
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              color: AppColor.darkGray,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.3),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Column(
              children: [
                // Progress bar
                LinearProgressIndicator(
                  value: playerService.totalDuration.inSeconds > 0
                      ? playerService.currentPosition.inSeconds /
                          playerService.totalDuration.inSeconds
                      : 0.0,
                  backgroundColor: Colors.grey.shade800,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColor.seconadryColor),
                  minHeight: 2,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      children: [
                        // Album art
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            track.imageAsset,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                              width: 50,
                              height: 50,
                              color: Colors.grey.shade800,
                              child: const Icon(Icons.music_note, color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        
                        // Track info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                track.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                track.artist,
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.7),
                                  fontSize: 12,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        
                        // Play/Pause button
                        IconButton(
                          icon: Icon(
                            playerService.isPlaying ? Icons.pause : Icons.play_arrow,
                            color: Colors.white,
                            size: 32,
                          ),
                          onPressed: () {
                            if (playerService.isPlaying) {
                              playerService.pause();
                            } else {
                              playerService.resume();
                            }
                          },
                        ),
                        
                        // Close button
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.white, size: 24),
                          onPressed: () {
                            playerService.stop();
                            playerService.clearTrack();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showFullPlayer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const FullMusicPlayer(),
    );
  }
}

class FullMusicPlayer extends StatelessWidget {
  const FullMusicPlayer({super.key});

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    return Consumer<MusicPlayerService>(
      builder: (context, playerService, child) {
        if (!playerService.hasTrack) {
          return const SizedBox.shrink();
        }

        final track = playerService.currentTrack!;

        return Container(
          height: MediaQuery.of(context).size.height * 0.85,
          decoration: BoxDecoration(
            color: AppColor.primaryColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Drag handle
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade700,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              
              // Close button
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),

              const SizedBox(height: 20),

              // Album art
              Container(
                width: Responsive.w(70),
                height: Responsive.w(70),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.seconadryColor.withValues(alpha: 0.3),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    track.imageAsset,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.grey.shade800,
                      child: const Icon(Icons.music_note, color: Colors.white, size: 80),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // Track info
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    TextWidget(
                      text: track.title,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(height: 8),
                    TextWidget(
                      text: track.artist,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // Progress slider
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: AppColor.seconadryColor,
                        inactiveTrackColor: Colors.grey.shade800,
                        thumbColor: AppColor.seconadryColor,
                        overlayColor: AppColor.seconadryColor.withValues(alpha: 0.2),
                        trackHeight: 4,
                      ),
                      child: Slider(
                        value: playerService.currentPosition.inSeconds.toDouble(),
                        max: playerService.totalDuration.inSeconds.toDouble(),
                        onChanged: (value) {
                          playerService.seek(Duration(seconds: value.toInt()));
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _formatDuration(playerService.currentPosition),
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.7),
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            _formatDuration(playerService.totalDuration),
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.7),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // Playback controls
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Previous button
                  IconButton(
                    icon: const Icon(Icons.skip_previous, color: Colors.white, size: 40),
                    onPressed: () {},
                  ),
                  const SizedBox(width: 20),
                  
                  // Play/Pause button
                  Container(
                    decoration: BoxDecoration(
                      color: AppColor.seconadryColor,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(
                        playerService.isPlaying ? Icons.pause : Icons.play_arrow,
                        color: Colors.white,
                        size: 40,
                      ),
                      onPressed: () {
                        if (playerService.isPlaying) {
                          playerService.pause();
                        } else {
                          playerService.resume();
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  
                  // Next button
                  IconButton(
                    icon: const Icon(Icons.skip_next, color: Colors.white, size: 40),
                    onPressed: () {},
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Volume control
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  children: [
                    const Icon(Icons.volume_down, color: Colors.white),
                    Expanded(
                      child: SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: AppColor.seconadryColor,
                          inactiveTrackColor: Colors.grey.shade800,
                          thumbColor: AppColor.seconadryColor,
                          trackHeight: 2,
                        ),
                        child: Slider(
                          value: playerService.volume,
                          onChanged: (value) {
                            playerService.setVolume(value);
                          },
                        ),
                      ),
                    ),
                    const Icon(Icons.volume_up, color: Colors.white),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
