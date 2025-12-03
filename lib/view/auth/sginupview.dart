import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provide/res/components/app_color.dart';
import 'package:provide/res/components/auth_button.dart';
import 'package:provide/utils/routes/responsive.dart';
import 'package:provide/utils/routes/routes_name.dart';
import 'package:provide/utils/routes/utils.dart';
import 'package:provide/widgets/custom_checkbox.dart';
import 'package:provide/widgets/custom_textfield.dart';
import 'package:provide/viewmodel/signup_provider.dart';
import 'package:provider/provider.dart';

class Signupview extends StatefulWidget {
  const Signupview({super.key});

  @override
  State<Signupview> createState() => _LoginviewState();
}

class _LoginviewState extends State<Signupview> {
  FocusNode emailFoucsNode = FocusNode();
  FocusNode passwordFoucsNode = FocusNode();
  FocusNode sumbitFoucsNode = FocusNode();
  FocusNode fullNameNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    passwordFoucsNode.dispose();
    emailFoucsNode.dispose();
    fullNameNode.dispose();
    sumbitFoucsNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Initialize responsive class
    Responsive.init(context);
    final signupProvider = Provider.of<SignupProvider>(context);

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
                  style: TextStyle(
                    color: AppColor.textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: Responsive.sp(25),
                  ),
                ),
                SizedBox(height: Responsive.h(1)),
                Text(
                  "Create your account to explore about our app",
                  style: TextStyle(
                    color: AppColor.textColor,
                    fontWeight: FontWeight.normal,
                    fontSize: Responsive.sp(10.5),
                  ),
                ),
                SizedBox(height: Responsive.h(3)),
                CustomTextField(
                  controller: signupProvider.nameController,
                  focusNode: fullNameNode,
                  nextFocusNode: emailFoucsNode,
                  hintText: 'Full Name',
                  iconPath: 'assets/icons/user.svg',
                ),
                if (signupProvider.nameError != null)
                  Padding(
                    padding: EdgeInsets.only(top: Responsive.h(1)),
                    child: Text(
                      signupProvider.nameError!,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: Responsive.sp(10),
                      ),
                    ),
                  ),
                SizedBox(height: Responsive.h(3)),
                CustomTextField(
                  controller: signupProvider.emailController,
                  focusNode: emailFoucsNode,
                  nextFocusNode: passwordFoucsNode,
                  hintText: 'Email Address',
                  iconPath: 'assets/icons/mail.svg',
                  keyboardType: TextInputType.emailAddress,
                ),
                if (signupProvider.emailError != null)
                  Padding(
                    padding: EdgeInsets.only(top: Responsive.h(1)),
                    child: Text(
                      signupProvider.emailError!,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: Responsive.sp(10),
                      ),
                    ),
                  ),
                SizedBox(height: Responsive.h(3)),
                CustomTextField(
                  controller: signupProvider.passwordController,
                  focusNode: passwordFoucsNode,
                  hintText: 'Password',
                  iconPath: 'assets/icons/lock_password.svg',
                  obscureText: signupProvider.obscurePassword,
                  isPasswordField: true,
                  onToggleVisibility: signupProvider.togglePasswordVisibility,
                ),
                if (signupProvider.passwordError != null)
                  Padding(
                    padding: EdgeInsets.only(top: Responsive.h(1)),
                    child: Text(
                      signupProvider.passwordError!,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: Responsive.sp(10),
                      ),
                    ),
                  ),

                SizedBox(height: Responsive.h(2)),
                Row(
                  children: [
                    CustomCheckbox(
                      value: signupProvider.acceptTerms,
                      onChanged: (newValue) {
                        signupProvider.toggleTermsAcceptance(newValue);
                      },
                    ),
                    SizedBox(width: Responsive.w(2)),
                    Expanded(
                      child: Text(
                        "I agree to the Terms and Conditions",
                        style: TextStyle(
                          color: AppColor.textColor,
                          fontSize: Responsive.sp(10),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: Responsive.h(4)),
                AuthButton(
                  buttonText: "Signup",
                  loading: signupProvider.isLoading,
                  suffixIcon: 'assets/icons/forward.svg',
                  onPress: () {
                    // Validate form before navigating
                    if (signupProvider.nameController.text.trim().isEmpty) {
                      Utils.tosatMassage("Please enter your full name");
                      return;
                    }
                    if (signupProvider.emailController.text.trim().isEmpty) {
                      Utils.tosatMassage("Please enter your email address");
                      return;
                    }
                    if (signupProvider.passwordController.text.isEmpty) {
                      Utils.tosatMassage("Please enter your password");
                      return;
                    }
                    if (signupProvider.passwordController.text.length < 8) {
                      Utils.tosatMassage(
                          "Password must be at least 8 characters");
                      return;
                    }
                    if (!signupProvider.acceptTerms) {
                      Utils.tosatMassage(
                          "Please accept the terms and conditions");
                      return;
                    }
                    // Navigate to role selection, will create account after role is selected
                    Navigator.pushNamed(context, RoutesName.roleSelection);
                  },
                ),
                if (signupProvider.generalError != null)
                  Padding(
                    padding: EdgeInsets.only(top: Responsive.h(1)),
                    child: Text(
                      signupProvider.generalError!,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: Responsive.sp(10),
                      ),
                    ),
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
                        style: TextStyle(
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
                        text: "Already have an account? ",
                        style: TextStyle(
                          color: AppColor.textColor,
                          fontSize: Responsive.sp(12),
                        ),
                        children: [
                          TextSpan(
                            text: "Login",
                            style: TextStyle(
                              color: AppColor.textColor,
                              fontSize: Responsive.sp(12),
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushReplacementNamed(
                                  context,
                                  RoutesName.login,
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
