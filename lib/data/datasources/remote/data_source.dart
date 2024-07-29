import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../models/user_model.dart';

class DataSource {
  Future<List<UserModel>> fetchUsersByLocation(String? location,String? name, int page, int pageSize) async {
    String url = (name != null) ? "https://api.github.com/search/users?q=$name":
    "https://api.github.com/search/users?q=location:$location&page=$page&per_page=$pageSize";

    final response = await http.get(Uri.parse(url));

    if(response.statusCode==200) {
      final data = json.decode(response.body);
      return (data['items'] as List).map((item){
        return UserModel(
          name: item['login'],
          avatarUrl: item['avatarUrl'],
          email: item['email'],
          htmlUrl: item['html_url'],
          followers: item['login'],
          publicRepos: item['url'],
          bio: item['bio'],
          blog: item['blog'],
          location: item['location'],
          id: item['id'],
          username: item['username'],
        );
      }).toList();
    }
    else{
      throw Exception('Failed to load users: ${response.reasonPhrase}');
    }
  }


}