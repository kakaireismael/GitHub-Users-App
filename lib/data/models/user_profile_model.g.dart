// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfileModel _$UserProfileModelFromJson(Map<String, dynamic> json) =>
    UserProfileModel(
      login: json['login'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      htmlUrl: json['htmlUrl'] as String?,
      type: json['type'] as String?,
      bio: json['bio'] as String?,
      location: json['location'] as String?,
      publicRepos: (json['publicRepos'] as num?)?.toInt(),
      avatarUrl: json['avatarUrl'] as String?,
      followers: (json['followers'] as num?)?.toInt(),
      following: (json['following'] as num?)?.toInt(),
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
