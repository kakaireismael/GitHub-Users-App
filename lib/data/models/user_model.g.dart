// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      login: json['login'] as String?,
      name: json['login'] as String?,
      htmlUrl: json['html_url'] as String?,
      publicRepos: (json['public_repos'] as num?)?.toInt(),
      type: json['type'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      followers: (json['followers'] as num?)?.toInt(),
      location: json['location'] as String?,
      email: json['email'] as String?,
      following: (json['following'] as num?)?.toInt(),
      bio: json['bio'] as String?,
      blog: json['blog'] as String?,
    );

