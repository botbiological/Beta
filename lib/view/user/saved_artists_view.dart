import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provide/res/components/app_color.dart';
import 'package:provide/utils/routes/responsive.dart';
import 'package:provide/utils/routes/routes_name.dart';
import 'package:provide/view/user/profile_view.dart';
import 'package:provide/widgets/custom_circle_avatar.dart';
import 'package:provide/widgets/text_widget.dart';

class SavedArtistsView extends StatelessWidget {
  const SavedArtistsView({super.key});

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: SafeArea(
        child: ListView(
          children: [
            Column(children: [_buildHeader(context), _savedcard(context)]),
          ],
        ),
      ),
    );
  }
}

//--- saved card with listviewBuilder
Widget _savedcard(BuildContext context) {
  Responsive.init(context);
  return ListView.builder(
    shrinkWrap: true,
    // padding: Responsive.padding(top: 1),
    physics: NeverScrollableScrollPhysics(),
    itemCount: 6,
    itemBuilder: ((context, index) {
      return Padding(
        padding: EdgeInsets.symmetric(
          vertical: Responsive.h(1),

          horizontal: Responsive.w(5),
        ),

        child: Container(
          decoration: BoxDecoration(
            color: AppColor.darkGray,
            borderRadius: BorderRadius.circular(22),
          ),
          child: Padding(
            padding: Responsive.padding(left: 2, right: 2, bottom: 2, top: 2),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(
                    "assets/images/Ellipse 2 (1).png",
                  ),
                ),
                SizedBox(width: Responsive.w(1)),
                Column(
                  spacing: Responsive.h(1),
                  children: [
                    TextWidget(text: "Cooper"),
                    TextWidget(
                      text: "Hip-Hop",
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: AppColor.textColor.withValues(alpha: 0.5),
                    ),
                  ],
                ),
                Spacer(),
                SvgPicture.asset("assets/icons/favourite.svg"),
              ],
            ),
          ),
        ),
      );
    }),
  );
}

//--- build Header
Widget _buildHeader(BuildContext context) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: Responsive.w(5)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextWidget(
          text: "Saved Artists",
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        Row(
          children: [
            // Added proper spacing between icons
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
        ),
      ],
    ),
  );
}
