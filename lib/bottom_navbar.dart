import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class AppFooter extends StatefulWidget {
  final MyHomePage homePage;
  final FavoritesPage favoritesPage;
  final CartPage cartPage;
  final HistoryPage historyPage; // Add this

  AppFooter({required this.homePage, required this.favoritesPage, required this.cartPage, required this.historyPage}); // Add historyPage here

  @override
  _AppFooterState createState() => _AppFooterState();
}

class _AppFooterState extends State<AppFooter> {
  int index = 0;

  // Define your pages
  List<Widget> pages = [];

  @override
  void initState() {
    super.initState();
    pages = [widget.homePage, widget.favoritesPage, widget.cartPage, widget.historyPage]; // Add historyPage here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (int index) {
          setState(() {
            this.index = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History', // Add this
          ),
        ],
      ),
    );
  }
}
