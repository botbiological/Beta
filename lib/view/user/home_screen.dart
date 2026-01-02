import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provide/res/components/app_color.dart';
import 'package:provide/res/components/auth_button.dart';
import 'package:provide/utils/routes/responsive.dart';
import 'package:provide/utils/routes/routes_name.dart';
import 'package:provide/view/user/artist_profile_public_view.dart';
import 'package:provide/view/user/profile_view.dart';
import 'package:provide/view/user/producer_choice_tracks_view.dart';
import 'package:provide/widgets/custom_music_card.dart';
import 'package:provide/widgets/custom_searchfield.dart';
import 'package:provide/widgets/custom_circle_avatar.dart';
import 'package:provide/widgets/text_widget.dart';
import 'package:provide/model/mytrackmodel.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeView>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  List artistCharts = ['cooper.png', 'tiana.png', 'leo.png'];
  
  // Separate track lists for each section
  late final List<MyTrack> topStreamTracks;
  late final List<MyTrack> topSongsTracks;
  late final List<MyTrack> chartsTracks;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    
    // Initialize tracks with UNIQUE IDs for each section
    final now = DateTime.now();
    
    // Top Stream tracks
    topStreamTracks = [
      MyTrack(
        id: 'stream_1',
        userId: 'user_1',
        title: 'Havana',
        artist: 'Cooper Gouse',
        producer: 'Cooper Gouse',
        imageAsset: 'assets/images/havana.png',
        duration: const Duration(minutes: 3, seconds: 45),
        playCount: 32400,
        createdAt: now.subtract(const Duration(days: 7)),
        updatedAt: now,
      ),
      MyTrack(
        id: 'stream_2',
        userId: 'user_2',
        title: 'Nelda',
        artist: 'Cooper Gouse',
        producer: 'Cooper Gouse',
        imageAsset: 'assets/images/nelda.png',
        duration: const Duration(minutes: 4, seconds: 12),
        playCount: 28500,
        createdAt: now.subtract(const Duration(days: 5)),
        updatedAt: now,
      ),
      MyTrack(
        id: 'stream_3',
        userId: 'user_3',
        title: 'No Sleep',
        artist: 'Cooper Gouse',
        producer: 'Cooper Gouse',
        imageAsset: 'assets/images/no_sleep.png',
        duration: const Duration(minutes: 3, seconds: 28),
        playCount: 25600,
        createdAt: now.subtract(const Duration(days: 3)),
        updatedAt: now,
      ),
    ];
    
    // Top Songs tracks
    topSongsTracks = [
      MyTrack(
        id: 'song_1',
        userId: 'user_4',
        title: 'Havana',
        artist: 'Cooper Gouse',
        producer: 'Cooper Gouse',
        imageAsset: 'assets/images/havana.png',
        duration: const Duration(minutes: 3, seconds: 45),
        playCount: 45200,
        createdAt: now.subtract(const Duration(days: 10)),
        updatedAt: now,
      ),
      MyTrack(
        id: 'song_2',
        userId: 'user_5',
        title: 'Nelda',
        artist: 'Cooper Gouse',
        producer: 'Cooper Gouse',
        imageAsset: 'assets/images/nelda.png',
        duration: const Duration(minutes: 4, seconds: 12),
        playCount: 38900,
        createdAt: now.subtract(const Duration(days: 8)),
        updatedAt: now,
      ),
      MyTrack(
        id: 'song_3',
        userId: 'user_6',
        title: 'No Sleep',
        artist: 'Cooper Gouse',
        producer: 'Cooper Gouse',
        imageAsset: 'assets/images/no_sleep.png',
        duration: const Duration(minutes: 3, seconds: 28),
        playCount: 35100,
        createdAt: now.subtract(const Duration(days: 6)),
        updatedAt: now,
      ),
    ];
    
    // Charts tracks
    chartsTracks = [
      MyTrack(
        id: 'chart_1',
        userId: 'user_7',
        title: 'Havana',
        artist: 'Cooper Gouse',
        producer: 'Cooper Gouse',
        imageAsset: 'assets/images/havana.png',
        duration: const Duration(minutes: 3, seconds: 45),
        playCount: 52300,
        createdAt: now.subtract(const Duration(days: 15)),
        updatedAt: now,
      ),
      MyTrack(
        id: 'chart_2',
        userId: 'user_8',
        title: 'Nelda',
        artist: 'Cooper Gouse',
        producer: 'Cooper Gouse',
        imageAsset: 'assets/images/nelda.png',
        duration: const Duration(minutes: 4, seconds: 12),
        playCount: 48700,
        createdAt: now.subtract(const Duration(days: 12)),
        updatedAt: now,
      ),
      MyTrack(
        id: 'chart_3',
        userId: 'user_9',
        title: 'No Sleep',
        artist: 'Cooper Gouse',
        producer: 'Cooper Gouse',
        imageAsset: 'assets/images/no_sleep.png',
        duration: const Duration(minutes: 3, seconds: 28),
        playCount: 44200,
        createdAt: now.subtract(const Duration(days: 9)),
        updatedAt: now,
      ),
    ];
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.w(5),
              vertical: Responsive.h(4),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset('assets/icons/imic_icon.png'),
                    Spacer(),

                    // Asset image
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
                            builder: (_) =>
                                ProfileView(), // 👈 destination screen
                          ),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: Responsive.h(3)),

                Row(
                  children: [
                    Expanded(
                      child: CustomSearchField(controller: _searchController),
                    ),
                    SizedBox(width: Responsive.w(2)),
                    CustomTinyCircleAvatar(
                      iconPadding: EdgeInsets.all(0),
                      bgColor: Color(0xffB82816),
                      isAsset: true,
                      baseColor: AppColor.seconadryColor,
                      imageUrl: 'assets/icons/menu.svg',
                    ),
                  ],
                ),
                SizedBox(height: Responsive.h(3)),
                SizedBox(
                  height: 200,
                  child: Stack(
                    children: <Widget>[
                      // The background image
                      Positioned.fill(
                        child: Image.asset(
                          'assets/images/cover_page.png',
                          fit: BoxFit.cover,
                        ),
                      ),

                      // The first circle (left side)
                      Positioned(
                        left: 0,
                        top: 25,
                        child: ClipOval(
                          child: Container(
                            width: 150,
                            height: 150,
                            color: Colors.blue.withValues(alpha: 0.5),
                            child: Image.asset(
                              'assets/images/first_player.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),

                      // The second circle (right side)
                      Positioned(
                        right: 0,
                        top: 30,
                        child: ClipOval(
                          child: Container(
                            width: 140,
                            height: 140,
                            color: Colors.blue.withValues(alpha: 0.5),
                            child: Image.asset(
                              'assets/images/second_player.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Product Choice Buttons
                SizedBox(height: Responsive.h(3)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: Responsive.w(2)),
                        child: AuthButton(
                          buttonText: 'Producer Choice',
                          loading: false,
                          onPress: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const ProducerChoiceTracksView(),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: Responsive.w(2)),
                        child: AuthButton(
                          buttonText: 'Producer Choice',
                          loading: false,
                          onPress: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const ProducerChoiceTracksView(),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Responsive.h(3)),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Responsive.w(4),
                    vertical: Responsive.h(1),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(18),
                  ),

                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "12",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: Responsive.textScaleFactor * 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "DAYS",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: Responsive.textScaleFactor * 10,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(), // 👈 pushes next column away
                      Text(
                        ":",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Responsive.textScaleFactor * 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "50",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: Responsive.textScaleFactor * 25,
                            ),
                          ),
                          Text(
                            "MIN",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: Responsive.textScaleFactor * 10,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Text(
                        ":",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Responsive.textScaleFactor * 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,

                        children: [
                          Text(
                            "12",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: Responsive.textScaleFactor * 25,
                            ),
                          ),
                          Text(
                            "SEC",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: Responsive.textScaleFactor * 10,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Responsive.h(3)),
                Text(
                  'Top 10 Artists on Charts',

                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColor.whiteColor,

                    fontSize: Responsive.textScaleFactor * 18,
                  ),
                ),
                SizedBox(height: Responsive.h(3)),

                Container(
                  constraints: BoxConstraints(
                    minHeight: Responsive.h(20),
                    maxHeight: Responsive.h(21),
                  ),
                  // Adjust height for card
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal, // 🔹 horizontal scroll
                    itemCount: artistCharts.length, // number of artists
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          debugPrint('Top artist card tapped: index $index');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ArtistProfilePublicView(),
                            ),
                          );
                        },
                        child: Container(
                          width: Responsive.w(36), // fixed width for card
                          margin: const EdgeInsets.only(
                            right: 12,
                          ), // spacing between items
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.10),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: Responsive.sp(20),
                                    backgroundColor: const Color(0xFFFFFF), // optional bg color
                                    child: Image.asset(
                                      'assets/images/${artistCharts[index]}',
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                    ),
                                  ),

                                  // Rank
                                  Text(
                                    "#${index + 1}",
                                    style: TextStyle(
                                      color: AppColor.textColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: Responsive.textScaleFactor * 12,
                                    ),
                                  ),
                                ],
                              ),
                              // Name
                              const SizedBox(height: 6),
                              Text(
                                "Artist ${index + 1}", // replace with data
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Responsive.textScaleFactor * 14,
                                ),
                              ),

                              const SizedBox(height: 4),

                              // Category
                              Text(
                                "Hip-Hop",
                                style: TextStyle(
                                  color: AppColor.textColor,
                                  fontSize: Responsive.textScaleFactor * 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: Responsive.h(5)),
                Stack(
                  clipBehavior: Clip.none, // allows the image to overflow above
                  children: [
                    // 🔴 Red container
                    Container(
                      constraints: BoxConstraints(
                        maxHeight: Responsive.h(25),
                        minHeight: Responsive.h(23),
                      ),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xffB82816),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Submit Your Tracks\nto the Charts',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: Responsive.textScaleFactor * 18,
                              fontWeight: FontWeight.bold,
                              height: 1.3,
                            ),
                          ),
                          SizedBox(height: Responsive.h(1)),

                          Text(
                            'Upload your best song and join the official\ncharts. Top artists get love and views!',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.8),
                              fontSize: Responsive.textScaleFactor * 12,
                            ),
                          ),
                          SizedBox(height: Responsive.h(1.5)),
                          SizedBox(
                            height: 31,
                            width: 105,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: AppColor.seconadryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Text(
                                'Submit Now',
                                style: TextStyle(fontSize: 10),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // 🎵 Image placed above
                    Positioned(
                      top: -50, // how much the image should "float" above
                      right: 3, // adjust horizontally (left, right, or center)
                      child: SizedBox(
                        width: 140,
                        height: 150,
                        child: Image.asset(
                          'assets/images/vinyl.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Responsive.h(3)),
                
                // TabBar for swipeable sections
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    indicatorColor: Color(0xffB82816),
                    indicatorWeight: 3,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.white.withValues(alpha: 0.5),
                    labelStyle: TextStyle(
                      fontSize: Responsive.textScaleFactor * 16,
                      fontWeight: FontWeight.bold,
                    ),
                    unselectedLabelStyle: TextStyle(
                      fontSize: Responsive.textScaleFactor * 14,
                      fontWeight: FontWeight.normal,
                    ),
                    tabs: const [
                      Tab(text: 'Top Stream'),
                      Tab(text: 'Top Songs'),
                      Tab(text: 'Charts'),
                    ],
                  ),
                ),
                SizedBox(height: Responsive.h(2)),
                
                // TabBarView for swipeable content
                Container(
                  constraints: BoxConstraints(
                    minHeight: Responsive.h(32),
                    maxHeight: Responsive.h(34),
                  ),
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      // Top Stream Tab
                      ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          CustomMusicCard(
                            imageUrl: topStreamTracks[0].imageAsset,
                            title: topStreamTracks[0].title,
                            artist: topStreamTracks[0].artist,
                            streams: "${(topStreamTracks[0].playCount / 1000).toStringAsFixed(1)}K Streams this week",
                            badgeText: "3K Likes",
                            track: topStreamTracks[0],
                          ),
                          CustomMusicCard(
                            imageUrl: topStreamTracks[1].imageAsset,
                            title: topStreamTracks[1].title,
                            artist: topStreamTracks[1].artist,
                            streams: "${(topStreamTracks[1].playCount / 1000).toStringAsFixed(1)}K Streams this week",
                            track: topStreamTracks[1],
                          ),
                          CustomMusicCard(
                            imageUrl: topStreamTracks[2].imageAsset,
                            title: topStreamTracks[2].title,
                            artist: topStreamTracks[2].artist,
                            streams: "${(topStreamTracks[2].playCount / 1000).toStringAsFixed(1)}K Streams this week",
                            track: topStreamTracks[2],
                          ),
                        ],
                      ),
                      
                      // Top Songs Tab
                      ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          CustomMusicCard(
                            imageUrl: topSongsTracks[0].imageAsset,
                            title: topSongsTracks[0].title,
                            artist: topSongsTracks[0].artist,
                            streams: "${(topSongsTracks[0].playCount / 1000).toStringAsFixed(1)}K Streams this week",
                            badgeText: "5K Likes",
                            track: topSongsTracks[0],
                          ),
                          CustomMusicCard(
                            imageUrl: topSongsTracks[1].imageAsset,
                            title: topSongsTracks[1].title,
                            artist: topSongsTracks[1].artist,
                            streams: "${(topSongsTracks[1].playCount / 1000).toStringAsFixed(1)}K Streams this week",
                            track: topSongsTracks[1],
                          ),
                          CustomMusicCard(
                            imageUrl: topSongsTracks[2].imageAsset,
                            title: topSongsTracks[2].title,
                            artist: topSongsTracks[2].artist,
                            streams: "${(topSongsTracks[2].playCount / 1000).toStringAsFixed(1)}K Streams this week",
                            track: topSongsTracks[2],
                          ),
                        ],
                      ),
                      
                      // Charts Tab
                      ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          CustomMusicCard(
                            imageUrl: chartsTracks[0].imageAsset,
                            title: chartsTracks[0].title,
                            artist: chartsTracks[0].artist,
                            streams: "${(chartsTracks[0].playCount / 1000).toStringAsFixed(1)}K Streams this week",
                            badgeText: "7K Likes",
                            track: chartsTracks[0],
                          ),
                          CustomMusicCard(
                            imageUrl: chartsTracks[1].imageAsset,
                            title: chartsTracks[1].title,
                            artist: chartsTracks[1].artist,
                            streams: "${(chartsTracks[1].playCount / 1000).toStringAsFixed(1)}K Streams this week",
                            track: chartsTracks[1],
                          ),
                          CustomMusicCard(
                            imageUrl: chartsTracks[2].imageAsset,
                            title: chartsTracks[2].title,
                            artist: chartsTracks[2].artist,
                            streams: "${(chartsTracks[2].playCount / 1000).toStringAsFixed(1)}K Streams this week",
                            track: chartsTracks[2],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Responsive.h(3)),
                Text(
                  'Top Music Card',
                  style: TextStyle(
                    fontSize: Responsive.textScaleFactor * 18,
                    color: AppColor.whiteColor,
                  ),
                ),

                SizedBox(height: Responsive.h(3)),
                Container(
                  height: 172,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Stack(
                    children: [
                      // Background image
                      Positioned.fill(
                        child: Image.asset(
                          'assets/images/music.png',
                          fit: BoxFit.cover,
                        ),
                      ),

                      // Text overlay with proper spacing
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                Colors.black.withValues(alpha: 0.6),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Drip Life - by Swaggy D',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                      offset: Offset(0, 2),
                                      blurRadius: 6,
                                      color: Colors.black.withValues(
                                        alpha: 0.6,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Watch',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Responsive.h(3)),
                Container(
                  width: double.infinity,
                  height: Responsive.h(19),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
