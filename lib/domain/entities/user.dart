import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? name;
  final String? url;
  final String? avatarUrl;
  final String? type;
  final String? blog;

  const User({
    this.avatarUrl,
    this.url,
    this.type,
    this.name,
    this.blog,
  });

  @override
  List<Object?> get props {
    return [
      name,
      avatarUrl,
      type,
      url,
      blog,
    ];
  }
}
