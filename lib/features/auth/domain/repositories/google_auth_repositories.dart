
import 'package:growmind/features/auth/domain/entities/auth_user.dart';

abstract class GoogleAuthRepositories {
  Future<GoogleAuthUser?> signInWithGoogle();
  Future<void> signOut();
}
