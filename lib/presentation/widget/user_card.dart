import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_profile_provider.dart';
import '../screens/user_profile.dart';
import '../providers/user_provider.dart';

Widget userCard(context, index) {
  final userProvider = Provider.of<UserProvider>(context);

  return Card(
      color: const Color(0xFFf4f4ff),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(08.0)),
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      child: GestureDetector(
        onTap: () async {
          final userProfileProvider =
              Provider.of<UserProfileProvider>(context, listen: false);
          await userProfileProvider
              .fetchUserProfile(userProvider.users[index].name ?? '');

          if (userProfileProvider.user != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    UserProfile(user: userProfileProvider.user!),
              ),
            );
          } else {
            // Handle the case where the user profile is null
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('User profile failed to initialize'),
            ));
          }
        },
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
                userProvider.users[index].avatarUrl ??
                    'https://via.placeholder.com/200'),
          ),
          title: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(userProvider.users[index].name ?? 'Unknown user'),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(userProvider.users[index].type ?? 'Unknown type'),
          ),
        ),
      ));
}