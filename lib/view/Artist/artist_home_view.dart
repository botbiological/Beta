import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provide/res/components/app_color.dart';
import 'package:provide/utils/routes/responsive.dart';
import 'package:provide/view/Artist/artitist_profile_view.dart';
import 'package:provide/widgets/custom_circle_avatar.dart';
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: Responsive.h(1),
              children: [
                _buildHeader(context),
                TextfeildWithButtom(),
                Row(
                  spacing: Responsive.w(0.5),
                  children: [
                    _customCard("Total Streams", "12"),
                    _customCard("Likes This Week", "4"),
                    _customCard("New Followers", "18"),
                  ],
                ),
                // _customsingleCard("Likes This Week", "#1"),
                // TextWidget(text: "New Artist Submissions"),
                // _newartistsubmissions(),
                TextWidget(text: "Top Artists"),
                _verticalScrollList(),
                TextWidget(text: "Streaming Graph"),
                Image(image: AssetImage("assets/images/Frame 1410120922.png")),

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     TextWidget(text: "Collab Requests"),
                //     TextWidget(
                //       text: "See All",
                //       fontWeight: FontWeight.normal,
                //       fontSize: 12,
                //     ),
                //   ],
                // ),
                // _newartistsubmissions(),

                // _newartistsubmissions(),
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
      SvgPicture.asset("assets/images/imic_home.svg"),
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
             onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ArtitistProfileView(), // 👈 destination screen
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

Widget _customsingleCard(String text, String value) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: AppColor.darkGray,
      borderRadius: BorderRadius.circular(18),
    ),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextWidget(text: text),
          TextWidget(text: value),
        ],
      ),
    ),
  );
}

Widget _newartistsubmissions() {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: AppColor.darkGray,
      borderRadius: BorderRadius.circular(18),
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Image(image: AssetImage("assets/icons/Component 1 (1).png")),
          SizedBox(width: Responsive.w(2)),
          Column(
            spacing: Responsive.h(1),
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(text: "Streaming Graph"),
              TextWidget(text: "Streaming Graph", fontSize: 10),
            ],
          ),
          Spacer(),
          Row(
            spacing: Responsive.w(2),
            children: [
              SvgPicture.asset("assets/icons/adds.svg"),
              SvgPicture.asset("assets/icons/cancle.svg"),
            ],
          ),
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
                  SvgPicture.asset("assets/icons/Frame 1000002151 (1).svg"),
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
