import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:github_users_app/presentation/providers/user_provider.dart';
import 'package:github_users_app/presentation/widget/user_card.dart';
import 'package:github_users_app/presentation/providers/connectivity_provider.dart';
import 'package:provider/provider.dart';
import '../widget/connectivity.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  final ScrollController _scrollController = ScrollController();
  static const double _scrollThreshold = 200.0;

  int _page = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserProvider>(context, listen: false)
          .fetchUsers('', '', _page, 20);
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - _scrollThreshold) {
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setHasMore(true);
        userProvider.fetchUsers(
            _locationController.text, _nameController.text, ++_page, 20);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final connectivityProvider = Provider.of<ConnectivityProvider>(context);

    if (!connectivityProvider.isConnected) {
      return connectivityWidget(context);
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            Image.asset(
              "assets/github_bg.webp",
              fit: BoxFit.cover,
              width: double.infinity,
              height: 100.0,
            ),
            Container(
              padding: const EdgeInsets.only(top: 3.0, bottom: 3.0),
              alignment: Alignment.center,
              color: const Color(0xFF2196F3),
              width: double.infinity,
              child: const ListTile(
                title: Text(
                  'Search for GitHub Users',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  'Get connected to any user from anywhere around the world',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  TextField(
                    controller: _locationController,
                    cursorColor: Colors.black54,
                    style: const TextStyle(color: Colors.black54),
                    decoration: InputDecoration(
                      labelText: 'Search by user location',
                      hintText: 'e.g. Uganda',
                      hintStyle: const TextStyle(color: Colors.black54),
                      labelStyle: const TextStyle(
                          fontSize: 14.0, color: Colors.black54),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        borderSide: BorderSide(color: Colors.black54, width: 1.0),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        borderSide: BorderSide(color: Colors.black54, width: 1.0),
                      ),
                      prefixIcon: const Icon(Icons.search, color: Colors.black54),
                      suffixIcon: _locationController.text.isNotEmpty
                          ? IconButton(
                        icon: const Icon(
                          Icons.clear_rounded,
                          color: Colors.black54,
                          size: 25,
                        ),
                        onPressed: () {
                          _locationController.clear();
                          userProvider.clearFiltersAndSearch();
                          setState(() {}); // Redraw to remove the icon
                        },
                      )
                          : null,
                    ),
                    onChanged: (value) {
                      setState(() {}); // Redraw to update the icon
                    },
                    onSubmitted: (value) {
                      userProvider.setLocation(value);
                    },
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _nameController,
                    cursorColor: Colors.black54,
                    style: const TextStyle(color: Colors.black54),
                    decoration: InputDecoration(
                      labelText: 'Search by username',
                      hintText: 'e.g. kakaireismael',
                      hintStyle: const TextStyle(color: Colors.black54),
                      labelStyle: const TextStyle(
                          fontSize: 14.0, color: Colors.black54),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        borderSide: BorderSide(color: Colors.black54, width: 1.0),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        borderSide: BorderSide(color: Colors.black54, width: 1.0),
                      ),
                      prefixIcon: const Icon(Icons.search, color: Colors.black54),
                      suffixIcon: _nameController.text.isNotEmpty
                          ? IconButton(
                        icon: const Icon(
                          Icons.clear_rounded,
                          color: Colors.black54,
                          size: 25,
                        ),
                        onPressed: () {
                          _nameController.clear();
                          userProvider.clearFiltersAndSearch();
                          setState(() {}); // Redraw to remove the icon
                        },
                      )
                          : null,
                    ),
                    onChanged: (value) {
                      setState(() {}); // Redraw to update the icon
                    },
                    onSubmitted: (value) {
                      userProvider.setName(value);
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, top: 0.0, right: 20.0, bottom: 20.0),
                child: userProvider.isLoading
                    ? const Center(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.blue)),
                )
                    : userProvider.hasSearched ||
                    userProvider.users.isNotEmpty
                    ? ListView.builder(
                    controller: _scrollController,
                    itemCount: userProvider.users.length,
                    itemBuilder: (context, index) {
                      if (kDebugMode) {
                        print(
                            'List length: ${userProvider.users.length}, Current index: $index');
                      }
                      return userCard(context, index);
                    })
                    : const Center(
                  child: CircularProgressIndicator(
                      valueColor:
                      AlwaysStoppedAnimation(Colors.blue)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _locationController.dispose();
    _nameController.dispose();
    super.dispose();
  }
}
