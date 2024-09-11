import 'package:bukuku_sample_test/core/AppHelpers.dart';
import 'package:bukuku_sample_test/global_state.dart';
import 'package:bukuku_sample_test/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {final _formKey = GlobalKey<FormState>();
final _usernameController = TextEditingController();
final _passwordController = TextEditingController();

@override
void dispose() {
  _usernameController.dispose();
  _passwordController.dispose();
  super.dispose();
}

Future<void> _login() async {
  if (_formKey.currentState!.validate()) {
    final username = _usernameController.text;
    final password = _passwordController.text;
    final prefs = await SharedPreferences.getInstance();

    if (username=='admin' && password=='admin123') {
      await prefs.setString('login', 'Administrator');
      AppHelpers.navigation.openPage(Main.home);
      context.watch<GlobalState>().name='Administrator';
      AppHelpers.showSnackBar(content: const Text('Kamu login sebagai administrator'),color: Colors.green);
    } else {
      AppHelpers.showSnackBar(content: const Text('Username atau password salah'), color: Colors.red);
    }
  }
}

@override
Widget build(BuildContext context) {
  GlobalState global = AppHelpers.getState<GlobalState>();
  return Scaffold(
    appBar: AppBar(
      title: const Text('Login'),
    ),
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
        top:  80,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const SizedBox(
              height: 80,
            ),
            const Icon(Icons.sell, color: Colors.amber, size: 180,),
            const SizedBox(
              height: 80,
            ),
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(labelText: 'Username'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _login,
                    child: const Text('Login'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
}