import 'package:flutter/material.dart';
import '../models/model.dart';

class FavoritesPage extends StatelessWidget {
  final List<FishingProduct> favorites;

  FavoritesPage({required this.favorites});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Избранное'),
      ),
      body: favorites.isEmpty
          ? Center(child: Text('Нет избранных товаров.'))
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final product = favorites[index];
                return ListTile(
                  leading: Image.network(product.imageUrl),
                  title: Text(product.name),
                  subtitle: Text(product.description),
                );
              },
            ),
    );
  }
}
