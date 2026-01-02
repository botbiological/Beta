import 'package:flutter/material.dart';
import 'package:provide/res/components/app_color.dart';
import 'package:provide/res/components/auth_button.dart';
import 'package:provide/utils/routes/responsive.dart';
import 'package:provide/view/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> plans = [
      {
        "title": "Free Plan",
        "price": "\$0.00",
        "features": [
          "Upload 10+ tracks/month",
          "Appear in Featured Charts",
          "Vote weight: 2x",
          "Direct Chat Access (Mentions allowed)",
          "Analytics Dashboard",
          "Monetization Tools (Submit to Earn)",
        ],
      },
      {
        "title": "Pro Plan",
        "price": "\$9.99",
        "features": [
          "Unlimited uploads",
          "Priority charting",
          "Vote weight: 5x",
          "Unlimited Chat Access",
          "Advanced Analytics",
          "Full Monetization Tools",
        ],
      },
      {
        "title": "Premium Plan",
        "price": "\$19.99",
        "features": [
          "All Pro features",
          "Artist Support",
          "Custom Branding",
          "Personalized Coaching",
        ],
      },
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.w(5),
            vertical: Responsive.h(8),
          ),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Choose Plan",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 30),

              /// Main scrollable content
              Expanded(
                child: ListView(
                  children: [
                    SizedBox(
                      height: 400,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: plans.length,
                        itemBuilder: (context, index) {
                          final plan = plans[index];
                          return Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: _buildPlanCard(
                              title: plan['title'],
                              price: plan['price'],
                              features: List<String>.from(plan['features']),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              /// Skip button pinned at bottom
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    var saveRole;
                    final prefs = await SharedPreferences.getInstance();
                    saveRole = prefs.getString('user_role');
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) {
                    //       return MainPage(role: saveRole);
                    //     },
                    //   ),
                    // );
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.seconadryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Skip",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlanCard({
    required String title,
    required String price,
    required List<String> features,
  }) {
    return Container(
      width: 300, // fixed width for horizontal scroll cards
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.diamond, color: Colors.white, size: 30),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  price,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 4),
                const Text(
                  "/ Month",
                  style: TextStyle(fontSize: 14, color: Colors.white70),
                ),
              ],
            ),
            const Divider(color: Colors.white30, height: 30),
            Expanded(
              child: ListView.builder(
                itemCount: features.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.check, size: 18, color: Colors.white),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            features[index],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            AuthButton(
              buttonText: 'Choose Plan',
              loading: false,
              onPress: () {},
            ),
          ],
        ),
      ),
    );
  }
}
