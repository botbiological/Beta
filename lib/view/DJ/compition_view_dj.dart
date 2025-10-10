import 'package:flutter/material.dart';
import 'package:provide/res/components/app_color.dart';
import 'package:provide/utils/routes/responsive.dart';
import 'package:provide/utils/routes/routes_name.dart';
import 'package:provide/widgets/custom_circle_avatar.dart';
import 'package:provide/widgets/text_widget.dart';

class CompitionViewDj extends StatefulWidget {
  const CompitionViewDj({super.key});

  @override
  State<CompitionViewDj> createState() => _CompitionViewDjState();
}

class _CompitionViewDjState extends State<CompitionViewDj> {
  int _selectedTab = 0; // 0 for Ongoing, 1 for Upcoming

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    return Scaffold(
      backgroundColor: AppColor.primaryColor,

      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            // Tab selector
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 20,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E1E),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedTab = 0;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: _selectedTab == 0
                                ? AppColor.seconadryColor
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'Ongoing',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedTab = 1;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: _selectedTab == 1
                                ? AppColor.seconadryColor
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'Upcoming',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Content based on selection
            Expanded(
              child: _selectedTab == 0
                  ? _buildOngoingContent()
                  : _buildUpcomingContent(),
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
        Row(
          // Using MainAxisAlignment instead of non-existent spacing property
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
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
              bgColor: const Color(0x1AFFFFFF),
              imageUrl: "assets/icons/profile.svg",
              isAsset: true,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildOngoingContent() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: const [
        CompetitionCard(
          title: 'Brian Michael Cox',
          subtitle: 'The Dream',
          dateRange: 'May 25-June 20',
          prize: '\$1,000',
          buttonText: 'Submit Track',
        ),
        CompetitionCard(
          title: 'Brian Michael Cox',
          subtitle: 'The Dream',
          dateRange: 'May 25-June 20',
          prize: '\$1,000',
          buttonText: 'Submit Track',
        ),
        CompetitionCard(
          title: 'Brian Michael Cox',
          subtitle: 'The Dream',
          dateRange: 'May 25-June 20',
          prize: '\$1,000',
          buttonText: 'Submit Track',
        ),
        CompetitionCard(
          title: 'Brian Michael Cox',
          subtitle: 'The Dream',
          dateRange: 'May 25-June 20',
          prize: '\$1,000',
          buttonText: 'Submit Track',
        ),
        CompetitionCard(
          title: 'Brian Michael Cox',
          subtitle: 'The Dream',
          dateRange: 'May 25-June 20',
          prize: '\$1,000',
          buttonText: 'Submit Track',
        ),
        CompetitionCard(
          title: 'Brian Michael Cox',
          subtitle: 'The Dream',
          dateRange: 'May 25-June 20',
          prize: '\$1,000',
          buttonText: 'Submit Track',
        ),
        // Add more ongoing competitions here
      ],
    );
  }

  Widget _buildUpcomingContent() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: const [
        CompetitionCard(
          title: 'IMIC June Producer Battle',
          subtitle: 'Producer Showdown',
          dateRange: 'June 25-July 20',
          prize: '\$2,500',
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
