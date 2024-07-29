class User {
  final String login;
  final String name;
  final String avatarUrl;
  final String email;
  final String htmlUrl;
  final int followers;
  final int publicRepos;
  final int bio;
  final int blog;

  User({
    required this.login,
    required this.name,
    required this.avatarUrl,
    required this.email,
    required this.htmlUrl,
    required this.followers,
    required this.publicRepos,
    required this.bio,
    required this.blog

  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(

      login: json['login'],
      name: json['name'],
      avatarUrl: json['avatar_url'],
      email: json['login'],
      htmlUrl: json['html_url'],
      followers: json['followers'],
      publicRepos: json['public_repos'],
      bio: json['bio'],
      blog: json['blog'],
    );
  }
}