import 'package:github_users_app/domain/entities/user.dart';
//domain layer only contains the interfaces

abstract class UserRepository {
  Future<List<User>> getUsers(
      String? location, String? name, int page, int pageSize);
}
