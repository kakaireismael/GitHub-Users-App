// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      name: json['name'] as String?,
      url: json['url'] as String?,
      type: json['type'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      blog: json['blog'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
      'avatarUrl': instance.avatarUrl,
      'type': instance.type,
      'blog': instance.blog,
    };
