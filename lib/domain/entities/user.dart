import 'package:equatable/equatable.dart';

class User extends Equatable {

  final String? login;
  final String? name;
  final String? htmlUrl;
  final int? publicRepos;
  final String? type;
  final String? avatarUrl;
  final int? followers;
  final String? location;
  final String? email;
  final int? following;
  final String? bio;
  final String? blog;

  const User({
    this.login,
    this.name,
    this.htmlUrl,
    this.publicRepos,
    this.type,
    this.avatarUrl,
    this.followers,
    this.location,
    this.email,
    this.following,
    this.bio,
    this.blog
  });

  @override
  List<Object?> get props {
    return [
      login,
      name,
      htmlUrl,
      publicRepos,
      type,
      avatarUrl,
      followers,
      location,
      email,
      following,
      bio,
      blog,
    ];
  }
}
