import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provide/res/components/app_color.dart';
import 'package:provide/utils/routes/responsive.dart';
import 'package:provide/utils/routes/routes_name.dart';
import 'package:provide/view/user/profile_view.dart';
import 'package:provide/widgets/custom_circle_avatar.dart';
import 'package:provide/widgets/text_widget.dart';
import 'package:provide/widgets/textfeild_with_buttom.dart';

class ProducerHomeView extends StatelessWidget {
  const ProducerHomeView({super.key});

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
                spacing: Responsive.h(1),
                children: [
                  _buildHeader(context),
                  TextfeildWithButtom(),
                  Row(
                    spacing: Responsive.w(1),
                    children: [
                      _customCard("Rewards Sent", "12"),
                      _customCard("Collab Requests", "4"),
                      _customCard("New Followers", "18"),
                    ],
                  ),
                  Row(
                    spacing: Responsive.w(1),
                    children: [
                      _customCard("Total Streams", "2.3K"),
                      _customCard("Likes This Week", "138"),
                    ],
                  ),
                  _customsingleCard("Likes This Week", "#1"),
                  TextWidget(text: "New Artist Submissions"),
                  _newartistsubmissions('No Sleep Tonight', 'Hip Hop'),
                  TextWidget(text: "Top Artists"),
                  _verticalScrollList(),
                  TextWidget(text: "Streaming Graph"),
                  Image(
                    image: AssetImage("assets/images/Frame 1410120922.png"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidget(text: "Collab Requests"),
                      TextWidget(
                        text: "See All",
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                      ),
                    ],
                  ),
                  _newartistsubmissions(
                    'Cooper',
                    'Hip Hop',
                    'assets/images/cooper.png',
                  ),
                  _newartistsubmissions(
                    'Tiana',
                    'Hip Hop',
                    'assets/images/tiana.png',
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
      // SizedBox(child: SvgPicture.asset("assets/icons/notification.svg")),
      Text(''),
      Row(
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
            bgColor: Color(0x1AFFFFFF),
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
      )
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
            TextWidget(text: text),
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

Widget _newartistsubmissions(
  String artistName,
  String title, [
  String? imagePath,
]) {
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
          imagePath != null
              ? Image(image: AssetImage(imagePath))
              : Image(image: AssetImage("assets/icons/Component 1 (1).png")),
          SizedBox(width: Responsive.w(2)),
          Column(
            spacing: Responsive.h(1),
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(text: artistName),
              TextWidget(text: "Hip Hop", fontSize: 10),
            ],
          ),
          Spacer(),
          Row(
            spacing: Responsive.w(2),
            children: [
              SvgPicture.asset("assets/icons/cancle.svg"),
              SvgPicture.asset("assets/icons/adds.svg"),
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
    height: Responsive.h(17),
    child: ListView.builder(
      shrinkWrap: true,
      // physics:,
      scrollDirection: Axis.horizontal,
      itemCount: 10,
      itemBuilder: ((context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: Responsive.w(30),
            height: Responsive.h(30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: AppColor.darkGray,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                // spacing: Responsive.h(1),
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image(
                        width: Responsive.w(10),
                        height: Responsive.w(10),
                        image: AssetImage("assets/images/Ellipse 2 (1).png"),
                      ),
                      TextWidget(text: "#2"),
                    ],
                  ),
                  SizedBox(height: Responsive.h(1)),
                  TextWidget(text: "Cooper"),
                  SizedBox(height: Responsive.h(0.5)),
                  TextWidget(
                    text: "Hip-Hop",
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
