import 'package:flutter/material.dart';
// import 'package:shopping_list/data/dummy_items.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/widgets/new_item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  final List<GroceryItem> _groceryItem = [];
  void _addItem() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (ctx) => const NewItem(),
      ),
    );

    if (newItem == null) {
      return;
    }
    setState(() {
      _groceryItem.add(newItem);
    });
  }

  @override
  Widget build(context) {
    Widget content = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Opps! Shopping List is empty",
            style:
                Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 20),
          ),
        ],
      ),
    );
    if (_groceryItem.isNotEmpty) {
      content = ListView.builder(
          itemCount: _groceryItem.length,
          itemBuilder: (ctx, index) {
            return Dismissible(
              background: Container(
                color: Theme.of(context).colorScheme.error.withOpacity(0.9),
                margin: const EdgeInsets.symmetric(horizontal: 16),
              ),
              key: Key(_groceryItem[index].id),
              onDismissed: (direction) {
                _groceryItem.removeAt(index);
                // show snackbar
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Remove Grocery Item From List"),
                  ),
                );
              },
              child: ListTile(
                title: Text(_groceryItem[index].name),
                leading: Container(
                  width: 24,
                  height: 24,
                  color: _groceryItem[index].category.color,
                ),
                trailing: Text(_groceryItem[index].quantity.toString()),
              ),
            );
          });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Groceries"),
        actions: [IconButton(onPressed: _addItem, icon: const Icon(Icons.add))],
      ),
      body: content,
    );
  }
}
