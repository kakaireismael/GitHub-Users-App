import 'package:equatable/equatable.dart';

class UserProfileEntity extends Equatable {
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

  const UserProfileEntity(
      {
        this.login,
        this.name,
        this.avatarUrl,
        this.htmlUrl,
        this.publicRepos,
        this.type,
        this.followers,
        this.location,
        this.email,
        this.following,
        this.bio,
        this.blog});

  @override
  List<Object?> get props {
    //decides wc objects we should consider for comparison
    return [
      login,
      name,
      avatarUrl,
      htmlUrl,
      bio,
      location,
      email,
      following,
      publicRepos,
      followers,
      blog,
    ];
  }
}
