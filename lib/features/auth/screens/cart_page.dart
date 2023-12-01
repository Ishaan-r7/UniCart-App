import 'package:flutter/material.dart';
import 'items_screen.dart';

class CartPage extends StatelessWidget {
  final List<Item> selectedItems;

  CartPage({required this.selectedItems});

  @override
  Widget build(BuildContext context) {
    // Calculate total bill value
    int totalBill = 0;
    for (var item in selectedItems) {
      totalBill += item.price * item.count;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: selectedItems.length,
              itemBuilder: (context, index) {
                final item = selectedItems[index];
                return ListTile(
                  leading: Image.asset(
                    'assets/images/${item.image}',
                    width: 80,
                    height: 80,
                  ),
                  title: Text(item.name),
                  subtitle:
                      Text('Price: Rs. ${item.price} | Count: ${item.count}'),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Total Bill: Rs. $totalBill',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
