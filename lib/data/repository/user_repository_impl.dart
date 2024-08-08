import 'package:github_users_app/data/dataSources/remote/data_source.dart';
import 'package:github_users_app/data/models/user_model.dart';
import 'package:github_users_app/domain/entities/user.dart';
import 'package:github_users_app/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final DataSource _dataSource;

  UserRepositoryImpl(this._dataSource);

  @override
  Future<List<User>> getUsers(
      String? bio, String? location, String? name, int page, int pageSize) async {
    List<UserModel> userModels =
        await _dataSource.fetchUsersByLocation(location, name, page, pageSize);

    return userModels.map((userModel) => userModel.toEntity()).toList();
  }
}
