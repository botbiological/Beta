import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provide/res/components/app_color.dart';
import 'package:provide/utils/routes/responsive.dart';
import 'package:provide/widgets/text_widget.dart';

class UploadTrackViewDj extends StatefulWidget {
  const UploadTrackViewDj({super.key});

  @override
  State<UploadTrackViewDj> createState() => _UploadTrackViewDjState();
}

class _UploadTrackViewDjState extends State<UploadTrackViewDj> {
  String? selectedValue;
  final List<String> items = ['Option 1', 'Option 2', 'Option 3', 'Option 4'];
  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: SvgPicture.asset("assets/icons/Arrowback.svg"),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage("assets/images/Frame 1410120910.png"),
                    ),
                  ],
                ),

                TextField(
                  style: TextStyle(
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
                TextField(
                  style: TextStyle(
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

                Row(
                  spacing: Responsive.w(2),
                  children: [
                    Expanded(
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
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(28),
                          color: AppColor.seconadryColor,
                          border: BoxBorder.all(color: AppColor.seconadryColor),
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
