import 'package:flutter/foundation.dart';
import 'package:github_users_app/domain/entities/user_profile_entity.dart';
import 'package:github_users_app/domain/use_cases/user_details_useCase.dart';

class UserProfileProvider extends ChangeNotifier {
  final UserDetailsUseCase _userDetailsUseCase;

  UserProfileProvider(this._userDetailsUseCase);

  UserProfileEntity? _user;

  UserProfileEntity? get user => _user;

  Future<void> fetchUserProfile(String username) async {
    try {
      final user = await _userDetailsUseCase.execute(username);
      _showUserDetails(user);
    } catch (e) {
      if (kDebugMode) {
        print('Failed to fetch user profile: $e');
      }
      _user = null;
    }
    notifyListeners();
  }

  void _showUserDetails(UserProfileEntity user) {
    _user = user;
    notifyListeners();
  }
}
