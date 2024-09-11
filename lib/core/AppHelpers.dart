// Project imports:
import 'dart:io';

import 'package:bukuku_sample_test/View/login/state/login_state.dart';
import 'package:bukuku_sample_test/Widget/style.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:oktoast/oktoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'NavigationHelper/BaseNavigationHelper.dart';
import 'NavigationHelper/NavigationHelper.dart';

class AppHelpers {
  static final BaseNavigationHelper navigation = NavigationHelper();

  static Future<bool> hasInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result.first.rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException {
      return false;
    }
    return false;
  }

  static void toastSuccess(context, String message, lang,
      {title = "Success!"}) {
    showToastWidget(
        Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: SizedBox(
                width: double.infinity - 40,
                child: Card(
                    color: Colors.transparent,
                    elevation: 2,
                    child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: Colors.green[600],
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        child: Row(children: <Widget>[
                          const Icon(Icons.check_circle, color: Colors.white),
                          // Image.asset("assets/checked.png",
                          //     color: Colors.white, height: 35, width: 35),
                          const SizedBox(width: 12),
                          Expanded(
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                Text(
                                    "${lang == "Indonesia" ? "Berhasil!" : title}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700)),
                                const SizedBox(height: 0),
                                Row(children: <Widget>[
                                  Expanded(
                                    child: Text(message,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w300)),
                                  )
                                ])
                              ]))
                        ]))))),
        position: ToastPosition.bottom,
        context: context);
  }

  static bool validationEmail(String data) {
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(data);
    return emailValid;
  }

  static TimeOfDay timeOfDayParse(timeString) {
    List<String> parts =
        timeString.split('.'); // memisahkan string berdasarkan karakter '.'
    TimeOfDay time = TimeOfDay(
      hour: int.parse(
          parts[0]), // mengambil bagian jam dan mengonversi menjadi integer
      minute: int.parse(
          parts[1]), // mengambil bagian menit dan mengonversi menjadi integer
    );
    return time;
  }

  // CustomProgressDialog
  static Future<void> showWarning({title, text, dissmisable = false}) async {
    return await showDialog<void>(
      context: navigation.navigatorKey.currentContext!,
      barrierColor: Colors.transparent,
      barrierDismissible: dissmisable,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Row(
            children: [
              const Icon(
                Icons.warning_amber,
                color: Colors.amber,
              ),
              Text(
                title ?? "Error",
                style: const TextStyle(color: Colors.amber),
              ),
            ],
          ),
          content: Text(text ?? ""),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                AppHelpers.navigation.closePage(); // Dismiss alert dialog
              },
            ),
          ],
        );
      },
    );
  }

  // CustomProgressDialog
  static Future<void> showLoading({
    title,
    text,
    isBarrierColorActive = false,
    isBarrierDismissible = true,
  }) async {
    return showDialog<void>(
      context: navigation.navigatorKey.currentContext!,
      barrierColor: isBarrierColorActive ? null : Colors.transparent,
      barrierDismissible: isBarrierDismissible,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return Container(
          height: MediaQuery.of(navigation.navigatorKey.currentContext!)
              .size
              .height,
          width:
              MediaQuery.of(navigation.navigatorKey.currentContext!).size.width,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

// CustomProgressDialog
  static Future<void> showProgress({text, dissmisable = false, child}) async {
    return await showDialog<void>(
      context: navigation.navigatorKey.currentContext!,
      barrierColor: Colors.transparent,
      barrierDismissible: dissmisable,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: Container(
              alignment: FractionalOffset.center,
              height: 80.0,
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  child ?? const CircularProgressIndicator(),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(text)
                ],
              )),
        );
      },
    );
  }

  static showSnackBar({required Widget content, Color color=const Color(0xff2B2F38)}) {
    return ScaffoldMessenger.of(navigation.navigatorKey.currentContext!)
        .showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        margin: const EdgeInsets.only(bottom: 35, left: 35, right: 35),
        content: SizedBox(
          height: 20,
          child: content,
        ),
      ),
    );
  }

  static showBottomSheetSkipLogin() {
    return showModalBottomSheet(
      context: navigation.navigatorKey.currentContext!,
      isScrollControlled: true,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      builder: (context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              Image.asset(
                'assets/images/belum-login.png',
                width: 168,
                height: 168,
              ),
              const SizedBox(height: 21),
              Text(
                'Login Terlebih Dahulu',
                style: AppStyles.textL.bold,
                textAlign: TextAlign.center,
              ),
              const Text(
                'Untuk akses fitur perlu login M-ID',
                style: AppStyles.textM,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 46),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                height: 88,
                width: MediaQuery.of(context).size.width,
                child: InkWell(
                  onTap: () {
                    AppHelpers.getState<LoginState>(listen: false).login();
                  },
                  enableFeedback: true,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.blue,
                    ),
                    child: Text(
                      'Login Sekarang',
                      style: AppStyles.textM.white.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  ///GetPage data by payload with key
  static getPageData() {
    if (ModalRoute.of(navigation.navigatorKey.currentContext!)!
            .settings
            .arguments ==
        null) {
      return <String, dynamic>{};
    } else {
      return ModalRoute.of(navigation.navigatorKey.currentContext!)!
          .settings
          .arguments;
    }
  }

  //Delay with duration
  Future<void> futureDelay(Duration dur, function) {
    return Future.delayed(dur, () => function);
  }

  ///run after state completly build
  static void runAfterBuild(function) {
    return WidgetsBinding.instance.addPostFrameCallback((_) => function);
  }

  static T getState<T extends ChangeNotifier>({bool listen = true}) {
    return Provider.of<T>(navigation.navigatorKey.currentContext!,
        listen: listen);
  }

  static T watchStae<T extends ChangeNotifier>() {
    return Provider.of<T>(navigation.navigatorKey.currentContext!);
  }

  ///get data hive
  static getDataBox(key) async {
    if (!kIsWeb && !Hive.isBoxOpen(key)) {
      Hive.init((await getApplicationDocumentsDirectory()).path);
    }
    await Hive.openBox(key);
    Box box = Hive.box(key);
    box.isEmpty ? box.put(key, false) : null;
    var data = box.get(key);
    await Hive.close();
    return data;
  }

  ///save data hive
  static saveDataBox(key, data) async {
    await Hive.openBox(key);
    Box box = Hive.box(key);
    box.put(key, data);
    await Hive.close();
  }
}
