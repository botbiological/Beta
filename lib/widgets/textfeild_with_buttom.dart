import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provide/res/components/app_color.dart';
import 'package:provide/utils/routes/responsive.dart';
import 'package:provide/widgets/text_widget.dart';

class TextfeildWithButtom extends StatelessWidget {
  const TextfeildWithButtom({super.key});

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            style: GoogleFonts.onest(
              color: AppColor.textColor,
              fontWeight: FontWeight.w400,
              fontSize: Responsive.textScaleFactor * 14,
            ),
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset("assets/icons/search.svg"),
              ),
              hint: TextWidget(text: "Search here...."),
              // prefixIcon: Row(children: [SvgPicture.asset("assets/icons/search.svg"),TextWidget(text: "Search here...")],),
              fillColor: AppColor.darkGray,
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColor.seconadryColor,
            borderRadius: BorderRadius.circular(28),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextWidget(text: "Strem"),
          ),
        ),
      ],
    );
  }
}
