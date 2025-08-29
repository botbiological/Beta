import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provide/utils/routes/responsive.dart';

class ClockWidget extends StatelessWidget {
  const ClockWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.w(4),
        vertical: Responsive.h(1),
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(18),
      ),

      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "12",
                style: GoogleFonts.onest(
                  color: Colors.white,
                  fontSize: Responsive.textScaleFactor * 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "DAYS",
                style: GoogleFonts.onest(
                  color: Colors.white,
                  fontSize: Responsive.textScaleFactor * 10,
                ),
              ),
            ],
          ),
          const Spacer(), // 👈 pushes next column away
          Text(
            ":",
            style: GoogleFonts.onest(
              color: Colors.white,
              fontSize: Responsive.textScaleFactor * 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "50",
                style: GoogleFonts.onest(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: Responsive.textScaleFactor * 25,
                ),
              ),
              Text(
                "MIN",
                style: GoogleFonts.onest(
                  color: Colors.white,
                  fontSize: Responsive.textScaleFactor * 10,
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            ":",
            style: GoogleFonts.onest(
              color: Colors.white,
              fontSize: Responsive.textScaleFactor * 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              Text(
                "12",
                style: GoogleFonts.onest(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: Responsive.textScaleFactor * 25,
                ),
              ),
              Text(
                "SEC",
                style: GoogleFonts.onest(
                  color: Colors.white,
                  fontSize: Responsive.textScaleFactor * 10,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
