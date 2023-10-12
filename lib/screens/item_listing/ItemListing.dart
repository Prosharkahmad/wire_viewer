import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:wire_viewer/models/Item.dart';

class ItemListing extends StatelessWidget {
  ItemListing({
    required this.list_items,
    required this.itemSelectedCallback,
    this.selectedItem,
  });

  final ValueChanged<Item> itemSelectedCallback;
  final List<Item> list_items;
  final Item? selectedItem;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: list_items.map((item) {
        return ListTile(
          title: Text(
            item.title,
            style: TextStyle(
              fontSize: 14.0,
            ),
          ),
          onTap: () => itemSelectedCallback(item),
          selected: selectedItem == item,
        );
      }).toList(),
    );
  }
}
