class User {
  final String login;
  final String avatarUrl;
  final String email;
  final String htmlUrl;
  final int followers;
  final int publicRepos;

  User({
    required this.login,
    required this.avatarUrl,
    required this.email,
    required this.htmlUrl,
    required this.followers,
    required this.publicRepos,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(

      login: json['login'],
      avatarUrl: json['avatar_url'],
      email: json['login'],
      htmlUrl: json['html_url'],
      followers: json['followers'],
      publicRepos: json['public_repos'],
    );
  }
}