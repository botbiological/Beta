import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provide/res/components/app_color.dart';
import 'package:provide/utils/routes/responsive.dart';
import 'package:provide/utils/routes/routes_name.dart';
import 'package:provide/widgets/custom_circle_avatar.dart';
import 'package:provide/widgets/text_widget.dart';

class ProflieSettingDjView extends StatelessWidget {
  const ProflieSettingDjView({super.key});

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildHeader(),
              CircleAvatar(
                radius: Responsive.sp(35),
                backgroundImage: AssetImage("assets/images/Ellipse 2.png"),
              ),
              TextWidget(text: "Jaylon Dorwart", fontSize: 20),
              SizedBox(height: Responsive.h(1)),
              Container(
                decoration: BoxDecoration(
                  color: AppColor.textColor.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      _profileMenuCard(
                        "assets/icons/diamond.svg",
                        "Subscription & Plan",
                      ),
                      _expanderDivider(),
                      _profileMenuCard(
                        "assets/icons/notification_outline.svg",
                        "Notification Preferences",
                      ),
                      _expanderDivider(),
                      _profileMenuCard(
                        "assets/icons/security.svg",
                        "Privacy & Security",
                      ),
                      _expanderDivider(),
                      _profileMenuCard("assets/icons/customer.svg", "Support"),
                      _expanderDivider(),
                      _profileMenuCard(
                        "assets/icons/document-attachment.svg",
                        "Terms & Conditions",
                      ),
                      _expanderDivider(),
                      _profileMenuCard("assets/icons/language.svg", "Language"),
                    ],
                  ),
                ),
              ),

              SizedBox(height: Responsive.h(1)),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColor.seconadryColor),
                  borderRadius: BorderRadius.circular(18),
                  color: AppColor.seconadryColor.withValues(alpha: 0.2),
                ),
                child: Padding(
                  padding: Responsive.padding(
                    left: 2,
                    right: 2,
                    top: 1.5,
                    bottom: 1.5,
                  ),
                  child: Center(child: TextWidget(text: "Delete My Account")),
                ),
              ),
              SizedBox(height: Responsive.h(1)),
             GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context,RoutesName.login);
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColor.seconadryColor),
                    borderRadius: BorderRadius.circular(18),
                    color: AppColor.seconadryColor,
                  ),
                  child: Padding(
                    padding: Responsive.padding(
                      left: 2,
                      right: 2,
                      top: 1.5,
                      bottom: 1.5,
                    ),
                    child: Center(child: TextWidget(text: "Logout")),
                  ),
                ),
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
            text: "Saved Artists",
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),

      Row(
        // Using proper spacing instead of non-existent 'spacing' property
        children: [
          CustomTinyCircleAvatar(
            baseColor: AppColor.textColor.withValues(alpha:0.1),
            iconPadding: const EdgeInsets.all(5),
            imageUrl: "assets/icons/notification.svg",
            isAsset: true,
            bgColor: const Color(0x1AFFFFFF),
          ),
          SizedBox(width: Responsive.w(2)),
        ],
      ),
    ],
  );
}

Widget _profileMenuCard(String path, String text) {
  return Row(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 6.0),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: AppColor.textColor.withValues(alpha: 0.07),
            borderRadius: BorderRadius.circular(11),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(path),
          ),
        ),
      ),
      TextWidget(text: text, fontSize: 12),
    ],
  );
}

Widget _expanderDivider() {
  return Row(
    children: [
      Expanded(
        child: Divider(
          color: AppColor.textColor.withValues(alpha: 0.1),
          thickness: 1.5,
        ),
      ),
    ],
  );
}
