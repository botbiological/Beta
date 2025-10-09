import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provide/res/components/app_color.dart';
import 'package:provide/utils/routes/responsive.dart';
import 'package:provide/view/Artist/schedule_view.dart';
import 'package:provide/view/user/my_tracks_view.dart';
import 'package:provide/widgets/text_widget.dart';

class UploadView extends StatefulWidget {
  const UploadView({super.key});

  @override
  State<UploadView> createState() => _UploadViewState();
}

class _UploadViewState extends State<UploadView> {
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SvgPicture.asset("assets/icons/Arrowback.svg"),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage("assets/images/Frame 1410120910.png"),
                    ),
                  ],
                ),
                SizedBox(height: Responsive.h(5)),

                TextField(
                  style: GoogleFonts.dmSans(
                    color: AppColor.whiteColor,
                    fontSize: Responsive.textScaleFactor * 14,
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: InputDecoration(
                    fillColor: AppColor.darkGray,
                    filled: true,
                    hint: TextWidget(text: "Title"),
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
                SizedBox(height: Responsive.h(1)),
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
                    labelStyle: GoogleFonts.dmSans(color: AppColor.textColor),
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
                SizedBox(height: Responsive.h(1)),
                TextField(
                  style: GoogleFonts.dmSans(
                    color: AppColor.whiteColor,
                    fontSize: Responsive.textScaleFactor * 14,
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 4,
                  decoration: InputDecoration(
                    fillColor: AppColor.darkGray,
                    filled: true,
                    hint: TextWidget(text: "Description"),
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
                SizedBox(height: Responsive.h(1)),
                TextField(
                  style: GoogleFonts.dmSans(
                    color: AppColor.whiteColor,
                    fontSize: Responsive.textScaleFactor * 14,
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: InputDecoration(
                    fillColor: AppColor.darkGray,
                    filled: true,
                    hint: TextWidget(text: "Caption (Optional)"),
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
                SizedBox(height: Responsive.h(1)),
                TextField(
                  keyboardType: TextInputType.number,
                  style: GoogleFonts.dmSans(
                    color: AppColor.whiteColor,
                    fontSize: Responsive.textScaleFactor * 14,
                    fontWeight: FontWeight.w400,
                  ),
                  // textInputAction: TextInputAction.emergencyCall,
                  decoration: InputDecoration(
                    fillColor: AppColor.darkGray,
                    filled: true,

                    hint: TextWidget(text: "Enter Amount"),
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
                SizedBox(height: Responsive.h(3)),
                Row(
                  spacing: Responsive.w(2),
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ScheduleScreen(),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(28),
                            color: AppColor.primaryColor,
                            border: BoxBorder.all(color: AppColor.whiteColor),
                          ),
                          child: Padding(
                            padding: Responsive.padding(
                              left: 2,
                              right: 2,
                              top: 1,
                              bottom: 1,
                            ),
                            child: Center(child: TextWidget(text: "Schedule")),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MytracksView(),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(28),
                            color: AppColor.seconadryColor,
                            border: BoxBorder.all(
                              color: AppColor.seconadryColor,
                            ),
                          ),
                          child: Padding(
                            padding: Responsive.padding(
                              left: 2,
                              right: 2,
                              top: 1,
                              bottom: 1,
                            ),
                            child: Center(child: TextWidget(text: "Save")),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
