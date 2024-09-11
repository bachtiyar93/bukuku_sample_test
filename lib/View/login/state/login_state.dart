import 'dart:developer';

import 'package:bukuku_sample_test/View/login/login_form.dart';
import 'package:bukuku_sample_test/core/AppHelpers.dart';
import 'package:bukuku_sample_test/core/NavigationHelper/BaseNavigationHelper.dart';
import 'package:bukuku_sample_test/core/NavigationHelper/NavigationHelper.dart';
import 'package:bukuku_sample_test/global_state.dart';
import 'package:bukuku_sample_test/main.dart';
import 'package:flutter/cupertino.dart';

class LoginState extends ChangeNotifier {
  final BaseNavigationHelper navigation = NavigationHelper();

  login() async {
    AppHelpers.navigation.openPageClass(LoginPage());
  }





  Future<void> skipLogin() async {
    GlobalState global = AppHelpers.getState<GlobalState>(listen: false);
    global.setSkip();
    AppHelpers.navigation.openPageNamedNoNav(Main.home);
  }
}
