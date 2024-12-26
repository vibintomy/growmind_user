import 'package:flutter/material.dart';
import 'package:growmind/core/utils/constants.dart';
import 'package:growmind/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:growmind/features/auth/presentation/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

GestureDetector alertBox(BuildContext context) {
  return GestureDetector(
    onTap: () {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Log out'),
              content: const Text('Are you sure? you wanted to Log out'),
              actions: [
                TextButton(
                    onPressed: () {
                      logout();
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    child: const Text(
                      'Yes',
                      style: TextStyle(color: mainColor),
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'No',
                    ))
              ],
            );
          });
    },
    child: const Row(
      children: [
        Icon(Icons.logout),
        kwidth,
        Text(
          'Log Out',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Spacer(),
        Icon(Icons.arrow_forward),
      ],
    ),
  );
}

Future<void> logout() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.remove(AuthLocalDataSourceImpl.cachedUserKey);
  print('user Log out');
}
