import 'package:flutter/material.dart';
import 'package:provide/res/components/auth_button.dart';
import 'package:provide/utils/routes/responsive.dart';
import 'package:provide/utils/routes/routes_name.dart';
import 'package:provide/widgets/custom_role_based_card.dart';
import 'package:provide/viewmodel/role_selection_provider.dart';
import 'package:provider/provider.dart';

class RoleBasedScreen extends StatelessWidget {
  const RoleBasedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Responsive.init(context); // Initialize responsive
    final roleProvider = Provider.of<RoleSelectionProvider>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff000000),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.w(5),
              vertical: Responsive.h(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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

                SizedBox(height: Responsive.h(5)),

                // Role Cards
                ...List.generate(roleProvider.roles.length, (index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: Responsive.h(3)),
                    child: CustomRoleOptionTileCard(
                      roleName: roleProvider.roles[index],
                      onTap: () {
                        roleProvider.selectRole(index);
                      },
                      isSelected: roleProvider.selectedRoleIndex == index,
                      textColor: Color(0xffFFFFFF),

                      bgColor: Colors.black.withValues(alpha:  0.15),
                      primaryColor: roleProvider.getRoleColor(index),
                    ),
                  );
                }),

                SizedBox(height: Responsive.h(5)),

                AuthButton(
                  loading: roleProvider.isLoading,
                  onPress: roleProvider.canContinue
                      ? () async {
                          bool success = await roleProvider
                              .continueWithSelectedRole();
                          if (success) {
                            Navigator.pushReplacementNamed(
                              context,
                              RoutesName.home,
                            );
                          }
                        }
                      : null,
                  buttonText: 'Continue',
                  suffixIcon: 'assets/icons/forward.svg',
                ),
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

                SizedBox(height: Responsive.h(5)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
