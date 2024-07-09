import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       title: const Text('GITHUB USERS'),
        backgroundColor: Colors.orangeAccent,
      ),
       body:  Container(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search by location',
              hintStyle: const TextStyle(color:Colors.white),
              suffixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
                  // other TextField properties
            ),
            onChanged: (String text) {
              setState(() {
                searchText = text;
                // Perform search operations based on 'text'
                // For example, filter a list or update a ListView
              }
              );
            },
          ),
        ),
      backgroundColor: Colors.black,
    );

  }
}
