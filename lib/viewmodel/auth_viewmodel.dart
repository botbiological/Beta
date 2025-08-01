import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provide/repository/auth_repository.dart' show AuthRepository;
import 'package:provide/utils/routes/routes_name.dart';
import 'package:provide/utils/routes/utils.dart';

class AuthViewmodel extends ChangeNotifier {
  final _myRepo = AuthRepository();
  bool _isloading = false;
  bool get loading => _isloading;

  setloaoding(bool value) {
    _isloading = value;
    notifyListeners();
  }

  Future<void> loginApi(
      dynamic data, dynamic header, BuildContext context) async {
    setloaoding(true);
    _myRepo.loginApi(data, header).then((value) {
      setloaoding(false);
      if (kDebugMode) {
        print(value["token"].toString());
        if (value["token"] == "QpwL5tke4Pnpja7X4") {
          Navigator.pushNamed(context, RoutesName.home);
        }
      }
    }).onError(
      (error, stackTrace) {
        setloaoding(false);
        if (kDebugMode) {
          Utils.flushBarErrorMassage(error.toString(), context);
          print(error.toString());
        }
      },
    );
  }

   Future<void> SginUpApi(
      dynamic data, dynamic header, BuildContext context) async {
    setloaoding(true);
    _myRepo.loginApi(data, header).then((value) {
      setloaoding(false);
      if (kDebugMode) {
        print(value["token"].toString());
        if (value["token"] == "QpwL5tke4Pnpja7X4") {
          Navigator.pushNamed(context, RoutesName.home);
        }
      }
    }).onError(
      (error, stackTrace) {
        setloaoding(false);
        if (kDebugMode) {
          Utils.flushBarErrorMassage(error.toString(), context);
          print(error.toString());
        }
      },
    );
  }
}
