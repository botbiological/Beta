import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provide/res/components/app_color.dart';
import 'package:provide/res/components/auth_button.dart';
import 'package:provide/utils/routes/responsive.dart';
import 'package:provide/utils/routes/routes_name.dart';
import 'package:provide/utils/routes/utils.dart';
import 'package:provide/view/auth/role_wrapper.dart';
import 'package:provide/widgets/custom_checkbox.dart';
import 'package:provide/widgets/custom_textfield.dart';
import 'package:provide/viewmodel/login_provider.dart';
import 'package:provider/provider.dart';

class Loginview extends StatefulWidget {
  const Loginview({super.key});

  @override
  State<Loginview> createState() => _LoginviewState();
}

class _LoginviewState extends State<Loginview> {
  FocusNode emailFoucsNode = FocusNode();
  FocusNode passwordFoucsNode = FocusNode();
  FocusNode sumbitFoucsNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Load saved credentials if "Remember Me" was checked
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final loginProvider = Provider.of<LoginProvider>(context, listen: false);
      loginProvider.loadSavedCredentials();
    });
  }

  @override
  void dispose() {
    super.dispose();
    passwordFoucsNode.dispose();
    emailFoucsNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Initialize responsive class
    Responsive.init(context);
    // final authViewmodel = Provider.of<AuthViewmodel>(context);
    final loginProvider = Provider.of<LoginProvider>(context);

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
                  "Welcome Back!",
                  style: TextStyle(
                    color: AppColor.textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: Responsive.sp(25),
                  ),
                ),
                SizedBox(height: Responsive.h(1)),
                Text(
                  "Log in to explore about our app",
                  style: TextStyle(
                    color: AppColor.textColor,
                    fontWeight: FontWeight.normal,
                    fontSize: Responsive.sp(10.5),
                  ),
                ),
                SizedBox(height: Responsive.h(3)),
                CustomTextField(
                  controller: loginProvider.emailController,
                  focusNode: emailFoucsNode,
                  nextFocusNode: passwordFoucsNode,
                  hintText: 'Email Address',
                  iconPath: 'assets/icons/mail.svg',
                  keyboardType: TextInputType.emailAddress,
                ),
                if (loginProvider.emailError != null)
                  Padding(
                    padding: EdgeInsets.only(top: Responsive.h(1)),
                    child: Text(
                      loginProvider.emailError!,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: Responsive.sp(10),
                      ),
                    ),
                  ),
                SizedBox(height: Responsive.h(3)),
                // CustomTextField(
                //   controller: loginProvider.passwordController,
                //   focusNode: passwordFoucsNode,
                //   hintText: 'Passwor',
                //   iconPath: 'assets/icons/lock_password.svg',
                //   obscureText: loginProvider.obscurePassword,

                // ),
                CustomTextField(
                  controller: loginProvider.passwordController,
                  focusNode: passwordFoucsNode,
                  hintText: 'Password',
                  iconPath: 'assets/icons/lock_password.svg',
                  obscureText: loginProvider.obscurePassword,
                  isPasswordField: true,
                  onToggleVisibility: loginProvider.togglePasswordVisibility,
                ),
                if (loginProvider.passwordError != null)
                  Padding(
                    padding: EdgeInsets.only(top: Responsive.h(1)),
                    child: Text(
                      loginProvider.passwordError!,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: Responsive.sp(10),
                      ),
                    ),
                  ),

                SizedBox(height: Responsive.h(2)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      spacing: 10,
                      children: [
                        CustomCheckbox(
                          value: loginProvider.rememberMe,
                          onChanged: (newValue) {
                            loginProvider.toggleRememberMe(newValue);
                          },
                        ),
                        Text(
                          "Remember Me",
                          style: TextStyle(
                            color: AppColor.textColor,
                            fontWeight: FontWeight.bold,
                            fontSize: Responsive.sp(10),
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        _showForgotPasswordBottomSheet(context);
                      },
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                          color: AppColor.textColor,
                          fontWeight: FontWeight.bold,
                          fontSize: Responsive.sp(10),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: Responsive.h(4)),
                // AuthButton(
                //   suffixIcon: 'assets/icons/forward.svg',
                //   buttonText: "Login",
                //   loading: loginProvider.isLoading,
                //   onPress: () async {
                //     bool success = await loginProvider.login();
                //     if (success) {
                //       // Navigate to home based on user role
                //       loginProvider.clearForm();
                //       Navigator.pushReplacementNamed(
                //         context,
                //         RoutesName.home,
                //       );
                //     } else if (loginProvider.generalError != null) {
                //       Utils.tosatMassage(loginProvider.generalError!);
                //     }
                //   },
                // ),
                AuthButton(
                  suffixIcon: 'assets/icons/forward.svg',
                  buttonText: "Login",
                  loading: loginProvider.isLoading,
                  onPress: () async {
                    bool success = await loginProvider.login();

                    if (success) {
                      loginProvider.clearForm();

                      // Reload RoleWrapper after login
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const RoleWrapper()),
                      );
                    } else if (loginProvider.generalError != null) {
                      Utils.tosatMassage(loginProvider.generalError!);
                    }
                  },
                ),

                if (loginProvider.generalError != null)
                  Padding(
                    padding: EdgeInsets.only(top: Responsive.h(1)),
                    child: Text(
                      loginProvider.generalError!,
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
                            text: "Create an account",
                            style: TextStyle(
                              color: AppColor.textColor,
                              fontSize: Responsive.sp(12),
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushReplacementNamed(
                                  context,
                                  RoutesName.signup,
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

  Widget _buildSocialButton(String iconPath, String text) {
    return Container(
      width: double.infinity,
      height: Responsive.h(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Responsive.w(5.5)),
        color: AppColor.textColor.withValues(alpha: 0.08),
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

  void _showForgotPasswordBottomSheet(BuildContext context) {
    final TextEditingController emailResetController = TextEditingController();
    final TextEditingController otpController = TextEditingController();
    final FocusNode emailResetFocusNode = FocusNode();
    final FocusNode otpFocusNode = FocusNode();
    bool showOtpField = false;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: EdgeInsets.only(
                top: Responsive.h(3),
                left: Responsive.w(5),
                right: Responsive.w(5),
                bottom:
                    MediaQuery.of(context).viewInsets.bottom + Responsive.h(3),
              ),
              decoration: BoxDecoration(
                color: AppColor.primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Responsive.w(6)),
                  topRight: Radius.circular(Responsive.w(6)),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Handle bar
                  Center(
                    child: Container(
                      width: Responsive.w(12),
                      height: Responsive.h(0.5),
                      decoration: BoxDecoration(
                        color: Colors.grey[600],
                        borderRadius: BorderRadius.circular(Responsive.w(1)),
                      ),
                    ),
                  ),
                  SizedBox(height: Responsive.h(3)),

                  // Title
                  Text(
                    showOtpField ? "Enter OTP" : "Forgot Password?",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: Responsive.sp(20),
                    ),
                  ),
                  SizedBox(height: Responsive.h(1)),

                  // Subtitle
                  Text(
                    showOtpField
                        ? "Enter the 6-digit code sent to your email"
                        : "Enter your email address and we'll send you a reset link",
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.7),
                      fontSize: Responsive.sp(12),
                    ),
                  ),
                  SizedBox(height: Responsive.h(3)),

                  // Email field (always visible)
                  if (!showOtpField) ...[
                    CustomTextField(
                      controller: emailResetController,
                      focusNode: emailResetFocusNode,
                      hintText: 'Email Address',
                      iconPath: 'assets/icons/mail.svg',
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ],

                  // OTP field (visible after email submission)
                  if (showOtpField) ...[
                    CustomTextField(
                      controller: otpController,
                      focusNode: otpFocusNode,
                      hintText: 'Enter 6-digit OTP',
                      iconPath: 'assets/icons/lock_password.svg',
                      keyboardType: TextInputType.number,
                    ),
                  ],

                  SizedBox(height: Responsive.h(3)),

                  // Submit button
                  AuthButton(
                    suffixIcon: 'assets/icons/forward.svg',
                    buttonText: showOtpField ? "Verify OTP" : "Send OTP",
                    loading: false,
                    onPress: () {
                      if (!showOtpField) {
                        // First step: Send OTP
                        if (emailResetController.text.isEmpty) {
                          Utils.tosatMassage("Please enter your email");
                        } else {
                          setModalState(() {
                            showOtpField = true;
                          });
                          Utils.tosatMassage(
                            "OTP sent to ${emailResetController.text}",
                          );
                          if (kDebugMode) {
                            print("OTP sent to: ${emailResetController.text}");
                          }
                        }
                      } else {
                        // Second step: Verify OTP
                        if (otpController.text.isEmpty) {
                          Utils.tosatMassage("Please enter the OTP");
                        } else if (otpController.text.length != 6) {
                          Utils.tosatMassage(
                            "Please enter a valid 6-digit OTP",
                          );
                        } else {
                          Navigator.pop(context);
                          Utils.tosatMassage(
                            "Password reset successful! Check your email for new password",
                          );
                          if (kDebugMode) {
                            print("OTP verified: ${otpController.text}");
                          }
                        }
                      }
                    },
                  ),

                  // Back button (when on OTP step)
                  if (showOtpField) ...[
                    SizedBox(height: Responsive.h(2)),
                    TextButton(
                      onPressed: () {
                        setModalState(() {
                          showOtpField = false;
                          otpController.clear();
                        });
                      },
                      child: Text(
                        "Back to Email",
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.7),
                          fontSize: Responsive.sp(12),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            );
          },
        );
      },
    ).then((_) {
      // Cleanup when bottom sheet is closed
      emailResetController.dispose();
      otpController.dispose();
      emailResetFocusNode.dispose();
      otpFocusNode.dispose();
    });
  }
}
