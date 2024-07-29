import 'package:githubusers/domain/entities/user_entity.dart';
//domain layer only contains the interfaces

abstract class UserRepository{
  Future<List<UserEntity>> getUsers(String? location, String? name, int page, int pageSize);

}