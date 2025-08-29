import 'package:flutter/material.dart';
import 'package:provide/view/user/home_screen.dart';
import 'package:provide/utils/routes/routes_name.dart';
import 'package:provide/view/auth/loginview.dart';
import 'package:provide/view/auth/role_based_screen.dart';
import 'package:provide/view/auth/sginupview.dart';

class Routes {
  static Route<dynamic> generateRoutes(RouteSettings setting) {
    // setting.arguments;
    switch (setting.name) {
      case RoutesName.home:
        return MaterialPageRoute(builder: (BuildContext context) => HomeView());
      case RoutesName.login:
        return MaterialPageRoute(
          builder: (BuildContext context) => Loginview(),
        );
      case RoutesName.signup:
        return MaterialPageRoute(
          builder: (BuildContext context) => Signupview(),
        );

      case RoutesName.roleSelection:
        return MaterialPageRoute(
          builder: (BuildContext context) => RoleBasedScreen(),
        );

      default:
        return MaterialPageRoute(builder: (BuildContext context) => HomeView());
    }
  }
}
