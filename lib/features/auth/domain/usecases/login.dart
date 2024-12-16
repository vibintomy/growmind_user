import 'package:growmind/features/auth/domain/entities/user.dart';
import 'package:growmind/features/auth/domain/repositories/auth_repositories.dart';

class Login {
  final AuthRepository repository;
  Login(this.repository);
  Future<User> execute(String email, String password) {
    return repository.login(email, password);
  }
}
