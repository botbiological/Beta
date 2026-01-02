import 'package:flutter/material.dart';
import 'package:provide/res/components/app_color.dart';
import 'package:provide/utils/routes/responsive.dart';
import 'package:provide/widgets/text_widget.dart';

class CompetitionScreen extends StatefulWidget {
  const CompetitionScreen({super.key});

  @override
  State<CompetitionScreen> createState() => _CompetitionScreenState();
}

class _CompetitionScreenState extends State<CompetitionScreen> {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              _buildHeader(),
              SizedBox(height: Responsive.h(3)),

              // Tab Section with proper TabBar
              Expanded(
                child: DefaultTabController(
                  length: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // TabBar matching user competitions style
                      TabBar(
                        indicator: const UnderlineTabIndicator(
                          borderSide: BorderSide(
                            color: AppColor.seconadryColor,
                            width: 4,
                          ),
                        ),
                        indicatorSize: TabBarIndicatorSize.tab,
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                        unselectedLabelStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.white70,
                        dividerColor: const Color(0x33FFFFFF),
                        tabs: const [
                          Tab(text: "Ongoing"),
                          Tab(text: "Upcoming"),
                        ],
                      ),

                      // TabBarView
                      Expanded(
                        child: TabBarView(
                          children: [
                            // Ongoing Tab Content
                            SingleChildScrollView(
                              child: Column(
                                children: [
                                  SizedBox(height: Responsive.h(2)),
                                  _buildOngoingContent(),
                                ],
                              ),
                            ),
                            // Upcoming Tab Content
                            SingleChildScrollView(
                              child: Column(
                                children: [
                                  SizedBox(height: Responsive.h(2)),
                                  _buildUpcomingContent(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOngoingContent() {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColor.darkGray,
        borderRadius: BorderRadius.circular(18),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Column(
          children: [
            // 👤 Background image + players
            SizedBox(
              height: 150,
              child: Stack(
                children: <Widget>[
                  // Background Image
                  Positioned.fill(
                    child: Image.asset(
                      'assets/images/cover_page.png',
                      fit: BoxFit.cover,
                    ),
                  ),

                  // Player Avatars
                  Positioned.fill(
                    child: Stack(
                      children: [
                        // Left Player
                        Positioned(
                          left: 20,
                          top: 25,
                          child: Column(
                            children: [
                              Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.red,
                                    width: 4,
                                  ),
                                ),

                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black,
                                  ),
                                  padding: EdgeInsets.all(4),
                                  child: ClipOval(
                                    child: Image.asset(
                                      'assets/images/first_player.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Brian Michael Cox',
                                style: TextStyle(
                                  color: AppColor.textColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Right Player
                        Positioned(
                          right: 20,
                          top: 25,
                          child: Column(
                            children: [
                              Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.red,
                                    width: 4,
                                  ),
                                ),

                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black,
                                  ),
                                  padding: EdgeInsets.all(4),
                                  child: ClipOval(
                                    child: Image.asset(
                                      'assets/images/second_player.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'The Dream',
                                style: TextStyle(
                                  color: AppColor.textColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: Responsive.h(2)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Responsive.w(2)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title & date
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'iMIC June Producer Battle',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'May 25 – June 20',
                        style: TextStyle(color: Colors.grey[400], fontSize: 12),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  // Submit & Prize
                  Divider(color: Color(0xffEDEDED33).withOpacity(0.1)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Submit Track',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Prizes: \$1,000',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
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
        TextWidget(
          text: "Competitions",
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ],
    );
  }

  Widget _buildUpcomingContent() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        CompetitionCard(
          title: 'IMIC June Producer Battle',
          subtitle: 'Producer Showdown',
          dateRange: 'June 25-July 20',
          prize: '\$2,500',
          buttonText: 'Notify Me',
        ),
        CompetitionCard(
          title: 'Summer Beat Challenge',
          subtitle: 'Beat Making Contest',
          dateRange: 'July 15-August 15',
          prize: '\$1,500',
          buttonText: 'Notify Me',
        ),
        // Add more upcoming competitions here
      ],
    );
  }
}

class CompetitionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String dateRange;
  final String prize;
  final String buttonText;

  const CompetitionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.dateRange,
    required this.prize,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(color: Colors.grey, fontSize: 16),
          ),
          const SizedBox(height: 12),
          Text(
            dateRange,
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Prizes: $prize',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.seconadryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                ),
                child: Text(buttonText),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:provide/res/components/app_color.dart';
// import 'package:provide/utils/routes/responsive.dart';
// import 'package:provide/widgets/custom_circle_avatar.dart';
// import 'package:provide/widgets/text_widget.dart';

// class ArtistCompetitionsView extends StatelessWidget {
//   const ArtistCompetitionsView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     Responsive.init(context);
//     return Scaffold(
//       backgroundColor: AppColor.primaryColor,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 8.0),
//           child: Column(children: [_buildHeader()]),
//         ),
//       ),
//     );
//   }
// }

// Widget _buildHeader() {
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: [
//       TextWidget(
//         text: "Competitions",
//         fontSize: 20,
//         fontWeight: FontWeight.w600,
//       ),
//       Row(
//         // Using MainAxisAlignment instead of non-existent spacing property
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           CustomTinyCircleAvatar(
//             baseColor: AppColor.textColor.withValues(alpha:0.1),
//             iconPadding: const EdgeInsets.all(5),
//             imageUrl: "assets/icons/notification.svg",
//             isAsset: true,
//             bgColor: const Color(0x1AFFFFFF),
//           ),
//           SizedBox(width: Responsive.w(2)),
//           CustomTinyCircleAvatar(
//             baseColor: AppColor.textColor.withValues(alpha:0.1),
//             bgColor: const Color(0x1AFFFFFF),
//             imageUrl: "assets/icons/profile.svg",
//             isAsset: true,
//           ),
//         ],
//       ),
//     ],
//   );
// }
