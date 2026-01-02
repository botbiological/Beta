import 'package:flutter/material.dart';
import 'package:provide/res/components/app_color.dart';
import 'package:provide/utils/routes/responsive.dart';
import 'package:provide/widgets/custom_circle_avatar.dart';
import 'package:provide/widgets/text_widget.dart'; // Only if you're using an SVG icon

class TermsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.w(5),
          vertical: Responsive.h(4),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title Section with Icon
              _buildHeader(context),
              SizedBox(height: 20),

              // Terms Text Content (Repeat as needed)
              ...List.generate(
                6,
                (index) => Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
                    "Vestibulum fermentum urna sit amet mi fringilla, non vehicula mauris eleifend. ",
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

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
              text: "Terms & Conditions",
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ],
    );
  }
}
