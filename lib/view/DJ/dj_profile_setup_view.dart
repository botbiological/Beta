import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provide/res/components/app_color.dart';
import 'package:provide/utils/routes/responsive.dart';
import 'package:provide/widgets/text_widget.dart';

class DjProfileSetupView extends StatelessWidget {
  const DjProfileSetupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: SafeArea(
        child: Column(
          spacing: 5,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset("assets/icons/Arrowback.svg"),
            SizedBox(height: Responsive.h(1)),
            TextWidget(text: "Profile Setup", fontSize: 35),
            SizedBox(height: Responsive.h(1)),
            SvgPicture.asset("assets/images/Frame 1410120878.svg"),
            SizedBox(height: Responsive.h(1)),
            TextFormField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                label: TextWidget(text: "Full Name"),
                filled: true,
                fillColor: AppColor.textColor.withValues(alpha: 0.10),
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                label: TextWidget(text: "Pick Genre"),
                filled: true,
                fillColor: AppColor.textColor.withValues(alpha: 0.10),
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                label: TextWidget(text: "Genre Tags"),
                filled: true,
                fillColor: AppColor.textColor.withValues(alpha: 0.10),
              ),
            ),
            Spacer(),
            Container(
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
                child: Center(child: TextWidget(text: "Save & continue")),
              ),
            ),
            SizedBox(height: Responsive.h(1)),
          ],
        ),
      ),
    );
  }
}
