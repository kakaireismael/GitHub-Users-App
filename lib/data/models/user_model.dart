import 'package:github_users_app/domain/entities/user.dart';
import 'package:json_annotation/json_annotation.dart';
part "user_model_json_sg.dart";

@JsonSerializable()
class UserModel extends User {
  const UserModel({
    super.name,
    super.url,
    super.type,
    super.avatarUrl,
    super.blog,

  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  // Map<String, dynamic> toJson => _$UserToJson(this);

  User toEntity() {
    return User(
      name: name,
      avatarUrl: avatarUrl,
      type: type,
      blog: blog,

    );
  }
}