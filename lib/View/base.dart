import 'package:bukuku_sample_test/global_state.dart';
import 'package:flutter/material.dart';
import '../core/AppHelpers.dart';

class Base extends StatefulWidget {
  const Base({super.key});

  @override
  State<Base> createState() => _BaseState();
}

class _BaseState extends State<Base> {
  GlobalState controller = AppHelpers.getState<GlobalState>();
  @override
  void initState() {
    AppHelpers.runAfterBuild(
      Future.delayed(const Duration(seconds: 2), () {
        controller.setScreen();
        controller.checkSessions();
        controller.setDeviceOS();
      }),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
        child: Icon(Icons.sell, color: Colors.amber, size: 150,),
      ),
    );
  }
}
