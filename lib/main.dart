import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:growmind/core/utils/constants.dart';
import 'package:growmind/core/utils/service.dart';
import 'package:growmind/features/auth/presentation/bloc/login_bloc/auth_bloc.dart';
import 'package:growmind/features/auth/presentation/bloc/signup_bloc/bloc/signup_bloc.dart';
import 'package:growmind/features/auth/presentation/pages/login_page.dart';
import 'package:growmind/features/auth/presentation/pages/splash_screen.dart';
import 'package:growmind/features/bottom_navigation/presentation/pages/bottom_navigation.dart';
import 'package:growmind/features/home/presentation/bloc/animation_bloc.dart';
import 'package:growmind/features/profile/domain/usecases/get_profile.dart';
import 'package:growmind/features/profile/domain/usecases/update_profile_usecases.dart';
import 'package:growmind/features/profile/presentation/bloc/profile_bloc/bloc/profile_bloc.dart';
import 'package:growmind/features/profile/presentation/bloc/update_profile_bloc/bloc/update_profile_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setUp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(372, 812),
      minTextAdapt: true,
      builder: (context, child) {
        return MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (context) =>
                      AuthBloc(firebasepath: FirebaseAuth.instance)),
              BlocProvider(
                  create: (context) => SignupBloc(
                      auth: FirebaseAuth.instance,
                      firestore: FirebaseFirestore.instance)),
                             BlocProvider(create: (context)=> ProfileBloc(getIt<GetProfile>(),)),
                                  BlocProvider(create: (context)=>ProfileUpdateBloc(getIt<UpdateProfileUsecases>())),
                                  BlocProvider(create: (context)=>AnimationCubit()..startRotation())
            ],
            child: MaterialApp(
              theme: ThemeData(
                iconTheme: IconThemeData(
                  size: 28.w,
                  color: Colors.black,
                ),
              ),
              color: textColor,
              debugShowCheckedModeBanner: false,
              initialRoute: '/splashscreen',
              routes: {
                '/splashscreen': (context) => const SplashScreen(),
                '/bottomnavigation': (context) => const BottomNavigation(),
                '/login': (context) => LoginPage(),
              },
            ));
      },
    );
  }
}
