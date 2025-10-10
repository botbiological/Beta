import 'package:flutter/material.dart';
import 'package:provide/res/components/app_color.dart';
import 'package:provide/utils/routes/responsive.dart';
import 'package:provide/widgets/custom_circle_avatar.dart';
import 'package:provide/widgets/text_widget.dart';

class ArtitistProfileView extends StatelessWidget {
  const ArtitistProfileView({super.key});

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
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  SizedBox(height: Responsive.h(1)),

                  aboutArtist(
                    "Cooper",
                    "Hip-Hop",
                    "Edit Profile",
                    "assets/images/Ellipse 2.png",
                  ),

                  SizedBox(height: Responsive.h(1)),
                  Row(
                    spacing: Responsive.w(2),
                    children: [
                      aboutcard("Total Tracks", "108"),
                      aboutcard("Followers", "750k"),
                      aboutcard("Following", "50k"),
                    ],
                  ),
                  SizedBox(height: Responsive.h(1)),
                  Row(
                    spacing: Responsive.w(2),
                    children: [
                      aboutcard("Total Plays", "108"),
                      aboutcard("Chart Votes", "7.5k"),
                      aboutcard("Top Chart Rank", "#2"),
                    ],
                  ),
                  SizedBox(height: Responsive.h(1)),
                  aboutArtist(
                    "The Dream",
                    "Producer",
                    "View Profile",
                    "assets/images/Ellipse 2.png",
                  ),
                  TextWidget(
                    text: "Tracks Uploaded ( 12 )",
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),

                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 10,
                    itemBuilder: ((context, index) {
                      return Padding(
                        padding: Responsive.padding(
                          left: 0,
                          right: 0,
                          top: 1,
                          bottom: 0,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColor.whiteColor.withValues(alpha: 0.10),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Padding(
                            padding: Responsive.padding(
                              left: 1,
                              right: 1,
                              top: 1,
                              bottom: 1,
                            ),
                            child: Row(
                              children: [
                                // SvgPicture.asset("assets/images/mdi_play.svg"),
                                Image.asset(
                                  "assets/images/Component 1 (3).png",
                                ),
                                SizedBox(width: Responsive.w(2)),
                                Column(
                                  spacing: Responsive.h(1),
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextWidget(text: "No Sleep Tonight"),
                                    TextWidget(
                                      text: "By Young Blaze",
                                      fontSize: 8,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    TextWidget(
                                      text: "Produced by: Khaled",
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Column(
                                  spacing: Responsive.h(1),
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextWidget(
                                      text: "32.4K Streams",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//--- build Header
Widget _buildHeader() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          CustomTinyCircleAvatar(
            baseColor: AppColor.primaryColor,
            bgColor: AppColor.primaryColor,
            imageUrl: "assets/icons/Arrowback.svg",
            isAsset: true,
          ),
          TextWidget(
            text: "Artist Profile",
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),

      Row(
        // Using proper spacing instead of non-existent 'spacing' property
        children: [
          CustomTinyCircleAvatar(
            baseColor: AppColor.textColor.withValues(alpha: 0.1),
            iconPadding: const EdgeInsets.all(5),
            imageUrl: "assets/icons/comment.svg",
            isAsset: true,
            bgColor: const Color(0x1AFFFFFF),
          ),
          SizedBox(width: Responsive.w(2)),
          CustomTinyCircleAvatar(
            baseColor: AppColor.textColor.withValues(alpha: 0.1),
            iconPadding: const EdgeInsets.all(5),
            imageUrl: "assets/icons/favouriteborader.svg",
            isAsset: true,
            bgColor: const Color(0x1AFFFFFF),
          ),
          SizedBox(width: Responsive.w(2)),
          CustomTinyCircleAvatar(
            baseColor: AppColor.textColor.withValues(alpha: 0.1),
            iconPadding: const EdgeInsets.all(5),
            imageUrl: "assets/icons/share.svg",
            isAsset: true,
            bgColor: const Color(0x1AFFFFFF),
          ),
          SizedBox(width: Responsive.w(2)),
        ],
      ),
    ],
  );
}

Widget aboutArtist(String name, String role, String buttonText, String path) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(18),
      color: AppColor.textColor.withValues(alpha: 0.1),
    ),
    child: Padding(
      padding: Responsive.padding(left: 3, right: 3, top: 1, bottom: 1),
      child: Row(
        children: [
          CircleAvatar(backgroundImage: AssetImage(path)),
          SizedBox(width: Responsive.w(2)),
          Column(
            spacing: Responsive.h(1),
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(text: name),
              TextWidget(text: role, fontSize: 10, fontWeight: FontWeight.w400),
            ],
          ),
          Spacer(),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: AppColor.textColor,
            ),
            child: Padding(
              padding: Responsive.padding(left: 3, right: 3, top: 1, bottom: 1),
              child: TextWidget(
                text: buttonText,
                color: AppColor.seconadryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget aboutcard(String text, String value) {
  return Expanded(
    child: Container(
      decoration: BoxDecoration(
        color: AppColor.whiteColor.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: Responsive.h(1),
          children: [
            TextWidget(text: text, fontWeight: FontWeight.w600),
            TextWidget(text: value, fontSize: 20, fontWeight: FontWeight.w600),
          ],
        ),
      ),
    ),
  );
}
