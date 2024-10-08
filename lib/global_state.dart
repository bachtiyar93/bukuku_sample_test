import 'dart:developer';
import 'dart:io' show Platform;

import 'package:bukuku_sample_test/Model/screen_size.dart';
import 'package:bukuku_sample_test/Model/summary.dart';
import 'package:bukuku_sample_test/Model/table.dart';
import 'package:bukuku_sample_test/View/Home/table.dart';
import 'package:bukuku_sample_test/core/AppHelpers.dart';
import 'package:bukuku_sample_test/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalState extends ChangeNotifier {
  ScreenSize? screen;
  String deviceOS = "";
  bool logedin = false;
  bool isSkip = false;
  String name='';
  TableData? tableSelected;
  List<CartItem> cartItems = [];
  List<TableData> tables = [
    TableData(number: 1, status: TableStatus.available),
    TableData(number: 2, status: TableStatus.available),
    TableData(number: 3, status: TableStatus.available),
  ];

  setDeviceOS() {
    deviceOS = Platform.operatingSystem;
    notifyListeners();

    log('Device OS $deviceOS');
  }

  setScreen() {
    screen = ScreenSize(
        width: MediaQuery.of(AppHelpers.navigation.currentContext!).size.width,
        height:
            MediaQuery.of(AppHelpers.navigation.currentContext!).size.height);
    notifyListeners();
  }

  checkSessions() async {
    final prefs = await SharedPreferences.getInstance();
    final login = prefs.getString('login');
    if (login != '' && login!=null) {
      name=login;
      notifyListeners();
      AppHelpers.navigation.openPageNamedNoNav(Main.home);
    } else {
      AppHelpers.navigation.openPageNamedNoNav(Main.login);
    }
  }

  void setSkip() {
    logedin = false;
    isSkip = true;
    notifyListeners();
  }

  Future<void> setLogout() async {
    logedin = false;
    isSkip = false;
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('login','');
    AppHelpers.navigation.openPageNamedNoNav(Main.login);
    notifyListeners();
  }

  void selectTable(TableData table) {
    tableSelected=table;
    notifyListeners();
  }

  openTable() async {
    await AppHelpers.navigation.openPageClass(const TableManagement());
    Future.delayed(const Duration(seconds: 1),()=>notifyListeners());
  }

  void setName(String s) {
    name=s;
    notifyListeners();
  }

}
