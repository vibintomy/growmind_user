import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:growmind/core/utils/cloudinary.dart';
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
  
// Domain Layer
 getIt.registerLazySingleton(() => GetProfile(repo: getIt<ProfileRepo>()));
      getIt.registerLazySingleton(
      () => UpdateProfileUsecases(getIt<UpdateProfileRepo>()));
  // Presentation Layer
  
  getIt.registerFactory(() => ProfileBloc(getIt<GetProfile>()));
   getIt
      .registerFactory(() => ProfileUpdateBloc(getIt<UpdateProfileUsecases>()));
}
