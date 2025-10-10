import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provide/res/components/app_color.dart';
import 'package:provide/utils/routes/responsive.dart';
import 'package:provide/view/Artist/artitist_profile_view.dart';
import 'package:provide/view/user/profile_view.dart';
import 'package:provide/widgets/custom_circle_avatar.dart';
import 'package:provide/widgets/custom_music_card.dart';
import 'package:provide/widgets/text_widget.dart';
import 'package:provide/widgets/textfeild_with_buttom.dart';

class ArtistHomeView extends StatelessWidget {
  const ArtistHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.w(5),
                vertical: Responsive.h(4),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: Responsive.h(1),
                children: [
                  _buildHeader(context),
                  TextfeildWithButtom(),
                  Row(
                    spacing: Responsive.w(0.5),
                    children: [
                      _customCard("Total Streams", "12.k"),
                      SizedBox(width: Responsive.w(2)),
                      _customCard("Likes This Week", "4"),
                      SizedBox(width: Responsive.w(2)),
                      _customCard("New Followers", "18"),
                    ],
                  ),

                  _RowCard('Rank in Battles', '#2'),
                  SizedBox(height: Responsive.h(1)),
                  Text(
                    'Your Top Track This Week',
                    style: GoogleFonts.onest(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: Responsive.textScaleFactor * 18,
                    ),
                  ),

                  // _verticalScrollList(),
                  Container(
                    constraints: BoxConstraints(
                      minHeight: Responsive.h(33),
                      maxHeight: Responsive.h(34),
                    ),
                    height: Responsive.h(32),

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
                  SizedBox(height: Responsive.h(3)),
                  TextWidget(text: "Streaming Graph"),
                  Image(
                    image: AssetImage("assets/images/Frame 1410120922.png"),
                  ),

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
                ],
              ),
            ),
          ],
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

Widget _verticalScrollList() {
  return SizedBox(
    width: double.infinity,
    height: Responsive.h(28),
    child: ListView.builder(
      shrinkWrap: true,
      // physics:,
      scrollDirection: Axis.horizontal,
      itemCount: 10,
      itemBuilder: ((context, index) {
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            width: Responsive.w(35),
            height: Responsive.h(70),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: AppColor.darkGray,
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset("assets/images/havana.png"),
                  SizedBox(height: Responsive.h(1)),
                  TextWidget(text: "By Cooper Gouse", fontSize: 10),
                  SizedBox(height: Responsive.h(0.5)),
                  //
                  TextWidget(
                    text: "Hip-Hop",
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(height: Responsive.h(0.5)),
                  TextWidget(
                    text: "32.4K Streams this week",
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    ),
  );
}
