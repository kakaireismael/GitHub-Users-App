import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class InfiniteScrollExample extends StatefulWidget {
  const InfiniteScrollExample({super.key});

  @override
  State<InfiniteScrollExample> createState() => _InfiniteScrollExampleState();
}

class _InfiniteScrollExampleState extends State<InfiniteScrollExample> {
  final int _pageSize = 20;

  final PagingController<int, dynamic> _pagingController =
  PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      // get api /beers list from pages 
      final newItems = await RemoteApi.getBeerList(pageKey as String, _pageSize);
      // Check if it is last page 
      final isLastPage = newItems!.length < _pageSize;
      // If it is last page then append last page else append new page 
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        // Appending new page when it is not last page 
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    }
    // Handle error in catch 
    catch (error) {
      if (kDebugMode) {
        print(_pagingController.error);
      }
      // Sets the error in controller 
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) =>
      // Refrsh Indicator pull down 
  RefreshIndicator(
    onRefresh: () => Future.sync(
      // Refresh through page controllers 
          () => _pagingController.refresh(),
    ),
    child: Scaffold(
      appBar: AppBar(
        title: const Text(""),
      ),
      // Page Listview with divider as a separation 
      body: PagedListView<int, dynamic>.separated(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<dynamic>(
          animateTransitions: true,
          itemBuilder: (_, item, index) => ListTile(
            leading: CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(item["image_url"]),
            ),
            title: Text(item["name"]),
          ),
        ),
        separatorBuilder: (_, index) => const Divider(),
      ),
    ),
  );

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}

class RemoteApi {
  static Future<List<dynamic>?> getBeerList(
      String query, int pageSize
      ) async {
    try {
      // Request the API on url 
      final response = await http.get(Uri.parse("https://api.github.com/search/users?q=location:$query"));
      if (response.statusCode == 200) {
        // Decode the response 
        final mybody = jsonDecode(response.body);
        return mybody;
      }
    } catch (e) {
      print("Error $e");
    }
    return null;
  }
}
