import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:github_users_app/presentation/providers/user_provider.dart';
import 'package:github_users_app/presentation/widget/user_card.dart';
import 'package:github_users_app/presentation/providers/connectivity_provider.dart';
import 'package:provider/provider.dart';
import '../widget/connectivity.dart';
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

  bool hasSearched = false;
  int _page = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        Provider.of<UserProvider>(context, listen: false)
            .fetchUsers('', '', _page, 20);
      },
    );

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - _scrollThreshold) {
        final userProvider = Provider.of<UserProvider>(context, listen: false);

        userProvider.setHasMore(true);
        userProvider.fetchUsers(_locationController.text, '', ++_page, 20);
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
              Image.asset("assets/github_bg.webp",
              fit: BoxFit.cover,
              width: double.infinity,
              height: 100.0,

                ),

              Container(


                padding: const EdgeInsets.only(top: 18.0, bottom: 18.0),
                alignment: Alignment.center,
                color: const Color(0xFF2196F3),
                width: double.infinity,
                child: const Text(
                  'Search for GitHub Users',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(
                      left: 10.0, top: 10.0, right: 10.0, bottom: 10.0),
                  child: Row(children: [
                    Expanded(
                      child: TextField(
                        controller: _locationController,
                        decoration: InputDecoration(
                            labelText: 'Search by user location',
                            labelStyle: const TextStyle(fontSize: 14.0, color: Colors.black),


                            enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(4.0)
                              ),
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            suffixIcon: IconButton(
                                icon: const Icon(
                                  Icons.search,
                                  color: Colors.black,
                                  size: 25,
                                ),
                                onPressed: () {
                                  _locationController.clear();
                                  userProvider.clearFiltersAndSearch();
                                })),
                        onSubmitted: (value) {
                          userProvider.setLocation(value);
                        },
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: TextField(
                          controller: _nameController,
                          decoration: InputDecoration(
                              labelText: 'Search by username',
                              labelStyle: const TextStyle(fontSize: 14.0, color: Colors.black),
                              enabledBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(4.0),

                                ),
                                borderSide: BorderSide(
                                  color: Colors.black,

                                ),
                              ),
                              suffixIcon: IconButton(
                                  icon: const Icon(Icons.search,
                                      color: Colors.black, size: 25),
                                  onPressed: () {
                                    _nameController.clear();
                                    userProvider.clearFiltersAndSearch();
                                  })),
                          onSubmitted: (value) {
                            userProvider.setName(value);
                          }),
                    ),
                  ])),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, top: 0.0, right: 20.0, bottom: 20.0),
                  child: userProvider.isLoading
                      ? const Center(
                    child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.blue)),
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
                              }
                              )
                          : const Center(
                              child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.blue)),
                            ),
                ),
              ),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _locationController.dispose();
    _nameController.dispose();

    super.dispose();
  }
}
