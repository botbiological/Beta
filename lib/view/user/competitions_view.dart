import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provide/res/components/app_color.dart';
import 'package:provide/utils/routes/responsive.dart';
import 'package:provide/view/user/profile_view.dart';
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
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.w(5),
                vertical: Responsive.h(4),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ---- Header Row ----
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Competitions',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Responsive.textScaleFactor * 20,
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.30,
                        ),
                      ),
                      Row(
                        children: [
                          // Asset image
                          CustomTinyCircleAvatar(
                            baseColor: AppColor.textColor.withValues(
                              alpha: 0.1,
                            ),
                            iconPadding: EdgeInsets.all(20),

                            imageUrl: "assets/icons/notification.svg",
                            isAsset: true,
                            bgColor: Color(0x1AFFFFFF),
                          ),
                          SizedBox(width: Responsive.w(2)),
                          CustomTinyCircleAvatar(
                            baseColor: AppColor.textColor.withValues(
                              alpha: 0.1,
                            ),
                            bgColor: Color(0x1AFFFFFF),
                            imageUrl: "assets/icons/profile.png",
                            isAsset: false,

                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      ProfileView(), // 👈 destination screen
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  CustomSearchField(controller: _searchController),
                  SizedBox(height: Responsive.h(3)),
                  ClockWidget(),
                  SizedBox(height: Responsive.h(5)),
                  // ---- Tab Section ----
                  DefaultTabController(
                    length: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ---- Bordered TabBar ----
                        TabBar(
                          indicator: const UnderlineTabIndicator(
                            borderSide: BorderSide(
                              color: AppColor.seconadryColor, // underline color
                              width: 4, // thickness
                            ),
                            // optional: control width
                          ),
                          indicatorSize: TabBarIndicatorSize.tab,
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                          unselectedLabelStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.white70,
                          dividerColor: Color(0x33FFFFFF),
                          tabs: const [
                            Tab(text: "Jaxson"),
                            Tab(text: "Justin"),
                          ],
                        ),

                        // ---- TabBarView ----
                        SizedBox(
                          height: Responsive.h(
                            90,
                          ), // allow scrollable tab content
                          child: TabBarView(
                            children: [
                              // ✅ Overview Tab Content
                              SingleChildScrollView(
                                child: Column(
                                  children: [
                                    SizedBox(height: Responsive.h(2)),
                                    Row(
                                      spacing: Responsive.w(2),
                                      children: const [
                                        Customcard(
                                          titile: 'Rank',
                                          valuse: '#1',
                                        ),
                                        Customcard(
                                          titile: 'Total Votes',
                                          valuse: '2.3K',
                                        ),
                                        Customcard(
                                          titile: 'Streams',
                                          valuse: '2.8K',
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: Responsive.h(2)),
                                    ListView.builder(
                                      itemCount: 12,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: Responsive.h(1),
                                          ),
                                          child: const VoteCard(),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),

                              SingleChildScrollView(
                                child: Column(
                                  children: [
                                    SizedBox(height: Responsive.h(2)),
                                    Row(
                                      spacing: Responsive.w(2),
                                      children: const [
                                        Customcard(
                                          titile: 'Rank',
                                          valuse: '#1',
                                        ),
                                        Customcard(
                                          titile: 'Total Votes',
                                          valuse: '2.3K',
                                        ),
                                        Customcard(
                                          titile: 'Streams',
                                          valuse: '2.8K',
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: Responsive.h(2)),
                                    ListView.builder(
                                      itemCount: 12,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: Responsive.h(1),
                                          ),
                                          child: const VoteCard(),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
                    SvgPicture.asset(
                      "assets/icons/headset.svg",
                      // Add error handling for corrupted SVG
                      placeholderBuilder: (context) =>
                          Icon(Icons.headset, color: Colors.white, size: 16),
                    ),
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
                  ],
                ),
                SizedBox(width: Responsive.h(5)),
                Row(
                  spacing: 4,
                  children: [
                    CircleAvatar(
                      radius: Responsive.sp(14),
                      child: Image.asset(
                        "assets/images/firstvote.png",
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                      ),
                    ),
                    SizedBox(width: Responsive.w(2)),
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
                    SizedBox(width: Responsive.w(2)),
                    CircleAvatar(
                      radius: Responsive.sp(14),
                      child: Image.asset(
                        "assets/images/secondvote.png",
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                      ),
                    ),
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
              style: TextStyle(
                color: Colors.white,
                fontSize: Responsive.textScaleFactor * 12,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.30,
              ),
            ),
            Text(
              valuse,
              style: TextStyle(
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
