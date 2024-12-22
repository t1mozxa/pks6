import 'package:flutter/material.dart';
import 'package:pks3/components/add_product_page.dart';
import 'package:pks3/pages/product_detail.dart';
import '../models/model.dart';
import '../components/item.dart';

class HomePage extends StatelessWidget {
  final Function(FishingProduct) onFavoriteToggle;
  final List<FishingProduct> favorites;
  final Function(FishingProduct) onCartToggle;
  final Function(FishingProduct) onAddProduct;

  const HomePage({
    Key? key,
    required this.onFavoriteToggle,
    required this.favorites,
    required this.onCartToggle,
    required this.onAddProduct,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Center(
          child: Text(
            'Рыболовные товары',
            style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: fishingProducts.length,
        itemBuilder: (context, index) {
          final product = fishingProducts[index];
          final isFavorite = favorites.contains(product);

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailPage(product: product),
                ),
              );
            },
            child: Item(
              product: product,
              isFavorite: isFavorite,
              onFavoriteToggle: onFavoriteToggle,
              onCartToggle: onCartToggle,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddProductPage(
                onProductAdded: (newProduct) {
                  onAddProduct(newProduct);
                },
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blueGrey,
      ),
    );
  }
}