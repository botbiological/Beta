import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provide/res/components/app_color.dart';
import 'package:provide/res/components/auth_button.dart';
import 'package:provide/utils/routes/responsive.dart';
import 'package:provide/utils/routes/routes_name.dart';
import 'package:provide/utils/routes/utils.dart';
import 'package:provide/widgets/custom_checkbox.dart';
import 'package:provide/widgets/custom_textfield.dart';
import 'package:provide/viewmodel/auth_viewmodel.dart';
import 'package:provider/provider.dart';

class Signupview extends StatefulWidget {
  const Signupview({super.key});

  @override
  State<Signupview> createState() => _LoginviewState();
}

class _LoginviewState extends State<Signupview> {
  final ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  FocusNode emailFoucsNode = FocusNode();
  FocusNode passwordFoucsNode = FocusNode();
  FocusNode sumbitFoucsNode = FocusNode();
  FocusNode fullNameNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordFoucsNode.dispose();
    emailFoucsNode.dispose();
    _obsecurePassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Initialize responsive class
    Responsive.init(context);
    final authViewmodel = Provider.of<AuthViewmodel>(context);

    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.w(5), // 5% of screen width
            vertical: Responsive.h(2), // 2% of screen height
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Responsive.h(2)), // 2% of screen height
                Image.asset('assets/icons/imic_icon.png'),
                SizedBox(height: Responsive.h(2)),
                Text(
                  "Create an Account",
                  style: GoogleFonts.rethinkSans(
                    color: AppColor.textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: Responsive.sp(25), // Responsive font size
                  ),
                ),
                SizedBox(height: Responsive.h(1)),
                Text(
                  "Create your account to explore about our app",
                  style: GoogleFonts.rethinkSans(
                    color: AppColor.textColor,
                    fontWeight: FontWeight.normal,
                    fontSize: Responsive.sp(10.5),
                  ),
                ),
                SizedBox(height: Responsive.h(3)),
                CustomTextField(
                  controller: fullNameController,
                  focusNode: fullNameNode,
                  hintText: 'Full Name',
                  iconPath: 'assets/icons/user.svg',
                ),
                SizedBox(height: Responsive.h(3)),
                CustomTextField(
                  controller: emailController,
                  focusNode: emailFoucsNode,
                  hintText: 'Email Address',
                  iconPath: 'assets/icons/mail.svg',
                ),
                SizedBox(height: Responsive.h(3)),
                CustomTextField(
                  controller: passwordController,
                  focusNode: passwordFoucsNode,
                  hintText: 'Password',
                  iconPath: 'assets/icons/lock_password.svg',
                ),

                SizedBox(height: Responsive.h(2)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomCheckbox(
                      value: authViewmodel.isChecked ?? false,
                      onChanged: (newValue) {
                        setState(() {
                          authViewmodel.isChecked = newValue;
                        });
                      },
                    ),
                    Text(
                      "Forgot Password?",
                      style: GoogleFonts.dmSans(
                        color: AppColor.textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: Responsive.sp(10),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: Responsive.h(4)),
                AuthButton(
                  buttonText: "Signup",
                  loading: false,
                  suffixIcon: 'assets/icons/forward.svg',
                  //  authViewmodel.loading,
                  onPress: () {
                    if (emailController.text.isEmpty) {
                      Utils.tosatMassage("Please Enter Email First");
                    } else if (passwordController.text.isEmpty) {
                      Utils.tosatMassage("Please Enter Password First");
                    } else if (passwordController.text.length < 8) {
                      Utils.tosatMassage(
                        "Please Enter 8 digits",
                        // context,
                      );
                    } else {
                      Navigator.pushNamed(context, RoutesName.roleSelection);
                    }
                  },
                ),

                SizedBox(height: Responsive.h(6)),
                Row(
                  children: [
                    Expanded(child: Divider(color: AppColor.textColor)),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Responsive.w(3),
                      ),
                      child: Text(
                        "OR",
                        style: GoogleFonts.dmSans(
                          color: AppColor.textColor,
                          fontWeight: FontWeight.bold,
                          fontSize: Responsive.textScaleFactor * 10,
                        ),
                      ),
                    ),
                    Expanded(child: Divider(color: AppColor.textColor)),
                  ],
                ),
                SizedBox(height: Responsive.h(6)),

                _buildSocialButton(
                  'assets/icons/google.svg',
                  'Continue with Google',
                ),
                SizedBox(height: Responsive.h(2)),

                _buildSocialButton(
                  "assets/icons/facebook.svg",
                  'Continue With Facebook',
                  Color(0xff178FF2),
                ),
                SizedBox(height: Responsive.h(2)),
                _buildSocialButton(
                  "assets/icons/apple.svg",
                  'Continue With Apple',
                ),

                SizedBox(height: Responsive.h(2)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                        text: "New here? ",
                        style: TextStyle(
                          color: AppColor.textColor,
                          fontSize: Responsive.sp(12),
                        ),
                        children: [
                          TextSpan(
                            text: "Signup",
                            style: TextStyle(
                              color: AppColor.textColor,
                              fontSize: Responsive.sp(12),
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushNamed(
                                  context,
                                  RoutesName.roleSelection,
                                );
                              },
                          ),
                        ],
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

  Widget _buildSocialButton(String iconPath, String text, [Color? bgColor]) {
    return Container(
      width: double.infinity,
      height: Responsive.h(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Responsive.w(5.5)),
        color: bgColor ?? AppColor.textColor.withValues(alpha: 0.08),
        border: Border.all(color: Colors.white, width: 0.4),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: Responsive.w(20)),
          SvgPicture.asset(iconPath, height: Responsive.h(3)),
          SizedBox(width: Responsive.w(3)),
          Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: Responsive.sp(12)),
          ),
        ],
      ),
    );
  }
}
