import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:growmind/core/utils/constants.dart';
import 'package:growmind/core/utils/notification_service.dart';
import 'package:growmind/core/utils/service.dart';
import 'package:growmind/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:growmind/features/auth/domain/usecases/google_auth_usecases.dart';
import 'package:growmind/features/auth/presentation/bloc/google_auth_bloc/google_auth_bloc.dart';
import 'package:growmind/features/auth/presentation/bloc/login_bloc/auth_bloc.dart';
import 'package:growmind/features/auth/presentation/bloc/signup_bloc/bloc/signup_bloc.dart';
import 'package:growmind/features/auth/presentation/bloc/splash_bloc.dart';
import 'package:growmind/features/auth/presentation/pages/login_page.dart';
import 'package:growmind/features/auth/presentation/pages/splash_screen.dart';
import 'package:growmind/features/auth/presentation/pages/welcome_page.dart';
import 'package:growmind/features/bottom_navigation/presentation/pages/bottom_navigation.dart';
import 'package:growmind/features/chat/domain/usecases/chat_mentors_usecases.dart';
import 'package:growmind/features/chat/domain/usecases/chat_usecases.dart';
import 'package:growmind/features/chat/domain/usecases/last_chat_usecases.dart';
import 'package:growmind/features/chat/presentation/bloc/chat_bloc/chat_bloc.dart';
import 'package:growmind/features/chat/presentation/bloc/last_chat_bloc/last_chat_bloc.dart';
import 'package:growmind/features/chat/presentation/bloc/mentor_bloc/mentor_bloc.dart';
import 'package:growmind/features/favourites/domain/usecases/fetch_favorite_course_usecase.dart';
import 'package:growmind/features/favourites/domain/usecases/get_favourite_course.dart';
import 'package:growmind/features/favourites/domain/usecases/is_favourite.dart';
import 'package:growmind/features/favourites/domain/usecases/toggle_favourite.dart';
import 'package:growmind/features/favourites/presentation/bloc/favorite_bloc.dart';
import 'package:growmind/features/home/domain/repositories/notification_repositories.dart';
import 'package:growmind/features/home/domain/usecases/category_usecases.dart';
import 'package:growmind/features/home/domain/usecases/fetch_course_usecases.dart';
import 'package:growmind/features/home/domain/usecases/get_tutor_usecases.dart';
import 'package:growmind/features/home/domain/usecases/purchase_course_usecases.dart';
import 'package:growmind/features/home/domain/usecases/send_notification_usecases.dart';
import 'package:growmind/features/home/domain/usecases/top_course_usecases.dart';
import 'package:growmind/features/home/domain/usecases/top_tutors_usecases.dart';
import 'package:growmind/features/home/presentation/bloc/animation_bloc.dart';
import 'package:growmind/features/home/presentation/bloc/curriculum_bloc/curriculum_bloc.dart';
import 'package:growmind/features/home/presentation/bloc/fetch_categories_bloc/fetch_categories_bloc.dart';
import 'package:growmind/features/home/presentation/bloc/fetch_course_bloc/fetch_course_bloc.dart';
import 'package:growmind/features/home/presentation/bloc/get_tutor_bloc/tutor_bloc.dart';
import 'package:growmind/features/home/presentation/bloc/notification_bloc/notification_bloc.dart';
import 'package:growmind/features/home/presentation/bloc/purchased_bloc/purchased_bloc.dart';
import 'package:growmind/features/home/presentation/bloc/top_courses_bloc/top_courses_bloc.dart';
import 'package:growmind/features/home/presentation/bloc/top_tutors_bloc/top_tutors_bloc.dart';
import 'package:growmind/features/profile/domain/usecases/get_profile.dart';
import 'package:growmind/features/profile/domain/usecases/my_courses_usecases.dart';
import 'package:growmind/features/profile/domain/usecases/update_profile_usecases.dart';
import 'package:growmind/features/profile/presentation/bloc/my_courses_bloc/my_courses_bloc.dart';
import 'package:growmind/features/profile/presentation/bloc/profile_bloc/bloc/profile_bloc.dart';
import 'package:growmind/features/profile/presentation/bloc/update_profile_bloc/bloc/update_profile_bloc.dart';


final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setUp();
  getIt<NotificationService>().initialize();
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
              BlocProvider(
                  create: (context) => ProfileBloc(
                        getIt<GetProfile>(),
                      )),
              BlocProvider(
                  create: (context) =>
                      ProfileUpdateBloc(getIt<UpdateProfileUsecases>())),
              BlocProvider(
                  create: (context) => AnimationCubit()..startRotation()),
              BlocProvider(
                  create: (context) =>
                      FetchCategoriesBloc(usecases: getIt<CategoryUsecases>())),
              BlocProvider(
                  create: (context) =>
                      FetchCourseBloc(getIt<FetchCourseUsecases>())),
              BlocProvider(
                  create: (context) =>
                      TutorBloc(getTutorUsecases: getIt<GetTutorUsecases>())),
              BlocProvider(create: (context) => CurriculumBloc()),
              BlocProvider(
                  create: (context) =>
                      PurchasedBloc(getIt<PurchaseCourseUsecases>())),
              BlocProvider(
                  create: (context) =>
                      TopCoursesBloc(getIt<TopCourseUsecases>())),
              BlocProvider(
                  create: (context) =>
                      TopTutorsBloc(getIt<TopTutorsUsecases>())),
              BlocProvider(
                create: (context) => ChatBloc(getIt<ChatUsecases>()),
              ),
              BlocProvider(
                  create: (context) =>
                      MentorBloc(getIt<ChatMentorsUsecases>())),
              BlocProvider(
                  create: (context) => FavoriteBloc(
                      fetchFavoriteCourseUsecase:
                          getIt<FetchFavoriteCourseUsecase>(),
                      getFavouriteCourse: getIt<GetFavouriteCourse>(),
                      isFavourite: getIt<IsFavourite>(),
                      toggleFavourite: getIt<ToggleFavourite>())),
              BlocProvider(
                  create: (context) => LastChatBloc(getIt<LastChatUsecases>())),
              BlocProvider(
                  create: (context) =>
                      MyCoursesBloc(getIt<MyCoursesUsecases>())),
              BlocProvider(
                  create: (context) => NotificationBloc(
                      getIt<SendNotificationUsecases>(),
                      getIt<NotificationRepositories>())),
              BlocProvider(
                  create: (context) =>
                      SplashCubit(AuthLocalDataSourceImpl())),
                         BlocProvider(create: (context)=> GoogleAuthBloc(getIt<GoogleAuthUsecases>()))
            ],
            child: MaterialApp(
              navigatorKey: navigatorKey,
              theme: ThemeData(
                // textTheme: GoogleFonts.poppinsTextTheme(),
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
                '/welcomePage': (context) => const WelcomePage(),
                '/login': (context) => LoginPage(),
              },
            ));
      },
    );
  }
}
