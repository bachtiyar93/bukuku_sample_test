import 'package:bot_toast/bot_toast.dart';
import 'package:bukuku_sample_test/View/Home/Home.dart';
import 'package:bukuku_sample_test/View/base.dart';
import 'package:bukuku_sample_test/View/login/login.dart';
import 'package:bukuku_sample_test/core/AppHelpers.dart';
import 'package:bukuku_sample_test/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();



  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      builder: (context, child) {
        return OKToast(
          child: MaterialApp(
            title: 'POS Bukuku',
            debugShowCheckedModeBanner: false,
            builder: BotToastInit(),
            navigatorKey: AppHelpers.navigation.navigatorKey,
            scaffoldMessengerKey: AppHelpers.navigation.messengerKey,
            navigatorObservers: [BotToastNavigatorObserver()],
            theme: ThemeData(
              colorScheme: const ColorScheme.light(
                // background: Colors.white,
                surfaceTint: Colors.white,
              ),
              fontFamily: 'Inter',
              textTheme: Theme.of(context).textTheme.apply(fontFamily: 'Inter'),
              // bottomSheetTheme: const BottomSheetThemeData(
              //     backgroundColor: Colors.transparent),
              textSelectionTheme: const TextSelectionThemeData(
                cursorColor: Colors.blueAccent,
                selectionColor: Colors.lightBlueAccent,
                selectionHandleColor: Colors.blue,
              ),
              useMaterial3: true,
            ),
            initialRoute: Main.base,
            routes: {
              Main.base: (_) => const Base(),
              Main.login: (_) => const Login(),
              Main.home: (_) => const Home(),
            },
          ),
        );
      },
    );
  }
}

class Main {
  static const String base = "/";
  static const String login = "/login";
  static const String home = '/home';
}