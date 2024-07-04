import 'package:flutter/material.dart';
import 'checkout.dart';
import 'dashboard.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;
  List<Map<String, dynamic>> cartItems = [];

  List<Map<String, dynamic>> bottomItems = [
    {
      "id": 0,
      "name": "Product",
      "activeImg": Icons.home,
      "inActiveImg": Icons.home_outlined,
    },
    {
      "id": 1,
      "name": "Checkout",
      "activeImg": Icons.shopping_cart,
      "inActiveImg": Icons.shopping_cart_outlined,
    },
  ];

  void addToCart(Map<String, dynamic> product) {
    setState(() {
      cartItems.add(product);
    });
  }

  void updateCart(List<Map<String, dynamic>> updatedCartItems) {
    setState(() {
      cartItems = updatedCartItems;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: showTopItem(),
            ),
            showBottomBar(),
          ],
        ),
      ),
    );
  }

  showTopItem() {
    if (selectedIndex == 0) {
      return Dashboard(addToCart: addToCart);
    } else if (selectedIndex == 1) {
      return Checkout(
        cartItems: cartItems,
        updateCart: updateCart,
        onCheckoutComplete: () {
          setState(() {
            selectedIndex = 0;
          });
        },
      );
    }
  }

  showBottomBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: selectedIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        items: bottomItems.map((item) {
          return BottomNavigationBarItem(
            icon: Icon(item["inActiveImg"]),
            activeIcon: Icon(item["activeImg"]),
            label: item["name"],
          );
        }).toList(),
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}
