import 'package:github_users_app/domain/entities/user_profile_entity.dart';

abstract class UserProfileRep {
  Future<UserProfileEntity> getUserProfile(String username);
}
