import 'package:growmind/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:growmind/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:growmind/features/auth/domain/entities/user.dart';
import 'package:growmind/features/auth/domain/repositories/auth_repositories.dart';

class AuthRepositorieImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositorieImpl(
      {required this.localDataSource, required this.remoteDataSource});

  @override
  Future<User> login(String email, String password) async {
    final UserModel = await remoteDataSource.login(email, password);
    await localDataSource.cacheUser(UserModel);
    return User(id: UserModel.id, email: UserModel.email);
  }

  @override
  Future<User> signup(String email, String password, String displayName,String phone) async {
    final UserModel =
        await remoteDataSource.signup(email, password, displayName,phone);
    await localDataSource.cacheUser(UserModel);
    return User(id: UserModel.id, email: UserModel.email);
  }
}
