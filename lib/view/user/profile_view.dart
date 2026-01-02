import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provide/res/components/app_color.dart';
import 'package:provide/utils/routes/responsive.dart';
import 'package:provide/utils/routes/routes_name.dart';
import 'package:provide/view/plan/subscription_screen.dart';
import 'package:provide/view/plan/subscription_screen2.dart';
import 'package:provide/view/settings/privacy_security_screen.dart';
import 'package:provide/view/settings/support_screen.dart';
import 'package:provide/view/settings/terms_and_condition.dart';
import 'package:provide/viewmodel/logout_viewmodel.dart';
import 'package:provide/widgets/custom_circle_avatar.dart';
import 'package:provide/widgets/text_widget.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final logoutProvider = context.watch<LogoutViewmodel>();
    Responsive.init(context);
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.w(5),
              vertical: Responsive.h(4),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildHeader(context),
                CircleAvatar(
                  radius: Responsive.sp(35),
                  backgroundImage: AssetImage("assets/images/user_profile.png"),
                ),
                SizedBox(height: Responsive.h(2)),
                TextWidget(text: "Jaylon Dorwart", fontSize: 20),
                SizedBox(height: Responsive.h(2)),
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
                          path: "assets/icons/diamond.svg",
                          text: "Subscription & Plan",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SubscriptionScreen(),
                              ),
                            );
                          },
                        ),
                        _expanderDivider(),
                        _profileMenuCard(
                          path: "assets/icons/notification_outline.svg",
                          text: "Notification Preferences",
                          onTap: () {},
                        ),
                        _expanderDivider(),
                        _profileMenuCard(
                          path: "assets/icons/security.svg",
                          text: "Privacy & Security",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PrivacySecurityScreen(),
                              ),
                            );
                          },
                        ),
                        _expanderDivider(),
                        _profileMenuCard(
                          path: "assets/icons/security.svg",
                          text: "Support",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SupportScreen(),
                              ),
                            );
                          },
                        ),
                        _expanderDivider(),
                        _profileMenuCard(
                          path: "assets/icons/document-attachment.svg",
                          text: "Terms & Conditions",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TermsScreen(),
                              ),
                            );
                          },
                        ),
                        _expanderDivider(),
                        _profileMenuCard(
                          path: "assets/icons/language.svg",
                          text: "Language",
                          onTap: () {},
                        ),
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
                  onTap: () async {
                    if (!logoutProvider.isloggingOut) {
                      bool success = await logoutProvider.logout();
                      if (success) {
                        Navigator.pushReplacementNamed(
                            context, RoutesName.login);
                      }
                    }
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
                      child: Center(
                        child: logoutProvider.isloggingOut
                            ? CircularProgressIndicator()
                            : TextWidget(text: "Logout"),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//--- build Header
Widget _buildHeader(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          CustomTinyCircleAvatar(
            onTap: () {
              Navigator.pop(context);
            },
            baseColor: AppColor.primaryColor,
            bgColor: AppColor.primaryColor,
            imageUrl: "assets/icons/Arrowback.svg",
            isAsset: true,
          ),
          TextWidget(
            text: "Profile",
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
      Row(
        // Using proper spacing instead of non-existent 'spacing' property
        children: [
          CustomTinyCircleAvatar(
            baseColor: AppColor.textColor.withOpacity(0.1),
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

Widget _profileMenuCard({
  String? path,
  String? text,
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(12),
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: AppColor.textColor.withOpacity(0.07),
              borderRadius: BorderRadius.circular(11),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SvgPicture.asset(path ?? ''),
            ),
          ),
        ),
        TextWidget(text: text ?? ''),
      ],
    ),
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
