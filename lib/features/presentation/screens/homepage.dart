import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show AppBar, BorderRadius, BuildContext, CircleAvatar, CircularProgressIndicator, Colors, Column, Container, EdgeInsets, Expanded, GestureDetector, Icon, IconButton, Icons, InputDecoration, ListTile, ListView, MainAxisAlignment, MaterialApp, MaterialPageRoute, MediaQuery, MouseRegion, Navigator, NetworkImage, OutlineInputBorder, Padding, Scaffold, SizedBox, State, StatefulWidget, Text, TextEditingController, TextField, TextStyle, Widget;
import 'package:githubusers/features/presentation/screens/user_profile.dart';
import 'package:githubusers/features/presentation/widgets/infinite_scroll.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json;
import '../widgets/user_widget.dart';
import '../../Domain/entities/user.dart';
// import 'package:url_launcher/url_launcher.dart'

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState ();
}

class _HomePageState  extends State<HomePage>{

  final TextEditingController _controller = TextEditingController();
  List _users = [];
  bool _hasSearched = false;

  // Future<void> _launchURL(String url) async{
  //   final response = await http.get(Uri.parse(url));
  //
  //   if (response.statusCode == 200){
  //
  //   }
  // }

@override
void initState(){
  super.initState();
  _searchUsers('');

}
  Future<void> _searchUsers(String query) async {

    if (query.isEmpty){
      if (kDebugMode) {
        print('Searching');
      }
    }
    // final response = await http.get(Uri.parse("https://api.github.com/search/users?q=location:{location}"));
    final response = await http.get(Uri.parse("https://api.github.com/search/users?q=location:$query"));
    //final response = await http.get(Uri.parse("https://api.github.com/search/users?q=$query"));
    if (kDebugMode) {
      print(response);
    }

    if (response.statusCode == 200){
      final data = json.decode(response.body);
      if (kDebugMode) {
        print(response);
      }
      setState(() {
        _users = data['items'] ?? [];
        _hasSearched = true;
      });
    } else {
      throw Exception('Failed to load users');
    }
  }


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner : false,

        home: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.blue,
        title: const Text(
        'Search for GitHub Users',
          style: TextStyle(
          color: Colors.white,


          ),
    )


    ),


        body: Container(
          alignment: Alignment.center,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [

              const SizedBox(height: 40.0),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.80,
                height: MediaQuery.of(context).size.height * 0.12,
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)
                      ),
                      hintText: 'Search by Country',
                      hintStyle: const TextStyle(color: Colors.grey),
                      suffixIcon: IconButton( onPressed: (){
                        _searchUsers(_controller.text);
                      }, icon: const Icon(Icons.search)
                        ,)
                  ),
                ),
              ),

              Expanded(
                  child: _hasSearched && _users.isNotEmpty ? listOfNames()
                      : const Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Loading Users"),
                          SizedBox(height: 20.0,),
                          CircularProgressIndicator(),
                        ],
                      )),


            ],
          ),
        ),

      ),

    );

  }
  Widget listOfNames(){

    return ListView.builder(
      itemBuilder: (context, index){
        return MouseRegion(
          onEnter: (event){
            setState(() {
              _users[index]['isHovered'] = true;

            });
          },
          onExit: (event) {
            setState(() {
              _users[index]['isHovered'] = false;
            });
          },
          child: GestureDetector(
            onTap: () {
              // _launchURL(_users[index]['html_url']);
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (counter)=> UserProfile(user: _users[index])
                  ));
            },
            child: Container(
              color: _users[index]['isHovered'] == true ? Colors.orangeAccent[30] : Colors.transparent,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(_users[index]['avatar_url']),
                ),
                title: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(_users[index]['login']),
                ),              ),
            ),          ),
          );
        },
    );
  }

}
