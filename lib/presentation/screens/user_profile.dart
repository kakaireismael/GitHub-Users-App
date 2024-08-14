import 'package:flutter/material.dart';
import 'package:github_users_app/presentation/widget/connectivity.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../utils/launch_url.dart';
import 'package:github_users_app/domain/entities/user_profile_entity.dart';
import '../providers/connectivity_provider.dart';
import 'package:url_launcher/url_launcher.dart';


class UserProfile extends StatelessWidget {
  final UserProfileEntity user;

  const UserProfile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final connectivityProvider = Provider.of<ConnectivityProvider>(context);

    if (!connectivityProvider.isConnected) {
      return connectivityWidget(context);
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          user.login ?? "",
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF2196F3),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.share,
              color: Colors.white,
            ),
            onPressed: () {
              Share.share(
                  'Share ${user.name} GitHub user profile using this link: ${user.htmlUrl}, ');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [

          Container(


              color: const Color(0xFFAFDAEF),
              width: double.infinity,
              height: 350.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 10),
                  CircleAvatar(
                    radius: 50.0,
                    backgroundImage: NetworkImage(
                      user.avatarUrl ?? "",
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '${user.name}',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)
                  ),
                  Text(" Location: "
                    '${user.location}',
                    style: const TextStyle(fontSize: 15),
                  ),

                  Text(" Email: "
                    '${user.email}',
                    style: const TextStyle(fontSize: 15),
                  ),

                  Text(" User Category: "
                      '${user.type}',
                    style: const TextStyle(fontSize: 15),
                  ),

                  const SizedBox(height: 20),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              '${user.publicRepos ?? 0}',
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                            ),
                            const Text(
                              "Repositories",
                              style: TextStyle(fontSize: 15),
                            )
                          ],
                        ),
                        Container(
                            width: 1.5,
                            height: 20.0,
                            color: Colors.black26,
                            margin:
                            const EdgeInsets.symmetric(horizontal: 10.0)),
                        Column(
                          children: [
                            Text('${user.followers ?? 0}',
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
                            const Text("Followers",
                                style: TextStyle(fontSize: 15))
                          ],
                        ),
                        Container(
                            width: 1.5,
                            height: 20.0,
                            color: Colors.black26,
                            margin:
                            const EdgeInsets.symmetric(horizontal: 10.0)),
                        Column(
                          children: [
                            Text(
                              '${user.following ?? 0}',
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                            ),
                            const Text("Following",
                                style: TextStyle(fontSize: 15))
                          ],
                        ),
                      ]),
                ],
              )),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Text(
                "Bio Info",
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),

              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, bottom: 15.0),
                child: Text(
                  user.bio ?? "No Bio Data Found",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontFamily: 'Montserrat',
                      height: 1.5),
                  selectionColor: Colors.black,
                ),
              ),

              const SizedBox(height: 20),
              const Text(
                "Blog",
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),

              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, bottom: 15.0),
                child: Text(
                  user.blog ?? "No Blog Details Found",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontFamily: 'Montserrat',
                      height: 1.5),
                  selectionColor: Colors.black,
                ),
              ),





              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _launchURL(user.htmlUrl ?? "");
                },
                style: TextButton.styleFrom(
                    surfaceTintColor: Colors.orangeAccent,
                    backgroundColor: const Color(0xFF2196F3)),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "View GitHub User Profile",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          )
        ]),
      ),
    );
  }
}

Future<void> _launchURL(String url) async {
  final Uri _url = Uri.parse(url);

  if (!await launchUrl(_url)) {
    throw 'Could not launch $_url';
  }
}

