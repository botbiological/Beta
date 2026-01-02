import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
  bool isPublic = false, isPaid = false;
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
                  style: TextStyle(
                    color: AppColor.whiteColor,
                    fontSize: Responsive.textScaleFactor * 14,
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: InputDecoration(
                    fillColor: AppColor.darkGray,
                    filled: true,
                    hintText: "Title",
                    hintStyle: TextStyle(color: AppColor.textColor),
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
                    labelStyle: TextStyle(color: AppColor.textColor),
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
                  style: TextStyle(
                    color: AppColor.whiteColor,
                    fontSize: Responsive.textScaleFactor * 14,
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 4,
                  decoration: InputDecoration(
                    fillColor: AppColor.darkGray,
                    filled: true,
                    hintText: "Description",
                    hintStyle: TextStyle(color: AppColor.textColor),
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
                  style: TextStyle(
                    color: AppColor.whiteColor,
                    fontSize: Responsive.textScaleFactor * 14,
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: InputDecoration(
                    fillColor: AppColor.darkGray,
                    filled: true,
                    hintText: "Caption (Optional)",
                    hintStyle: TextStyle(color: AppColor.textColor),
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
                  style: TextStyle(
                    color: AppColor.whiteColor,
                    fontSize: Responsive.textScaleFactor * 14,
                    fontWeight: FontWeight.w400,
                  ),
                  // textInputAction: TextInputAction.emergencyCall,
                  decoration: InputDecoration(
                    fillColor: AppColor.darkGray,
                    filled: true,
                    hintText: "Enter Amount",
                    hintStyle: TextStyle(color: AppColor.textColor),
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
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColor.darkGray,
                        borderRadius: BorderRadius.circular(26),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Make this track public",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                          Transform.scale(
                            scale: 0.75, // Reduces the switch size
                            child: Switch(
                              value: isPublic,
                              onChanged: (val) {
                                setState(() => isPublic = val);
                              },
                              thumbColor: WidgetStateProperty.all(Colors.red),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: Responsive.h(1)),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColor.darkGray,
                        borderRadius: BorderRadius.circular(26),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "This track is paid?",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                          Transform.scale(
                            scale: 0.75, // Reduces the switch size
                            child: Switch(
                              value: isPaid,
                              onChanged: (val) {
                                setState(() => isPaid = val);
                              },
                              thumbColor: WidgetStateProperty.all(Colors.red),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
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
                            border: Border.all(color: AppColor.whiteColor),
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
                            border: Border.all(
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
