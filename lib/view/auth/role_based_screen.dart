import 'package:flutter/material.dart';
import 'package:provide/res/components/app_color.dart';
import 'package:provide/res/components/auth_button.dart';
import 'package:provide/utils/routes/responsive.dart';
import 'package:provide/utils/routes/routes_name.dart';
import 'package:provide/widgets/custom_role_based_card.dart';
import 'package:provide/viewmodel/role_selection_provider.dart';
import 'package:provide/viewmodel/signup_provider.dart';
import 'package:provide/viewmodel/login_provider.dart';
import 'package:provide/auth/firebase_auth_manager.dart';
import 'package:provide/utils/routes/utils.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RoleBasedScreen extends StatelessWidget {
  const RoleBasedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Responsive.init(context); // Initialize responsive
    final roleProvider = Provider.of<RoleSelectionProvider>(context);
    final signupProvider = Provider.of<SignupProvider>(context);
    final authManager = FirebaseAuthManager();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff000000),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.w(5),
            vertical: Responsive.h(4),
          ),
          child: Column(
            children: [
              // Scrollable content
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Select your role",
                        style: TextStyle(
                          color: Color(0xffFFFFFF),
                          fontSize: Responsive.sp(24),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: Responsive.h(4)),

                      // Role Cards
                      ...List.generate(roleProvider.roles.length, (index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: Responsive.h(2)),
                          child: CustomRoleOptionTileCard(
                            roleName: roleProvider.roles[index],
                            onTap: () {
                              roleProvider.selectRole(index);
                            },
                            isSelected: roleProvider.selectedRoleIndex == index,
                            textColor: Color(0xffFFFFFF),
                            bgColor: Colors.grey,
                            primaryColor: AppColor.seconadryColor,
                          ),
                        );
                      }),
                      if (roleProvider.errorMessage != null)
                        Padding(
                          padding: EdgeInsets.only(top: Responsive.h(1)),
                          child: Text(
                            roleProvider.errorMessage!,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: Responsive.sp(12),
                            ),
                          ),
                        ),
                      if (signupProvider.generalError != null)
                        Padding(
                          padding: EdgeInsets.only(top: Responsive.h(1)),
                          child: Text(
                            signupProvider.generalError!,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: Responsive.sp(12),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              // Bottom Button
              Padding(
                padding: EdgeInsets.only(
                  top: Responsive.h(1),
                  bottom: Responsive.h(1),
                ),
                child: AuthButton(
                  loading: roleProvider.isLoading || signupProvider.isLoading,
                  onPress: () async {
                    // Validate role selection first
                    if (roleProvider.selectedRoleIndex == -1) {
                      Utils.tosatMassage('Please select a role to continue');
                      return;
                    }

                    // Check if user is already signed in (coming from login)
                    if (authManager.isSignedIn) {
                      // Just store role and navigate
                      bool success = await roleProvider
                          .continueWithSelectedRole();
                      if (success) {
                        Navigator.pushReplacementNamed(
                          context,
                          RoutesName.profilesView,
                        );
                      }
                    } else {
                      // Coming from signup - create account with selected role
                      final role = roleProvider.getUserRole();
                      if (role == null) {
                        Utils.tosatMassage('Please select a valid role');
                        return;
                      }
                      
                      debugPrint('=== STARTING SIGNUP PROCESS ===');
                      debugPrint('Role: $role');
                      debugPrint('Name: ${signupProvider.nameController.text}');
                      debugPrint('Email: ${signupProvider.emailController.text}');
                      
                      bool signupSuccess = await signupProvider.signUp(role);
                      if (signupSuccess) {
                        bool roleSuccess = await roleProvider
                            .continueWithSelectedRole();
                        if (roleSuccess) {
                          // Clear form after successful signup
                          signupProvider.reset();
                          Navigator.pushReplacementNamed(
                            context,
                            RoutesName.profilesView,
                          );
                        } else {
                          Utils.tosatMassage('Failed to save role. Please try again.');
                        }
                      } else {
                        // Show error from signup provider
                        final error = signupProvider.generalError ?? 
                                     signupProvider.nameError ?? 
                                     signupProvider.emailError ?? 
                                     signupProvider.passwordError ?? 
                                     'Signup failed. Please try again.';
                        Utils.tosatMassage(error);
                      }
                    }
                  },
                  buttonText: 'Continue',
                  suffixIcon: 'assets/icons/forward.svg',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
