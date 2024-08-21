import 'package:github_users_app/domain/entities/user_profile_entity.dart';
import '../repository/user_profile_rep.dart';

class UserDetailsUseCase {
  final UserProfileRep _userProfileRep;

  UserDetailsUseCase(this._userProfileRep);

  Future<UserProfileEntity> execute(String username) async {
    return await _userProfileRep.getUserProfile(username);
  }
}
