import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:growmind/core/utils/cloudinary.dart';
import 'package:growmind/core/utils/notification_service.dart';
import 'package:growmind/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:growmind/features/auth/data/repositories/google_auth_repo_impl.dart';
import 'package:growmind/features/auth/domain/repositories/google_auth_repositories.dart';
import 'package:growmind/features/auth/domain/usecases/google_auth_usecases.dart';
import 'package:growmind/features/auth/presentation/bloc/google_auth_bloc/google_auth_bloc.dart';
import 'package:growmind/features/chat/data/datasource/chat_mentor_datasource_impl.dart';
import 'package:growmind/features/chat/data/datasource/chat_remot_datasource_impl.dart';
import 'package:growmind/features/chat/data/datasource/chat_remote_datasource.dart';
import 'package:growmind/features/chat/data/repository/chat_mentor_repo_impl.dart';
import 'package:growmind/features/chat/data/repository/chat_repo_impl.dart';
import 'package:growmind/features/chat/data/repository/last_chat_repo_impl.dart';
import 'package:growmind/features/chat/domain/repositories/chat_mentor_repositories.dart';
import 'package:growmind/features/chat/domain/repositories/chat_repositories.dart';
import 'package:growmind/features/chat/domain/repositories/last_chat_repositories.dart';
import 'package:growmind/features/chat/domain/usecases/chat_mentors_usecases.dart';
import 'package:growmind/features/chat/domain/usecases/chat_usecases.dart';
import 'package:growmind/features/chat/domain/usecases/last_chat_usecases.dart';
import 'package:growmind/features/chat/presentation/bloc/chat_bloc/chat_bloc.dart';
import 'package:growmind/features/chat/presentation/bloc/last_chat_bloc/last_chat_bloc.dart';
import 'package:growmind/features/chat/presentation/bloc/mentor_bloc/mentor_bloc.dart';
import 'package:growmind/features/favourites/data/datasource/favourite_remote_datasource.dart';
import 'package:growmind/features/favourites/data/datasource/favourite_remote_datasource_impl.dart';
import 'package:growmind/features/favourites/data/favorite_repository_impl/favorite_repo_impl.dart';
import 'package:growmind/features/favourites/domain/repositories/favourite_repository.dart';
import 'package:growmind/features/favourites/domain/usecases/fetch_favorite_course_usecase.dart';
import 'package:growmind/features/favourites/domain/usecases/get_favourite_course.dart';
import 'package:growmind/features/favourites/domain/usecases/is_favourite.dart';
import 'package:growmind/features/favourites/domain/usecases/toggle_favourite.dart';
import 'package:growmind/features/favourites/presentation/bloc/favorite_bloc.dart';
import 'package:growmind/features/home/data/datasource/categories_remote_datasource.dart';
import 'package:growmind/features/home/data/datasource/fcm_datasource.dart';
import 'package:growmind/features/home/data/datasource/fcm_datasource_impl.dart';
import 'package:growmind/features/home/data/datasource/purchased_course_datasource.dart';
import 'package:growmind/features/home/data/datasource/tutor_remote_datasource.dart';
import 'package:growmind/features/home/data/repo/categories_repo_impl.dart';
import 'package:growmind/features/home/data/repo/fetch_course_repo_impl.dart';
import 'package:growmind/features/home/data/repo/notification_repo_impl.dart';
import 'package:growmind/features/home/data/repo/purchased_course_repo_impl.dart';
import 'package:growmind/features/home/data/repo/top_courses_repoo_impl.dart';
import 'package:growmind/features/home/data/repo/top_tutors_repo_impl.dart';
import 'package:growmind/features/home/data/repo/tutor_repo_impl.dart';
import 'package:growmind/features/home/domain/repositories/category_repository.dart';
import 'package:growmind/features/home/domain/repositories/fetch_course_repo.dart';
import 'package:growmind/features/home/domain/repositories/notification_repositories.dart';
import 'package:growmind/features/home/domain/repositories/purchased_course_repository.dart';
import 'package:growmind/features/home/domain/repositories/top_courses_repo.dart';
import 'package:growmind/features/home/domain/repositories/top_tutors_repo.dart';
import 'package:growmind/features/home/domain/repositories/tutor_repository.dart';
import 'package:growmind/features/home/domain/usecases/category_usecases.dart';
import 'package:growmind/features/home/domain/usecases/fetch_course_usecases.dart';
import 'package:growmind/features/home/domain/usecases/get_tutor_usecases.dart';
import 'package:growmind/features/home/domain/usecases/purchase_course_usecases.dart';
import 'package:growmind/features/home/domain/usecases/send_notification_usecases.dart';
import 'package:growmind/features/home/domain/usecases/top_course_usecases.dart';
import 'package:growmind/features/home/domain/usecases/top_tutors_usecases.dart';
import 'package:growmind/features/home/presentation/bloc/fetch_categories_bloc/fetch_categories_bloc.dart';
import 'package:growmind/features/home/presentation/bloc/fetch_course_bloc/fetch_course_bloc.dart';
import 'package:growmind/features/home/presentation/bloc/get_tutor_bloc/tutor_bloc.dart';
import 'package:growmind/features/home/presentation/bloc/notification_bloc/notification_bloc.dart';
import 'package:growmind/features/home/presentation/bloc/purchased_bloc/purchased_bloc.dart';
import 'package:growmind/features/home/presentation/bloc/top_courses_bloc/top_courses_bloc.dart';
import 'package:growmind/features/home/presentation/bloc/top_tutors_bloc/top_tutors_bloc.dart';
import 'package:growmind/features/profile/data/datasource/profile_remote_datasource.dart';
import 'package:growmind/features/profile/data/repo/my_courses_repo_impl.dart';
import 'package:growmind/features/profile/data/repo/profile_repo.dart';
import 'package:growmind/features/profile/data/repo/update_profile_repoimpl.dart';
import 'package:growmind/features/profile/domain/repo/my_courses_repo.dart';
import 'package:growmind/features/profile/domain/repo/profile_repo.dart';
import 'package:growmind/features/profile/domain/repo/update_profile_repo.dart';
import 'package:growmind/features/profile/domain/usecases/get_profile.dart';
import 'package:growmind/features/profile/domain/usecases/my_courses_usecases.dart';
import 'package:growmind/features/profile/domain/usecases/update_profile_usecases.dart';
import 'package:growmind/features/profile/presentation/bloc/my_courses_bloc/my_courses_bloc.dart';
import 'package:growmind/features/profile/presentation/bloc/profile_bloc/bloc/profile_bloc.dart';
import 'package:growmind/features/profile/presentation/bloc/update_profile_bloc/bloc/update_profile_bloc.dart';
import 'package:http/http.dart' as http;

final getIt = GetIt.instance;
void setUp() {
  // Data Layer
  getIt.registerLazySingleton<Cloudinary>(() => Cloudinary.signedConfig(
        apiKey: '642889674424333',
        apiSecret: 'EB9XFjTTm5kNygU6hxJMls79Tj8',
        cloudName: 'dj01ka9ga',
      ));
  getIt.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance);
  getIt.registerLazySingleton<FlutterLocalNotificationsPlugin>(
      () => FlutterLocalNotificationsPlugin());
  getIt.registerLazySingleton<FirebaseMessaging>(
      () => FirebaseMessaging.instance);
  getIt.registerLazySingleton<http.Client>(() => http.Client());
  getIt.registerLazySingleton<NotificationService>(() => NotificationService(
      getIt<FlutterLocalNotificationsPlugin>(), getIt<FirebaseMessaging>()));
  getIt.registerLazySingleton<ProfileRemoteDatasource>(
      () => ProfileRemoteDatasource(getIt<FirebaseFirestore>()));
  getIt.registerLazySingleton<ProfileRepo>(
      () => ProfileRepoImpl(getIt<ProfileRemoteDatasource>()));
  getIt.registerLazySingleton<UpdateProfileRepo>(() =>
      UpdateProfileRepimpl(getIt<Cloudinary>(), getIt<FirebaseFirestore>()));
  getIt.registerLazySingleton<CategoriesRemoteDatasource>(
      () => CategoriesRemoteDatasource(getIt<FirebaseFirestore>()));
  getIt.registerLazySingleton<CategoryRepository>(
      () => CategoriesRepoImpl(getIt<CategoriesRemoteDatasource>()));
  getIt.registerLazySingleton<FetchCourseRepo>(
      () => FetchCourseRepoimpl(getIt<FirebaseFirestore>()));
  getIt.registerLazySingleton<TutorRemoteDatasource>(
      () => TutorRemoteDatasource(getIt<FirebaseFirestore>()));
  getIt.registerLazySingleton<TutorRepository>(() =>
      TutorRepoImpl(tutorRemoteDatasource: getIt<TutorRemoteDatasource>()));
  getIt.registerLazySingleton<PurchasedCourseDatasource>(
      () => PurchasedCourseDatasource(getIt<FirebaseFirestore>()));
  getIt.registerLazySingleton<PurchasedCourseRepository>(
      () => PurchasedCourseRepoImpl(getIt<PurchasedCourseDatasource>()));
  getIt.registerLazySingleton<TopCoursesRepo>(
      () => TopCoursesRepoImpl(getIt<FirebaseFirestore>()));
  getIt.registerLazySingleton<TopTutorsRepo>(
      () => TopTutorsRepoImpl(getIt<FirebaseFirestore>()));

  getIt.registerLazySingleton<ChatRemoteDatasource>(
      () => ChatRemotDatasourceimpl(getIt<FirebaseFirestore>()));

  getIt.registerLazySingleton<ChatRepositories>(
      () => ChatRepoImpl(getIt<ChatRemoteDatasource>()));

  getIt.registerLazySingleton<ChatMentorDatasourceImpl>(
      () => ChatMentorDatasourceImpl(getIt<FirebaseFirestore>()));
  getIt.registerLazySingleton<ChatMentorRepositories>(
      () => ChatMentorRepoImpl(getIt<ChatMentorDatasourceImpl>()));
  getIt.registerLazySingleton<FavouriteRemoteDatasource>(
      () => FavouriteRemoteDatasourceImpl(getIt<FirebaseFirestore>()));
  getIt.registerLazySingleton<FavouriteRepository>(
      () => FavoriteRepoImpl(getIt<FavouriteRemoteDatasource>()));
  getIt.registerLazySingleton<LastChatRepositories>(
      () => LastChatRepoImpl(getIt<FirebaseFirestore>()));
  getIt.registerLazySingleton<MyCoursesRepo>(
      () => MyCoursesRepoImpl(getIt<FirebaseFirestore>()));
  getIt.registerLazySingleton<FCMDatasource>(() =>
      FCMDatasourceImpl(getIt<FirebaseMessaging>(), getIt<http.Client>()));
  getIt.registerLazySingleton<NotificationRepositories>(
      () => NotificationRepoImpl(getIt<FCMDatasource>()));
  getIt.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl());
  getIt.registerLazySingleton<GoogleAuthRepositories>(() =>
      GoogleAuthRepositoryImpl(
          authLocalDataSource: getIt<AuthLocalDataSource>()));
// Domain Layer
  getIt.registerLazySingleton(() => GetProfile(repo: getIt<ProfileRepo>()));
  getIt.registerLazySingleton(
      () => UpdateProfileUsecases(getIt<UpdateProfileRepo>()));
  getIt.registerLazySingleton(
      () => CategoryUsecases(getIt<CategoryRepository>()));
  getIt.registerLazySingleton(
      () => FetchCourseUsecases(getIt<FetchCourseRepo>()));
  getIt.registerLazySingleton(
      () => GetTutorUsecases(tutorRepository: getIt<TutorRepository>()));
  getIt.registerLazySingleton(
      () => PurchaseCourseUsecases(getIt<PurchasedCourseRepository>()));
  getIt.registerLazySingleton(() => TopCourseUsecases(getIt<TopCoursesRepo>()));
  getIt.registerLazySingleton(() => TopTutorsUsecases(getIt<TopTutorsRepo>()));
  getIt.registerLazySingleton(() => ChatUsecases(getIt<ChatRepositories>()));
  getIt.registerLazySingleton(
      () => ChatMentorsUsecases(getIt<ChatMentorRepositories>()));
  getIt.registerLazySingleton(
      () => GetFavouriteCourse(getIt<FavouriteRepository>()));
  getIt.registerLazySingleton(() => IsFavourite(getIt<FavouriteRepository>()));
  getIt.registerLazySingleton(
      () => ToggleFavourite(getIt<FavouriteRepository>()));
  getIt.registerLazySingleton(
      () => FetchFavoriteCourseUsecase(getIt<FavouriteRepository>()));
  getIt.registerLazySingleton(
      () => LastChatUsecases(getIt<LastChatRepositories>()));
  getIt.registerLazySingleton(() => MyCoursesUsecases(getIt<MyCoursesRepo>()));
  getIt.registerLazySingleton(
      () => SendNotificationUsecases(getIt<NotificationRepositories>()));
  getIt.registerLazySingleton(
      () => GoogleAuthUsecases(getIt<GoogleAuthRepositories>()));
  // Presentation Layer

  getIt.registerFactory(() => ProfileBloc(getIt<GetProfile>()));
  getIt
      .registerFactory(() => ProfileUpdateBloc(getIt<UpdateProfileUsecases>()));
  getIt.registerFactory(
      () => FetchCategoriesBloc(usecases: getIt<CategoryUsecases>()));
  getIt.registerFactory(() => FetchCourseBloc(getIt<FetchCourseUsecases>()));

  getIt.registerFactory(
      () => TutorBloc(getTutorUsecases: getIt<GetTutorUsecases>()));

  getIt.registerFactory(() => PurchasedBloc(getIt<PurchaseCourseUsecases>()));

  getIt.registerFactory(() => TopCoursesBloc(getIt<TopCourseUsecases>()));
  getIt.registerFactory(() => TopTutorsBloc(getIt<TopTutorsUsecases>()));

  getIt.registerFactory(() => ChatBloc(getIt<ChatUsecases>()));
  getIt.registerFactory(() => MentorBloc(getIt<ChatMentorsUsecases>()));
  getIt.registerFactory(() => FavoriteBloc(
      fetchFavoriteCourseUsecase: getIt<FetchFavoriteCourseUsecase>(),
      getFavouriteCourse: getIt<GetFavouriteCourse>(),
      isFavourite: getIt<IsFavourite>(),
      toggleFavourite: getIt<ToggleFavourite>()));
  getIt.registerFactory(() => LastChatBloc(getIt<LastChatUsecases>()));
  getIt.registerFactory(() => MyCoursesBloc(getIt<MyCoursesUsecases>()));
  getIt.registerFactory(() => NotificationBloc(
      getIt<SendNotificationUsecases>(), getIt<NotificationRepositories>()));
  getIt.registerFactory(() => GoogleAuthBloc(getIt<GoogleAuthUsecases>()));
}
