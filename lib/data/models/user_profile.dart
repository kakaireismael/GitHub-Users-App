import 'package:github_users_app/domain/entities/user_profile_entity.dart';

class UserProfileModel extends UserProfileEntity {
  const UserProfileModel({
    super.login,
    super.name,
    super.email,
    super.htmlUrl,
    super.type,
    super.bio,
    super.location,
    super.publicRepos,
    super.avatarUrl,
    super.followers,
    super.following,
    super.blog,

  });

  factory UserProfileModel.fromJson(Map<String, dynamic> map) {
    return UserProfileModel(
      login: map['login'] ?? "",
      name: map['name'] ?? "",
      htmlUrl: map['html_url'] ?? "",
      bio: map['bio'] ?? '',
      publicRepos: map['public_repos'] ?? 0,
      location: map['location'] ?? '',
      type: map['type'] ?? '',
      email: map['email'] ?? "",
      avatarUrl: map['avatar_url'] ?? "",
      followers: map['followers'] ?? 0,
      following: map['following'] ?? 0,
      blog: map['blog'] ?? '',

    );
  }

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
