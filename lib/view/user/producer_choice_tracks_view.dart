import 'package:flutter/material.dart';
import 'package:provide/res/components/app_color.dart';
import 'package:provide/utils/routes/responsive.dart';
import 'package:provide/widgets/custom_music_card.dart';
import 'package:provide/model/mytrackmodel.dart';

class ProducerChoiceTracksView extends StatefulWidget {
  const ProducerChoiceTracksView({super.key});

  @override
  State<ProducerChoiceTracksView> createState() => _ProducerChoiceTracksViewState();
}

class _ProducerChoiceTracksViewState extends State<ProducerChoiceTracksView> {
  late final List<MyTrack> producerChoiceTracks;

  @override
  void initState() {
    super.initState();
    
    // Create 4 tracks selected by producers
    final now = DateTime.now();
    producerChoiceTracks = [
      MyTrack(
        id: 'producer_choice_1',
        userId: 'producer_1',
        title: 'Havana',
        artist: 'Cooper Gouse',
        producer: 'Cooper Gouse',
        imageAsset: 'assets/images/havana.png',
        duration: const Duration(minutes: 3, seconds: 45),
        playCount: 52400,
        createdAt: now.subtract(const Duration(days: 2)),
        updatedAt: now,
      ),
      MyTrack(
        id: 'producer_choice_2',
        userId: 'producer_2',
        title: 'Nelda',
        artist: 'Cooper Gouse',
        producer: 'Cooper Gouse',
        imageAsset: 'assets/images/nelda.png',
        duration: const Duration(minutes: 4, seconds: 12),
        playCount: 48200,
        createdAt: now.subtract(const Duration(days: 4)),
        updatedAt: now,
      ),
      MyTrack(
        id: 'producer_choice_3',
        userId: 'producer_3',
        title: 'No Sleep',
        artist: 'Cooper Gouse',
        producer: 'Cooper Gouse',
        imageAsset: 'assets/images/no_sleep.png',
        duration: const Duration(minutes: 3, seconds: 28),
        playCount: 45800,
        createdAt: now.subtract(const Duration(days: 6)),
        updatedAt: now,
      ),
      MyTrack(
        id: 'producer_choice_4',
        userId: 'producer_4',
        title: 'Midnight Vibes',
        artist: 'Cooper Gouse',
        producer: 'Cooper Gouse',
        imageAsset: 'assets/images/havana.png', // Using existing asset
        duration: const Duration(minutes: 4, seconds: 35),
        playCount: 42100,
        createdAt: now.subtract(const Duration(days: 8)),
        updatedAt: now,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Producer Choice',
          style: TextStyle(
            color: AppColor.whiteColor,
            fontSize: Responsive.textScaleFactor * 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.w(5),
            vertical: Responsive.h(2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Handpicked by Top Producers',
                style: TextStyle(
                  color: AppColor.textColor.withValues(alpha: 0.7),
                  fontSize: Responsive.textScaleFactor * 14,
                ),
              ),
              SizedBox(height: Responsive.h(3)),
              
              // Grid of 4 tracks
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.65,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    final track = producerChoiceTracks[index];
                    return CustomMusicCard(
                      imageUrl: track.imageAsset,
                      title: track.title,
                      artist: track.artist,
                      streams: "${(track.playCount / 1000).toStringAsFixed(1)}K Streams",
                      badgeText: index == 0 ? "Editor's Pick" : null,
                      track: track,
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
}
