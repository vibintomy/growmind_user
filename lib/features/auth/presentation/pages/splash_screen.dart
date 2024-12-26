import 'package:flutter/material.dart';
import 'package:growmind/features/auth/data/datasources/auth_local_data_source.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthLocalDataSource authLocalDataSource = AuthLocalDataSourceImpl();
  @override
  void initState() {
    checkLogin();
    super.initState();
  }

  Future<void> checkLogin() async {
    final user =await authLocalDataSource.getcacheUser();
    try {
      if (user != null) {
        Navigator.pushReplacementNamed(context, '/bottomnavigation');
      } else {
        Navigator.pushReplacementNamed(context, '/login');
      }
    } catch (e) {
      throw Exception('cant be moved to home page');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CircularProgressIndicator(),
    );
  }
}
