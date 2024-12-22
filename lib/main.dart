import 'package:flutter/material.dart';
import 'package:pks3/pages/cart_page.dart';
import 'package:pks3/pages/home_page.dart';
import 'package:pks3/pages/favorites_page.dart';
import 'package:pks3/pages/profile_page.dart';
import 'models/model.dart'; 

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Рыболовные товары',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  List<FishingProduct> favorites = [];
  List<CartItem> cart = [];

  void toggleCart(FishingProduct product) {
    setState(() {
      final existingCartItem = cart.firstWhere(
        (item) => item.product == product,
        orElse: () => CartItem(product: product, quantity: 0),
      );

      if (existingCartItem.quantity > 0) {
        existingCartItem.quantity++;
      } else {
        cart.add(CartItem(product: product));
      }
    });
  }

  void removeFromCart(FishingProduct product) {
    setState(() {
      cart.removeWhere((item) => item.product == product);
    });
  }

  void decreaseQuantity(FishingProduct product) {
    setState(() {
      final cartItem = cart.firstWhere((item) => item.product == product);
      if (cartItem.quantity > 1) {
        cartItem.quantity--;
      }
    });
  }

  void increaseQuantity(FishingProduct product) {
    setState(() {
      final cartItem = cart.firstWhere((item) => item.product == product);
      cartItem.quantity++;
    });
  }

  void placeOrder() {
    setState(() {
      cart.clear();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Заказ оформлен!')),
    );
  }

  void addProduct(FishingProduct product) {
    setState(() {
      fishingProducts.add(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    final _pages = [
      HomePage(
        onFavoriteToggle: (product) {
          setState(() {
            if (favorites.contains(product)) {
              favorites.remove(product);
            } else {
              favorites.add(product);
            }
          });
        },
        favorites: favorites,
        onCartToggle: toggleCart,
        onAddProduct: addProduct,
      ),
      FavoritesPage(favorites: favorites),
      ProfilePage(),
      CartPage(
        cart: cart,
        onIncreaseQuantity: increaseQuantity,
        onDecreaseQuantity: decreaseQuantity,
        onRemoveFromCart: removeFromCart,
        onOrder: placeOrder,
      ),
    ];

    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Главная',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Избранное',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Профиль',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                const Icon(Icons.shopping_cart),
                if (cart.isNotEmpty)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.red,
                      child: Text(
                        '${cart.fold(0, (sum, item) => sum + item.quantity)}',
                        style: const TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ),
                  ),
              ],
            ),
            label: 'Корзина',
          ),
        ],
        selectedItemColor: Colors.blueGrey,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}