import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provide/res/components/auth_button.dart';
import 'package:provide/utils/routes/responsive.dart';
import 'package:provide/view/widgets/custom_music_card.dart';
import 'package:provide/view/widgets/custom_searchfield.dart';
import 'package:provide/view/widgets/custom_circle_avatar.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset('assets/images/imic.svg'),
                  Spacer(),

                  // Asset image
                  CustomTinyCircleAvatar(
                    iconPadding: EdgeInsets.all(5),
                    imageUrl: "assets/icons/notification.svg",
                    isAsset: true,
                    bgColor: Color(0x1AFFFFFF),
                  ),

                  CustomTinyCircleAvatar(
                    bgColor: Color(0x1AFFFFFF),
                    imageUrl: "assets/icons/profile.svg",
                    isAsset: true,
                  ),
                ],
              ),
              SizedBox(height: Responsive.h(3)),

              Row(
                children: [
                  Expanded(
                    // 👈 gives TextField flexible width
                    child: CustomSearchField(controller: _searchController),
                  ),
                  CustomTinyCircleAvatar(
                    iconPadding: EdgeInsets.all(5),
                    bgColor: Color(0xffB82816),
                    isAsset: true,
                    imageUrl: 'assets/icons/filter.svg',
                  ),
                ],
              ),
              SizedBox(height: Responsive.h(3)),
              Container(
                height: 200,
                child: Stack(
                  children: <Widget>[
                    // The background image
                    Positioned.fill(
                      child: Image.asset(
                        'assets/images/bg_product_choice.png',
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
                          color: Colors.blue.withOpacity(0.5),
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
                          color: Colors.blue.withOpacity(0.5),
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
                        buttonText: 'Product Choice',
                        loading: false,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: Responsive.w(2)),
                      child: AuthButton(
                        buttonText: 'Product Choice',
                        loading: false,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Responsive.w(6),
                  vertical: Responsive.h(3),
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.10),
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
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                        Text(
                          "DAYS",
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ],
                    ),
                    const Spacer(), // 👈 pushes next column away
                    Text(":"),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "50",
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                        Text(
                          "MIN",
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Text(":"),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: [
                        Text(
                          "12",
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                        Text(
                          "SEC",
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: Responsive.h(3)),
              Text(
                'Top 10 Artists on Charts',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              SizedBox(height: Responsive.h(3)),

              SizedBox(
                height: Responsive.h(19), // Adjust height for card
                child: ListView.builder(
                  scrollDirection: Axis.horizontal, // 🔹 horizontal scroll
                  itemCount: 10, // number of artists
                  itemBuilder: (context, index) {
                    return Container(
                      width: Responsive.w(36), // fixed width for card
                      margin: const EdgeInsets.only(
                        right: 12,
                      ), // spacing between items
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.10),
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
                                radius: 22,
                                backgroundColor:
                                    Colors.grey.shade800, // optional bg color
                                child: SvgPicture.asset(
                                  'assets/icons/profile_images.svg',
                                  width: 28,
                                  height: 28,
                                ),
                              ),

                              // Rank
                              Text(
                                "#${index + 1}",
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          // Name
                          SizedBox(height: 6),
                          Text(
                            "Artist ${index + 1}", // replace with data
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),

                          const SizedBox(height: 4),

                          // Category
                          const Text(
                            "Hip-Hop",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: Responsive.h(
                  32,
                ), // Provide a responsive height constraint (25% of screen height)
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    CustomMusicCard(
                      imageUrl: "assets/images/havana.png",
                      title: "Havana",
                      artist: "Cooper Gouse",
                      streams: "32.4K Streams this week",
                      badgeText: "3K Likes",
                    ),
                    CustomMusicCard(
                      imageUrl: "assets/images/nelda.png",
                      title: "Nelda",
                      artist: "Cooper Gouse",
                      streams: "32.4K Streams this week",
                    ),
                    CustomMusicCard(
                      imageUrl: "assets/images/no_sleep.png",
                      title: "No Sleep",
                      artist: "Cooper Gouse",
                      streams: "32.4K Streams this week",
                    ),
                  ],
                ),
              ),

              Text(
                'Top Music Card',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              SizedBox(height: Responsive.h(3)),
              Container(
                height: 172,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                clipBehavior: Clip.hardEdge,
                child: FittedBox(
                  fit: BoxFit.cover, // Ensures the SVG covers the container
                  child: Image.asset('assets/images/music.png'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
