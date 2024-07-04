import 'package:flutter/material.dart';
import 'package:shopping_app/screens/product_category.dart';

class Dashboard extends StatefulWidget {
  final Function(Map<String, dynamic>) addToCart;

  const Dashboard({required this.addToCart, Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int selectedIndex = 0;
  final TextEditingController searchController = TextEditingController();
  final List<Map<String, dynamic>> _cart = [];

  final List<Map<String, dynamic>> _products = [
    {
      'id': 0,
      'image': 'assets/airpod.png',
      'name': 'Airpods',
      'category': 'Headphones',
      'rating': '4.9',
      'review': '100 reviews',
      'price': '132.00',
      'description':
          'With plenty of talk and listen time, voice-activated Siri access, and an available wireless charging case',
    },
    {
      'id': 1,
      'image': 'assets/macbook.png',
      'name': 'MacBook Air 13',
      'category': 'Laptop',
      'rating': '5.0',
      'review': '50 reviews',
      'price': '1100.00',
      'description':
          'FaceTime HD camera with advanced image signal processor for clearer, sharper video calls. Three-microphone array focuses on your voice instead of what\'s going on around you.'
    },
    {
      'id': 2,
      'image': 'assets/razerKaira.png',
      'name': 'Razer Kaira Pro',
      'category': 'Headphones',
      'rating': '4.7',
      'review': '120 reviews',
      'price': '153.00',
      'description':
          'Razer Kaira Pro for Xbox—a wireless Xbox Series X headset that supports mobile Xbox gaming',
    },
    {
      'id': 3,
      'image': 'assets/iPhone13.png',
      'name': 'iPhone 13',
      'category': 'Smartphones',
      'rating': '4.6',
      'review': '140 reviews',
      'price': '600.00',
      'description':
          'The iPhone 13 features flat edges, an aerospace-grade aluminum enclosure, and a glass back. It has a Super Retina XDR Display with a 2532x1170 resolution at 460 pixels per inch',
    },
    {
      'id': 4,
      'image': 'assets/wirelessController.png',
      'name': 'Wireless Controller',
      'category': 'Accessories',
      'rating': '4.2',
      'review': '3000 reviews',
      'price': '77.00',
      'description':
          'A more console-like experience: using a Bluetooth controller can make the experience of playing mobile games feel more like playing games on a console',
    },
    {
      'id': 5,
      'image': 'assets/xboxSeries.png',
      'name': 'Xbox series X',
      'category': 'Accessories',
      'rating': '4.8',
      'review': '117 reviews',
      'price': '570.00',
      'description':
          'The Microsoft Xbox Series X gaming console is capable of impressing with minimal boot times and mesmerizing visual effects when playing games at up to 120 frames per second',
    },
  ];

  List<Map<String, String>> categories = [
    {'name': 'All'},
    {'name': 'Smartphones'},
    {'name': 'Headphones'},
    {'name': 'Laptop'},
    {'name': 'Watch'},
    {'name': 'Accessories'}
  ];

  List<Map<String, dynamic>> get filteredProducts {
    if (searchController.text.isEmpty) {
      return _products;
    }
    return _products
        .where((product) => product['name']
            .toLowerCase()
            .contains(searchController.text.toLowerCase()))
        .toList();
  }

  void addToCartWithMessage(
      BuildContext context, Map<String, dynamic> product) {
    final isAlreadyInCart = _cart.any((item) => item['id'] == product['id']);
    if (isAlreadyInCart) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${product['name']} is already in the cart'),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 1),
        ),
      );
    } else {
      _cart.add(product);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${product['name']} added to cart'),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 1),
        ),
      );
      widget.addToCart(product);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            title: const Text('HNG Shopping'),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 10),
                Container(
                  width: 390,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(148, 228, 228, 228),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      controller: searchController,
                      onChanged: (value) {
                        setState(() {});
                      },
                      decoration: const InputDecoration(
                        hintText: 'Search',
                        hintStyle: TextStyle(
                          color: Color.fromARGB(161, 158, 158, 158),
                          fontSize: 15,
                        ),
                        suffixIcon: Icon(
                          Icons.search,
                          color: Colors.grey,
                          size: 30,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Stack(
                  clipBehavior: Clip.antiAlias,
                  children: [
                    Container(
                      width: 400,
                      height: 170,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(0, 50, 80, 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Text(
                                      'Explore innovation at \nyour fingertips. \nShop Right at HNG',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: -30,
                      left: 110,
                      child: ClipRect(
                        clipBehavior: Clip.none,
                        child: SizedBox(
                          width: 350,
                          height: 350,
                          child: Image.asset(
                            'assets/iPhone.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Categories',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(categories.length, (index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                });
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  color: selectedIndex == index
                                      ? Colors.green
                                      : Colors.white,
                                  border: Border.all(
                                    color: selectedIndex == index
                                        ? Colors.green
                                        : const Color.fromARGB(
                                            144, 158, 158, 158),
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    categories[index]['name']!,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: selectedIndex == index
                                          ? Colors.white
                                          : Colors.black,
                                      fontWeight: selectedIndex == index
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SliverFillRemaining(
            child: filteredProducts.isNotEmpty
                ? showProductCategory(
                    filteredProducts,
                    categories[selectedIndex]['name']!,
                    context,
                    (product) => addToCartWithMessage(context, product),
                  )
                : const Center(
                    child: Text('Item not available'),
                  ),
          ),
        ],
      ),
    );
  }
}
