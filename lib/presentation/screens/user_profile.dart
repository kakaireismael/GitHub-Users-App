import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:share/share.dart';
import 'user_profile.dart';
// import 'package:share_plus/share_plus.dart';


class UserProfile extends StatelessWidget {
  final Map user;

  const UserProfile({super.key, required this.user});


  Future<Map<String, dynamic>> fetchUserDetails(String username) async {
    final response = await http.get(Uri.parse('https://api.github.com/users/$username'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load user details');
    }
  }
  //
  // void shareDetails(){
  //   final String details = 'Check out this Github User:\n\n '
  //       'Name: ${userDetails['login']}'
  //       'Email: ${userDetails['email']}'
  //       'Followers: ${userDetails['followers']}'
  //
  //       Share.share(details);
  //
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchUserDetails(user['login']),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return

            Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.blue,
                title: Text(user['login'],
                style: const TextStyle(
                  color: Colors.white,

                )
                ),

              ),
              body: const Center(
                child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.blue)),
              ),
            );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue,
              title: Text(user['login'],
                  style: const TextStyle(
                    color: Colors.white,

                  )
              ),

            ),
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else if (!snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue,
              title: Text(user['login'],
                  style: const TextStyle(
                    color: Colors.white,


                  )
              ),

            ),
            body: const Center(
              child: Text('No data found'),
            ),
          );
        } else {
          final userDetails = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue,
              title: Text(user['login'],
                  style: const TextStyle(
                    color: Colors.white,

                  )
              ),

                          actions: [
                          const BackButton(color: Colors.white,
                          style: ButtonStyle(alignment: Alignment.topLeft),),


                            IconButton(icon: const Icon(Icons.share),color: Colors.white,

                  onPressed: (){
                    Share.share(userDetails['html_url']);
                  },
                ),
              ],
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ClipOval(

                      child: Container(
                        color: Colors.blue,
                        //width: double.infinity,
                        child: SizedBox(
                          width: 140,
                          height: 140,
                          child: Image.network(userDetails['avatar_url'], fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    Text(
                      'Username: ${userDetails['login']}',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Name: ${userDetails['name']}',
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height:12),
                    Text(
                      'Location: ${userDetails['location']}',
                      style: const TextStyle(fontSize: 14 , ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Email: ${userDetails['email']}',
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'User Type: ${userDetails['type']}',
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Followers: ${userDetails['followers']}',
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Following: ${userDetails['following']}',
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Public Repositories: ${userDetails['public_repos']}',
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Blog: ${userDetails['blog']}',
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Bio: ${userDetails['bio']}',
                      style: const TextStyle(fontSize: 14),
                    ),
                    Text(
                      'Profile URL: ${userDetails['html_url']}',
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),

                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }


}
