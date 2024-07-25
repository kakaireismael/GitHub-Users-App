// lib/widgets/infinite_scroll.dart
import 'package:flutter/material.dart';
import 'package:githubusers/features/presentation/providers/item_provider.dart';
import 'package:githubusers/features/Data/datasources/remote/item.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';


class InfiniteScroll extends StatefulWidget {
  const InfiniteScroll({super.key});

  @override
  InfiniteScrollState createState() => InfiniteScrollState();
}

class InfiniteScrollState extends State<InfiniteScroll> {
  final ItemProvider _itemProvider = ItemProvider();
  final ScrollController _scrollController = ScrollController();

  List<Item> _items = [];
  int _page = 0;
  bool _isLoading = false;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    fetchMoreItems();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        fetchMoreItems();
      }
    });
  }

  Future<void> fetchMoreItems() async {
    if (_isLoading || !_hasMore) return;

    setState(() {
      _isLoading = true;
    });

    final newItems = await _itemProvider.fetchItems(_page, 20);
    setState(() {
      _items.addAll(newItems);
      _isLoading = false;
      _page++;

      if (newItems.length < 20) {
        _hasMore = false;
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: _items.length, // +1 for the loading indicator
      itemBuilder: (context, index) {
        if (index == _items.length) {
          return _isLoading ? const Center(child: CircularProgressIndicator()) : Container();
        }

        final item = _items[index];
        return ListTile(
          title: Text(item.name),
        );
      },
    );
  }
}
