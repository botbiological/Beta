import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provide/res/components/app_color.dart';
import 'package:provide/utils/routes/responsive.dart';
import 'package:provide/widgets/clock_widget.dart';
import 'package:provide/widgets/custom_circle_avatar.dart';
import 'package:provide/widgets/custom_searchfield.dart';

class CompetitionsView extends StatelessWidget {
  CompetitionsView({super.key});
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: SafeArea(
        child: ListView(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Competitions',
                      style: GoogleFonts.onest(
                        color: Colors.white,
                        fontSize: Responsive.textScaleFactor * 20,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.30,
                      ),
                    ),
                    Row(
                      children: [
                        CustomTinyCircleAvatar(
                          baseColor: AppColor.textColor.withValues(alpha: 0.1),

                          iconPadding: EdgeInsets.all(5),
                          imageUrl: "assets/icons/notification.svg",
                          isAsset: true,
                          bgColor: Color(0x1AFFFFFF),
                        ),

                        CustomTinyCircleAvatar(
                          baseColor: AppColor.textColor.withValues(alpha: 0.1),
                          bgColor: Color(0x1AFFFFFF),
                          imageUrl: "assets/icons/profile.svg",
                          isAsset: true,
                        ),
                      ],
                    ),
                  ],
                ),
                CustomSearchField(controller: _searchController),
                SizedBox(height: Responsive.h(1)),
                ClockWidget(),
                Row(
                  children: [
                    Text(
                      'Jaxson',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.onest(
                        color: Colors.white,
                        fontSize: Responsive.textScaleFactor * 12,
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.30,
                      ),
                    ),
                  ],
                ),

                Row(
                  spacing: Responsive.w(2),
                  children: [
                    Customcard(titile: 'Rank', valuse: '#1'),
                    Customcard(titile: 'Total Votes', valuse: '2.3K'),
                    Customcard(titile: 'Streams', valuse: '2.8K'),
                  ],
                ),

                ListView.builder(
                  itemCount: 12,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: ((context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: Responsive.h(1),
                      ), // Add vertical spacing
                      child: VoteCard(),
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
}

class VoteCard extends StatelessWidget {
  const VoteCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Color(0x1AFFFFFF),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.asset("assets/images/Component 1.png"),
            // SvgPicture.asset("assets/images/Component 1.png"),
            SizedBox(width: Responsive.w(2)),
            Column(
              spacing: Responsive.h(0.2),
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'No Sleep Tonight',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'Onest',
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.30,
                      ),
                    ),
                  ],
                ),
                Text(
                  'By Young Blaze',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w400,
                    letterSpacing: -0.30,
                  ),
                ),
                Row(
                  children: [
                    SvgPicture.asset("assets/icons/headset.svg"),
                    SizedBox(width: Responsive.w(2)),

                    Text(
                      '41 ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.30,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Spacer(),
            Column(
              spacing: Responsive.h(0.2),
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Text(
                      'VOTE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.30,
                      ),
                    ),
                    SizedBox(width: Responsive.w(5)),
                    SvgPicture.asset("assets/icons/Vector.svg"),
                  ],
                ),
                Row(
                  spacing: 4,
                  children: [
                    CircleAvatar(radius: Responsive.sp(14)),
                    Text(
                      'VS',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.30,
                      ),
                    ),
                    CircleAvatar(radius: Responsive.sp(14)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Customcard extends StatelessWidget {
  final String titile;
  final String valuse;
  const Customcard({super.key, required this.titile, required this.valuse});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: AppColor.textColor.withValues(alpha: 0.10),
        ),
        child: Column(
          children: [
            Text(
              titile,
              style: GoogleFonts.onest(
                color: Colors.white,
                fontSize: Responsive.textScaleFactor * 12,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.30,
              ),
            ),
            Text(
              valuse,
              style: GoogleFonts.onest(
                color: Colors.white,
                fontSize: Responsive.textScaleFactor * 20,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
