import 'package:bukuku_sample_test/core/AppHelpers.dart';
import 'package:bukuku_sample_test/global_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyDrawerContent extends StatelessWidget {
  const MyDrawerContent({super.key});


  @override
  Widget build(BuildContext context) {
    GlobalState global = AppHelpers.getState<GlobalState>();
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text(
            'Menu',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.home),
          title: const Text('Home'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/home');
          },
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Settings'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/settings');
          },
        ),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('Logout'),
          onTap: () {
            Navigator.pop(context);
            global.setLogout();
          },
        ),
      ],
    );
  }
}