//entities are business objects used throughout the app
//based on the url, we have login, type, repositories,followers, following--all under Items
import 'package:equatable/equatable.dart';


class UserEntity extends Equatable {
   final String ? login;
  final String ? name;
  final String ? avatarUrl;
  final String ? email;
  final String ? htmlUrl;
  final int ? followers;
  final int ? publicRepos;
  final int ? bio;
  final int ? blog;
  final String ? location;
  final String ? id;
  final String ? username;


  const UserEntity({
    this.login,
    this.name,
    this.avatarUrl,
    this.email,
    this.htmlUrl,
    this.followers,
    this.publicRepos,
    this.bio,
    this.blog,
    this.location,
    this.username,
    this.id,


  });

  @override
  List<Object?> get props {

    return [
      login,
      name,
      avatarUrl,
      email,
      htmlUrl,
      followers,
      publicRepos,
      bio,
      blog,
      location,
      username,
      id,

    ];
  }
}