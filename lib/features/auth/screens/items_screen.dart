import 'package:flutter/material.dart';
import 'auth_screen.dart';
import 'cart_page.dart';

class Item {
  final String name;
  final String image;
  final int price;
  int count;

  Item({required this.name, required this.image, required this.price, this.count = 0});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'price': price,
      'count': count,
    };
  }

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      name: json['name'],
      image: json['image'],
      price: json['price'],
      count: json['count'],
    );
  }
}

class ItemsScreen extends StatefulWidget {
  @override
  _ItemsScreenState createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  List<Item> items = [
    Item(name: 'Notebook', image: 'Sai_book.png', price: 40),
    Item(name: 'Pen', image: 'pen_1.jpg', price: 10),
    Item(name: 'T-Shirt', image: 'sai_hoodie.jpeg', price: 500),
    Item(name: 'Coffee Mug', image: 'Sai_mug.png', price: 100),
    Item(name: 'Umbrella', image: 'umbrella.png', price: 250),
    // Add your items here...
  ];

  List<Item> selectedItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Items'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartPage(selectedItems: selectedItems),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 4.0,
              child: ListTile(
                leading: Image.asset('assets/images/${item.image}', width: 80, height: 80),
                title: Text(item.name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Price: Rs. ${item.price}'),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            setState(() {
                              if (item.count > 0) item.count--;
                              updateSelectedItems(item);
                            });
                          },
                        ),
                        Text(item.count.toString()),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            setState(() {
                              item.count++;
                              updateSelectedItems(item);
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void updateSelectedItems(Item item) {
    if (selectedItems.contains(item)) {
      selectedItems.remove(item);
      selectedItems.add(item);
    } else if (item.count > 0) {
      selectedItems.add(item);
    }
  }
}

void main() {
  runApp(MaterialApp(
    home: ItemsScreen(),
  ));
}
