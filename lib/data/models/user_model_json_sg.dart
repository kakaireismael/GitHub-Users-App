part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      name: json['login'] as String?,
      url: json['url'] as String?,
      type: json['type'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      blog: json['blog'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
      'avatar_url': instance.avatarUrl,
      'type': instance.type,
      'blog': instance.blog,
    };
