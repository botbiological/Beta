import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provide/res/components/app_color.dart';
import 'package:provide/utils/routes/responsive.dart';
import 'package:provide/widgets/text_widget.dart';

class DjProfileSetupView extends StatefulWidget {
  const DjProfileSetupView({super.key});

  @override
  State<DjProfileSetupView> createState() => _DjProfileSetupViewState();
}

class _DjProfileSetupViewState extends State<DjProfileSetupView> {
  String? selectedValue;
  final List<String> items = ['Option 1', 'Option 2', 'Option 3', 'Option 4'];
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
              DropdownButtonFormField<String>(
                dropdownColor: AppColor.darkGray,
                focusColor: AppColor.whiteColor.withValues(alpha: 0.10),
                value: selectedValue,
                iconEnabledColor: AppColor.whiteColor,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedValue = newValue;
                  });
                },
                items: items.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: TextWidget(text: value),
                  );
                }).toList(),
                decoration: InputDecoration(
                  fillColor: AppColor.darkGray,
                  filled: true,
                  labelText: 'Pick Genre',
                  labelStyle: GoogleFonts.onest(
                    fontSize: Responsive.textScaleFactor * 14,
                    height: 1.0,
                    color: AppColor.textColor,
                    fontWeight: FontWeight.w400,
                  ),
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
                  label: TextWidget(
                    text: "Genre Tags",
                    fontWeight: FontWeight.w400,
                  ),
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
      ),
    );
  }
}
