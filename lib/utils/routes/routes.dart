import 'package:flutter/material.dart';
import 'package:provide/utils/routes/routes_name.dart';
import 'package:provide/view/homeview.dart';
import 'package:provide/view/loginview.dart';

class Routes {
  static Route<dynamic> generateRoutes(RouteSettings setting) {
    // setting.arguments;
    switch (setting.name) {
      case RoutesName.home:
        return MaterialPageRoute(builder: (BuildContext context) => Homeview());
      case RoutesName.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => Loginview());

      default:
        RoutesName.home;
        return MaterialPageRoute(builder: (BuildContext context) => Homeview());
    }
  }
}
