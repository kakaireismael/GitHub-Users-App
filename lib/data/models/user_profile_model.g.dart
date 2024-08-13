// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfileModel _$UserProfileModelFromJson(Map<String, dynamic> json) =>
    UserProfileModel(
      login: json['login'] as String?,
      name: json['name'] as String?,
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

Map<String, dynamic> _$UserProfileModelToJson(UserProfileModel instance) =>
    <String, dynamic>{
      'login': instance.login,
      'name': instance.name,
      'htmlUrl': instance.htmlUrl,
      'publicRepos': instance.publicRepos,
      'type': instance.type,
      'avatarUrl': instance.avatarUrl,
      'followers': instance.followers,
      'location': instance.location,
      'email': instance.email,
      'following': instance.following,
      'bio': instance.bio,
      'blog': instance.blog,
    };
