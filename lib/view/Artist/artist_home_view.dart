import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:provide/res/components/app_color.dart';
import 'package:provide/utils/routes/responsive.dart';
import 'package:provide/view/Artist/artitist_profile_view.dart';
import 'package:provide/view/user/profile_view.dart';
import 'package:provide/widgets/custom_circle_avatar.dart';
import 'package:provide/widgets/custom_music_card.dart';
import 'package:provide/widgets/music_player_bottom_sheet.dart';
import 'package:provide/widgets/text_widget.dart';
import 'package:provide/widgets/textfeild_with_buttom.dart';
import 'package:provide/model/mytrackmodel.dart';
import 'package:provide/services/music_player_service.dart';

class ArtistHomeView extends StatelessWidget {
  const ArtistHomeView({super.key});

  // Sample tracks for demonstration
  List<MyTrack> get _sampleTracks => [
    MyTrack(
      id: '1',
      userId: 'demo',
      title: 'Havana',
      artist: 'Cooper Gouse',
      producer: 'DJ Beats',
      imageAsset: 'assets/images/havana.png',
      duration: const Duration(minutes: 3, seconds: 45),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
      playCount: 32400,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    MyTrack(
      id: '2',
      userId: 'demo',
      title: 'Nelda',
      artist: 'Cooper Gouse',
      producer: 'Beat Master',
      imageAsset: 'assets/images/nelda.png',
      duration: const Duration(minutes: 4, seconds: 12),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3',
      playCount: 28900,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    MyTrack(
      id: '3',
      userId: 'demo',
      title: 'No Sleep',
      artist: 'Cooper Gouse',
      producer: 'Night Owl',
      imageAsset: 'assets/images/no_sleep.png',
      duration: const Duration(minutes: 3, seconds: 58),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3',
      playCount: 41200,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    return ChangeNotifierProvider(
      create: (_) => MusicPlayerService(),
      child: Scaffold(
        backgroundColor: AppColor.primaryColor,
        body: SafeArea(
          child: Stack(
            children: [
              ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Responsive.w(5),
                      vertical: Responsive.h(4),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeader(context),
                        SizedBox(height: Responsive.h(2)),
                        TextfeildWithButtom(),
                        SizedBox(height: Responsive.h(2)),
                        Row(
                          children: [
                            _customCard("Total Streams", "12.k"),
                            SizedBox(width: Responsive.w(2)),
                            _customCard("Likes This Week", "4"),
                            SizedBox(width: Responsive.w(2)),
                            _customCard("New Followers", "18"),
                          ],
                        ),
                        SizedBox(height: Responsive.h(2)),
                        _RowCard('Rank in Battles', '#2'),
                        SizedBox(height: Responsive.h(3)),
                        Text(
                          'Your Top Track This Week',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: Responsive.textScaleFactor * 18,
                          ),
                        ),
                        SizedBox(height: Responsive.h(2)),

                        // Carousel for top tracks
                        CarouselSlider.builder(
                          itemCount: _sampleTracks.length,
                          options: CarouselOptions(
                            height: Responsive.h(34),
                            viewportFraction: 0.5,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 5),
                            autoPlayAnimationDuration: const Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                            enlargeFactor: 0.15,
                            scrollDirection: Axis.horizontal,
                            padEnds: true,
                          ),
                          itemBuilder: (context, index, realIndex) {
                            final track = _sampleTracks[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4),
                              child: CustomMusicCard(
                                imageUrl: track.imageAsset,
                                title: track.title,
                                artist: track.artist,
                                streams: '${(track.playCount / 1000).toStringAsFixed(1)}K Streams this week',
                                badgeText: index == 0 ? "3K Likes" : null,
                                track: track,
                              ),
                            );
                          },
                        ),

                        SizedBox(height: Responsive.h(3)),
                        TextWidget(text: "Streaming Graph"),
                        Container(
                          width: double.infinity,
                          height: Responsive.h(25),
                          decoration: BoxDecoration(
                            color: AppColor.darkGray,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.bar_chart,
                              size: 60,
                              color: AppColor.textColor.withValues(alpha: 0.3),
                            ),
                          ),
                        ),
                        SizedBox(height: Responsive.h(2)),
                        Container(
                          width: double.infinity,
                          height: Responsive.h(15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: AppColor.darkGray,
                          ),
                          child: Center(
                            child: TextWidget(
                              text: "Advertising Area",
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: Responsive.h(10)), // Space for bottom player
                      ],
                    ),
                  ),
                ],
              ),

              // Music Player Bottom Sheet
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: const MusicPlayerBottomSheet(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildHeader(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Image.asset('assets/icons/imic_icon.png'),
      Row(
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
            imageUrl: "assets/icons/profile.png",
            isAsset: false,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProfileView(),
                ),
              );
            },
          ),
        ],
      ),
    ],
  );
}

Widget _customCard(String text, String value) {
  return Expanded(
    child: Container(
      decoration: BoxDecoration(
        color: AppColor.darkGray,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: Responsive.h(1),
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(text: text, fontSize: 12),
            TextWidget(text: value),
          ],
        ),
      ),
    ),
  );
}

Widget _RowCard(String firstText, String secondText) {
  return Container(
    decoration: BoxDecoration(
      color: AppColor.darkGray,
      borderRadius: BorderRadius.circular(18),
    ),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        spacing: Responsive.h(1),
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextWidget(text: firstText, fontSize: 12),
          TextWidget(text: secondText, fontSize: 20),
        ],
      ),
    ),
  );
}
