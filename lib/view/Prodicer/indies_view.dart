import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provide/res/components/app_color.dart';
import 'package:provide/utils/routes/responsive.dart';
import 'package:provide/widgets/custom_circle_avatar.dart';
import 'package:provide/widgets/text_widget.dart';

class ProducerInsidesView extends StatelessWidget {
  const ProducerInsidesView({super.key});

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
              _buildHeader(),
              deatilsCard("Total Streams", "12,540"),
              SizedBox(height: Responsive.h(1)),
              deatilsCard("Total Likes", "2134"),
              SizedBox(height: Responsive.h(1)),
              deatilsCard("Follower Growth", "342"),
              Row(children: [Expanded(child: Divider())]),
              TextWidget(text: "Per Track Insides", fontSize: 16),

              SizedBox(
                height: 320,
                child: PageView.builder(
                  itemCount: 5,
                  itemBuilder: ((context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: AppColor.whiteColor.withValues(alpha: 0.10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            spacing: 2,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: Image(
                                  fit: BoxFit.fill,
                                  image: AssetImage(
                                    "assets/images/Component 1 (4).png",
                                  ),
                                ),
                              ),
                              SizedBox(height: Responsive.h(0.5)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextWidget(text: "No Sleep Tonight"),
                                  TextWidget(text: "Hip-Hop"),
                                ],
                              ),
                              Row(children: [Expanded(child: Divider())]),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,

                                children: [
                                  TextWidget(text: "Streams"),
                                  TextWidget(text: "33.2k"),
                                ],
                              ),
                              SizedBox(height: Responsive.h(0.5)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,

                                children: [
                                  TextWidget(text: "Votes"),
                                  TextWidget(text: "9,812"),
                                ],
                              ),
                              SizedBox(height: Responsive.h(0.5)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,

                                children: [
                                  TextWidget(text: "Likes"),
                                  TextWidget(text: "12k"),
                                ],
                              ),
                              SizedBox(height: Responsive.h(0.5)),

                              Row(
                                children: [
                                  TextWidget(text: "View Full Analytic"),
                                  SizedBox(width: Responsive.w(1)),
                                  SvgPicture.asset("assets/icons/Arrow.svg"),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildHeader() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      TextWidget(text: "My Tracks", fontSize: 20, fontWeight: FontWeight.w600),
      Row(
        // Using MainAxisAlignment instead of non-existent spacing property
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomTinyCircleAvatar(
            baseColor: AppColor.textColor.withValues(alpha: 0.1),
            iconPadding: const EdgeInsets.all(5),
            imageUrl: "assets/icons/notification.svg",
            isAsset: true,
            bgColor: const Color(0x1AFFFFFF),
          ),
          SizedBox(width: Responsive.w(2)),
          CustomTinyCircleAvatar(
            baseColor: AppColor.textColor.withValues(alpha: 0.1),
            bgColor: const Color(0x1AFFFFFF),
            imageUrl: "assets/icons/profile.svg",
            isAsset: true,
          ),
        ],
      ),
    ],
  );
}

Widget deatilsCard(String title, String text) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      TextWidget(text: title),
      Row(
        children: [
          TextWidget(text: text),
          SizedBox(width: Responsive.w(1)),
          SvgPicture.asset("assets/icons/Arrow.svg"),
        ],
      ),
    ],
  );
}
