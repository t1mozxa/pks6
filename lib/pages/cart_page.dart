import 'package:flutter/material.dart';
import '../models/model.dart';

class CartPage extends StatelessWidget {
  final List<CartItem> cart;
  final Function(FishingProduct) onIncreaseQuantity;
  final Function(FishingProduct) onDecreaseQuantity;
  final Function(FishingProduct) onRemoveFromCart;
  final VoidCallback onOrder;

  const CartPage({
    Key? key,
    required this.cart,
    required this.onIncreaseQuantity,
    required this.onDecreaseQuantity,
    required this.onRemoveFromCart,
    required this.onOrder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double totalPrice = cart.fold(
      0,
      (sum, item) => sum + (item.product.price * item.quantity),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text('Корзина', style: TextStyle(color: Colors.white)),
      ),
      body: cart.isEmpty
          ? const Center(
              child: Text(
                'Ваша корзина пуста',
                style: TextStyle(fontSize: 18),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.length,
                    itemBuilder: (context, index) {
                      final cartItem = cart[index];
                      return Card(
                        elevation: 3,
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        child: ListTile(
                          leading: Image.network(
                            cartItem.product.imageUrl,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          title: Text(cartItem.product.name),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Цена: ${cartItem.product.price} руб.'),
                              Text('Количество: ${cartItem.quantity}'),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove,
                                    color: Colors.blueGrey),
                                onPressed: () =>
                                    onDecreaseQuantity(cartItem.product),
                              ),
                              Text('${cartItem.quantity}'),
                              IconButton(
                                icon: const Icon(Icons.add,
                                    color: Colors.blueGrey),
                                onPressed: () =>
                                    onIncreaseQuantity(cartItem.product),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Итоговая стоимость:',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '$totalPrice руб.',
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: onOrder,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueGrey,
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 20),
                        ),
                        child: const Text(
                          'Оформить заказ',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}