import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:growmind/core/utils/cloudinary.dart';
import 'package:growmind/features/chat/data/datasource/chat_mentor_datasource_impl.dart';
import 'package:growmind/features/chat/data/datasource/chat_remot_datasource_impl.dart';
import 'package:growmind/features/chat/data/datasource/chat_remote_datasource.dart';
import 'package:growmind/features/chat/data/repository/chat_mentor_repo_impl.dart';
import 'package:growmind/features/chat/data/repository/chat_repo_impl.dart';
import 'package:growmind/features/chat/domain/repositories/chat_mentor_repositories.dart';
import 'package:growmind/features/chat/domain/repositories/chat_repositories.dart';
import 'package:growmind/features/chat/domain/usecases/chat_mentors_usecases.dart';
import 'package:growmind/features/chat/domain/usecases/chat_usecases.dart';
import 'package:growmind/features/chat/presentation/bloc/chat_bloc/chat_bloc.dart';
import 'package:growmind/features/chat/presentation/bloc/mentor_bloc/mentor_bloc.dart';
import 'package:growmind/features/home/data/datasource/categories_remote_datasource.dart';
import 'package:growmind/features/home/data/datasource/purchased_course_datasource.dart';
import 'package:growmind/features/home/data/datasource/tutor_remote_datasource.dart';
import 'package:growmind/features/home/data/repo/categories_repo_impl.dart';
import 'package:growmind/features/home/data/repo/fetch_course_repo_impl.dart';
import 'package:growmind/features/home/data/repo/purchased_course_repo_impl.dart';
import 'package:growmind/features/home/data/repo/top_courses_repoo_impl.dart';
import 'package:growmind/features/home/data/repo/top_tutors_repo_impl.dart';
import 'package:growmind/features/home/data/repo/tutor_repo_impl.dart';
import 'package:growmind/features/home/domain/repositories/category_repository.dart';
import 'package:growmind/features/home/domain/repositories/fetch_course_repo.dart';
import 'package:growmind/features/home/domain/repositories/purchased_course_repository.dart';
import 'package:growmind/features/home/domain/repositories/top_courses_repo.dart';
import 'package:growmind/features/home/domain/repositories/top_tutors_repo.dart';
import 'package:growmind/features/home/domain/repositories/tutor_repository.dart';
import 'package:growmind/features/home/domain/usecases/category_usecases.dart';
import 'package:growmind/features/home/domain/usecases/fetch_course_usecases.dart';
import 'package:growmind/features/home/domain/usecases/get_tutor_usecases.dart';
import 'package:growmind/features/home/domain/usecases/purchase_course_usecases.dart';
import 'package:growmind/features/home/domain/usecases/top_course_usecases.dart';
import 'package:growmind/features/home/domain/usecases/top_tutors_usecases.dart';
import 'package:growmind/features/home/presentation/bloc/fetch_categories_bloc/fetch_categories_bloc.dart';
import 'package:growmind/features/home/presentation/bloc/fetch_course_bloc/fetch_course_bloc.dart';
import 'package:growmind/features/home/presentation/bloc/get_tutor_bloc/tutor_bloc.dart';
import 'package:growmind/features/home/presentation/bloc/purchased_bloc/purchased_bloc.dart';
import 'package:growmind/features/home/presentation/bloc/top_courses_bloc/top_courses_bloc.dart';
import 'package:growmind/features/home/presentation/bloc/top_tutors_bloc/top_tutors_bloc.dart';
import 'package:growmind/features/profile/data/datasource/profile_remote_datasource.dart';
import 'package:growmind/features/profile/data/repo/profile_repo.dart';
import 'package:growmind/features/profile/data/repo/update_profile_repoimpl.dart';
import 'package:growmind/features/profile/domain/repo/profile_repo.dart';
import 'package:growmind/features/profile/domain/repo/update_profile_repo.dart';
import 'package:growmind/features/profile/domain/usecases/get_profile.dart';
import 'package:growmind/features/profile/domain/usecases/update_profile_usecases.dart';
import 'package:growmind/features/profile/presentation/bloc/profile_bloc/bloc/profile_bloc.dart';
import 'package:growmind/features/profile/presentation/bloc/update_profile_bloc/bloc/update_profile_bloc.dart';

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

  getIt.registerLazySingleton<ChatRemotDatasourceimpl>(
      () => ChatRemotDatasourceimpl(getIt<FirebaseFirestore>()));

  getIt.registerLazySingleton<ChatRepositories>(
      () => ChatRepoImpl(getIt<ChatRemotDatasourceimpl>()));

  getIt.registerLazySingleton<ChatMentorDatasourceImpl>(
      () => ChatMentorDatasourceImpl(getIt<FirebaseFirestore>()));
  getIt.registerLazySingleton<ChatMentorRepositories>(
      () => ChatMentorRepoImpl(getIt<ChatMentorDatasourceImpl>()));

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
  getIt
      .registerLazySingleton(() => ChatMentorsUsecases(getIt<ChatMentorRepositories>()));
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
}
