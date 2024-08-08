import 'package:github_users_app/domain/repository/user_repository.dart';
import '../entities/user.dart';

class GetUsersUseCase {
  final UserRepository _userRepository;

  GetUsersUseCase(this._userRepository);

  Future<List<User>> execute(
      String? bio, String? location, String? name, int page, int pageSize) async {
    return await _userRepository.getUsers(bio, location, name, page, pageSize);
  }
}
