import 'package:github_users_app/domain/entities/user.dart';
import 'package:json_annotation/json_annotation.dart';
part "user_model.g.dart";

@JsonSerializable()
class UserModel extends User {
  const UserModel({
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

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  // Map<String, dynamic> toJson => _$UserToJson(this);

  User toEntity() {
    return User(
      login: login,
      name: name,
      htmlUrl: htmlUrl,
      publicRepos: publicRepos,
      type: type,
      avatarUrl: avatarUrl,
      followers: followers,
      location: location,
      email: email,
      following: following,
      bio: bio,
      blog: blog,

    );
  }
}