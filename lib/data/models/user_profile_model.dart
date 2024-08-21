import 'package:github_users_app/domain/entities/user_profile_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_profile_model.g.dart';

@JsonSerializable()
class UserProfileModel extends UserProfileEntity {
  const UserProfileModel({
    super.login,
    super.name,
    super.htmlUrl,
    super.publicRepos,
    super.type,
    super.avatarUrl,
    super.followers,
    super.location,
    super.email,
    super.following,
    super.bio,
    super.blog,

  });

  // Factory method for creating a new `UserProfileModel` instance from a map.
  factory UserProfileModel.fromJson(Map<String, dynamic> map) =>
      _$UserProfileModelFromJson(map);

  // Method to convert the `UserProfileModel` instance to a map.
  Map<String, dynamic> toJson() => _$UserProfileModelToJson(this);

  // Method to convert `UserProfileModel` to `UserProfileEntity`.
  UserProfileEntity toProfileEntity() {
    return UserProfileEntity(
      login: login,
      name: name,
      htmlUrl: htmlUrl,
      avatarUrl: avatarUrl,
      bio: bio,
      publicRepos: publicRepos,
      location: location,
      type: type,
      email: email,
      followers: followers,
      following: following,
      blog: blog,
    );
  }
}
