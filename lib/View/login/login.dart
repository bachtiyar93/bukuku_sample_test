import 'package:bukuku_sample_test/View/login/state/login_state.dart';
import 'package:bukuku_sample_test/Widget/style.dart';
import 'package:bukuku_sample_test/core/AppHelpers.dart';
import 'package:bukuku_sample_test/core/extensions/build_context_extensions.dart';
import 'package:bukuku_sample_test/global_state.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalState global = AppHelpers.getState<GlobalState>();
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        height: global.screen!.height,
        decoration: const BoxDecoration(
          color: Colors.blueGrey,
          image: DecorationImage(
            image: AssetImage('assets/login-background.gif'),
            fit: BoxFit.fill,
          ),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
        ).copyWith(
          top: context.isPotrait ? 150 : 80,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Icon(Icons.sell, color: Colors.amber, size: 180,),
              SizedBox(
                height: context.isPotrait ? 250 : 80,
              ),
              loginWithMIDbutton(),
              skipButton()
            ],
          ),
        ),
      ),
    );
  }

  loginWithMIDbutton() {
    LoginState local = AppHelpers.getState<LoginState>();
    return Container(
      alignment: Alignment.center,
      child: ElevatedButton(
        onPressed: () => local.login(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Container(
          alignment: Alignment.center,
          constraints: const BoxConstraints(
            minHeight: 56,
            minWidth: 331,
          ),
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Login',
                  style: AppStyles.textL.white.bold,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  skipButton() {
    LoginState local = AppHelpers.getState<LoginState>();

    return TextButton(
      onPressed: () async {
        local.skipLogin();
      },
      child: Text(
        'Skip',
        style: AppStyles.textL.white.bold,
      ),
    );
  }
}
