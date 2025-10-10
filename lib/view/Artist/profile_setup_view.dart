import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provide/res/components/app_color.dart';
import 'package:provide/utils/routes/responsive.dart';
import 'package:provide/utils/routes/routes_name.dart';
import 'package:provide/widgets/text_widget.dart';

class ProfileSetupView extends StatelessWidget {
  const ProfileSetupView({super.key});

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
            spacing: 5,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: SvgPicture.asset("assets/icons/Arrowback.svg"),
              ),

              SizedBox(height: Responsive.h(1)),
              TextWidget(text: "Profile Setup", fontSize: 35),
              SizedBox(height: Responsive.h(1)),
              SvgPicture.asset("assets/images/Frame 1410120878.svg"),
              SizedBox(height: Responsive.h(1)),
              TextFormField(
                style: TextStyle(color: AppColor.textColor),
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
                style: TextStyle(color: AppColor.textColor),
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
                style: TextStyle(color: AppColor.textColor),
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
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.subscription);
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
                    child: Center(child: TextWidget(text: "Save & continue")),
                  ),
                ),
              ),
              SizedBox(height: Responsive.h(1)),
            ],
          ),
        ),
      ),
    );
  }
}
