import 'package:githubusers/domain/entities/user_entity.dart';

class UserModel extends UserEntity{
  const UserModel({
    super.name,
    super.avatarUrl,
    super.email,
    super.htmlUrl,
    super.followers,
    super.publicRepos,
    super.bio,
    super.blog,
    super.location,
    super.id,
    super.username,


  });

  factory UserModel.fromJson(Map <String, dynamic> map){
    return UserModel(
      name: map['login'] ?? "",
      avatarUrl: map['url'] ?? "",
      email: map['email'] ?? "",
      htmlUrl: map['html_url'] ?? "",
      followers: map['login'] ?? "",
      publicRepos: map['url'] ?? "",
      bio: map['bio'] ?? "",
      blog: map['blog'] ?? "",
      location: map['location'] ?? "",
      id: map['id'] ?? "",
      username: map['username'] ?? "",


    );
  }
  UserEntity toEntity() {
    return UserEntity(
      name: name,
      avatarUrl: avatarUrl,
      email: email,
      htmlUrl: htmlUrl,
      followers: followers,
      publicRepos: publicRepos,
      bio: bio,
      blog: blog,
      location: location,
      id: id,
      username: username,
    );
  }
}