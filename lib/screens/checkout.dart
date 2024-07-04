import 'package:flutter/material.dart';
import 'home.dart';

class Checkout extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;
  final Function(List<Map<String, dynamic>>) updateCart;
  final VoidCallback onCheckoutComplete;

  const Checkout({
    required this.cartItems,
    required this.updateCart,
    required this.onCheckoutComplete,
    super.key,
  });

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  late List<Map<String, dynamic>> _cartItems;

  @override
  void initState() {
    super.initState();
    _cartItems = widget.cartItems.map((item) {
      return {
        ...item,
        'quantity': item['quantity'] ?? 1, // Default quantity to 1 if null
      };
    }).toList();
  }

  double calculateTotal() {
    double totalPrice = 0;
    for (var item in _cartItems) {
      double itemPrice = double.parse(item['price']);
      int itemQuantity = item['quantity'] ?? 1;
      totalPrice += itemPrice * itemQuantity;
    }
    return totalPrice;
  }

  void incrementQuantity(int index) {
    setState(() {
      _cartItems[index]['quantity']++;
    });
    widget.updateCart(_cartItems);
  }

  void decrementQuantity(int index) {
    if (_cartItems[index]['quantity'] > 1) {
      setState(() {
        _cartItems[index]['quantity']--;
      });
      widget.updateCart(_cartItems);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Quantity can\'t be less than 1'),
        ),
      );
    }
  }

  void removeItemFromCart(int index) {
    setState(() {
      _cartItems.removeAt(index);
    });
    widget.updateCart(_cartItems);
  }

  void showOrderSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 60,
              ),
              SizedBox(height: 20),
              Text(
                'Order Successful',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  widget.updateCart([]); // Clear the cart
                  widget
                      .onCheckoutComplete(); // Notify that checkout is complete
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => Home()),
                    (Route<dynamic> route) => false,
                  );
                },
                child: Text('Close'),
              ),
            ],
          ),
        );
      },
    );
  }

  void handleCheckout() {
    if (_cartItems.isEmpty || calculateTotal() == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You haven\'t added anything to the cart.'),
        ),
      );
    } else {
      showOrderSuccessDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Checkout',
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _cartItems.length,
              itemBuilder: (context, index) {
                var item = _cartItems[index];
                return Dismissible(
                  key: Key(item['id'].toString()),
                  direction: DismissDirection.horizontal,
                  onDismissed: (direction) {
                    removeItemFromCart(index);
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  secondaryBackground: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  child: ListTile(
                    leading: Image.asset(item['image']),
                    title: Text(item['name']),
                    subtitle: Text('Price: \₦${item['price']}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () => decrementQuantity(index),
                        ),
                        Text('${item['quantity']}'),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () => incrementQuantity(index),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Total: \₦${calculateTotal().toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: handleCheckout,
              child: Container(
                height: 40,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.green,
                ),
                child: const Center(
                  child: Text(
                    'Checkout',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
