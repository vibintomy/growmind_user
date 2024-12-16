import 'package:growmind/features/profile/domain/entities/profile.dart';
import 'package:growmind/features/profile/domain/repo/profile_repo.dart';

class GetProfile {
  final ProfileRepo repo;
  GetProfile(this.repo);

  Future<Profile> call(String userId) {
    return repo.getProfile(userId);
  }
}
