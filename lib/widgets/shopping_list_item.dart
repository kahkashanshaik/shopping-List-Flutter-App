import 'package:flutter/material.dart';
import 'package:shopping_list/models/grocery_item.dart';

class ShoppingListItem extends StatelessWidget {
  const ShoppingListItem({super.key, required this.groceryItem});

  final GroceryItem groceryItem;

  @override
  Widget build(context) {
    return SizedBox(
      height: 40,
      child: Row(
        children: [
          Text(groceryItem.name),
          Row(
            children: [Text(groceryItem.quantity.toString())],
          )
        ],
      ),
    );
  }
}
