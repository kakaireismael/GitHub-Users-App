// lib/providers/item_provider.dart
import 'dart:async';
import 'package:githubusers/features/presentation/providers/item_provider.dart';
import 'package:githubusers/features/Data/datasources/remote/item.dart';

class ItemProvider {
  // Simulate fetching items from a server
  Future<List<Item>> fetchItems(int page, int limit) async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate network delay

    return List.generate(limit, (index) {
      int id = page * limit + index;
      return Item(id: id, name: 'Item $id');
    });
  }
}
