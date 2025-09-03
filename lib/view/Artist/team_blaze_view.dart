import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provide/res/components/app_color.dart';
import 'package:provide/utils/routes/responsive.dart';
import 'package:provide/widgets/custom_circle_avatar.dart';
import 'package:provide/widgets/text_widget.dart';

class TeamBlazeView extends StatelessWidget {
  const TeamBlazeView({super.key});

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(
            Responsive.w(4),
          ), // Added padding for better spacing
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                SizedBox(height: Responsive.h(2)),

                // Fixed Row with proper spacing
                Row(
                  children: [
                    Expanded(child: customCard()),
                    SizedBox(width: Responsive.w(2)),
                    Expanded(child: customCard()),
                    SizedBox(width: Responsive.w(2)),
                    Expanded(child: customCard()),
                  ],
                ),
                SizedBox(height: Responsive.h(2)),

                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Responsive.w(4),
                    vertical: Responsive.h(2),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(
                      alpha: 0.10,
                    ), // Fixed withOpacity
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildTimeColumn("12", "DAYS"),
                      _buildTimeSeparator(),
                      _buildTimeColumn("50", "MIN"),
                      _buildTimeSeparator(),
                      _buildTimeColumn("12", "SEC"),
                    ],
                  ),
                ),
                SizedBox(height: Responsive.h(2)),

                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: AppColor.darkGray,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor:
                              Colors.grey, // Added background color
                        ),
                        SizedBox(width: Responsive.w(2)),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(text: "The Dream"),
                              TextWidget(text: "Producer", fontSize: 12),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColor.whiteColor,
                            borderRadius: BorderRadius.circular(28),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                              vertical: 8.0,
                            ),
                            child: TextWidget(
                              text: "View Profile", // Fixed typo
                              color: AppColor.seconadryColor,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: Responsive.h(2)),

                TextWidget(
                  text: "Submit Battle Tracks",
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
                SizedBox(height: Responsive.h(2)),

                GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: 8,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: ((context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: AppColor.darkGray,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical:  4.0,horizontal: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              "assets/images/Frame 1000002151.svg",
                            ),
                            SizedBox(height: Responsive.h(0.5)),
                            TextWidget(text: "Havana"),
                            SizedBox(height: Responsive.h(0.5)),
                            TextWidget(
                              text: "32.4K Streams this week",
                              fontSize: 10,
                            ),
                          ],
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
    );
  }

  // Helper method for time columns
  Widget _buildTimeColumn(String number, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          number,
          style: GoogleFonts.onest(
            color: Colors.white,
            fontSize: Responsive.textScaleFactor * 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.onest(
            color: Colors.white,
            fontSize: Responsive.textScaleFactor * 10,
          ),
        ),
      ],
    );
  }

  // Helper method for time separators
  Widget _buildTimeSeparator() {
    return Text(
      ":",
      style: GoogleFonts.onest(
        color: Colors.white,
        fontSize: Responsive.textScaleFactor * 25,
        fontWeight: FontWeight.bold,
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
          SvgPicture.asset("assets/icons/Arrowback.svg"),
          SizedBox(width: Responsive.w(2)),
          TextWidget(
            text: "Team Blaze",
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
      Row(
        children: [
          CustomTinyCircleAvatar(
            baseColor: AppColor.textColor.withOpacity(0.1), // Fixed withOpacity
            iconPadding: const EdgeInsets.all(5),
            imageUrl: "assets/icons/notification.svg",
            isAsset: true,
            bgColor: const Color(0x1AFFFFFF),
          ),
          SizedBox(width: Responsive.w(2)),
          CustomTinyCircleAvatar(
            baseColor: AppColor.textColor.withOpacity(0.1), // Fixed withOpacity
            iconPadding: const EdgeInsets.all(5),
            imageUrl: "assets/icons/notification.svg",
            isAsset: true,
            bgColor: const Color(0x1AFFFFFF),
          ),
        ],
      ),
    ],
  );
}

Widget customCard() {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(18),
      color: AppColor.darkGray,
    ),
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(text: "Total Votes"),
          SizedBox(height: Responsive.h(1)),
          TextWidget(text: "3.2k"),
        ],
      ),
    ),
  );
}
