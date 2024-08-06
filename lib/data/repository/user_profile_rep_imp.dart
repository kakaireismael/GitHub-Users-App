import 'package:github_users_app/data/datasources/remote/details_source.dart';
import 'package:github_users_app/domain/entities/user_profile_entity.dart';
import 'package:github_users_app/domain/repository/user_profile_rep.dart';
import '../models/user_profile.dart';

class UserprofileRepImp implements UserProfileRep {
  final DetailsSource _detailsSource;

  UserprofileRepImp(this._detailsSource);

  @override
  Future<UserProfileEntity> getUserProfile(String username) async {
    UserProfileModel userProfileModel =
        await _detailsSource.fetchUserDetails(username);

    return userProfileModel.toProfileEntity();
  }
}
