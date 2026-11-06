import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../widgets/product_card.dart';
import 'cart_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Rasmlar va so'mdagi narxlar qo'shildi
  static final List<Product> products = [
    Product(
      id: 'p1',
      name: 'Olma (Qizil)',
      price: 15000,
      imageUrl: 'assets/olma.jpg',
    ),
    Product(
      id: 'p2',
      name: 'Banan',
      price: 22000,
      imageUrl: 'assets/banan.jpg',
    ),
    Product(
      id: 'p3',
      name: 'Uzum (Yashil)',
      price: 35000,
      imageUrl: 'assets/uzum.jpg', // <-- Yangi ishlaydigan link
    ),
    Product(
      id: 'p4',
      name: 'Tarvuz',
      price: 12000,
      imageUrl: 'assets/tarvuz.jpg',
    ),
    Product(
      id: 'p5',
      name: 'Qovun',
      price: 25000,
      imageUrl: 'assets/qovun.jpg',
    ),
    Product(
      id: 'p6',
      name: 'Sut (1L)',
      price: 12000,
      imageUrl: 'assets/sut.jpeg',
    ),
    Product(
      id: 'p7',
      name: 'Non (Patir)',
      price: 4000,
      imageUrl: 'assets/non.jpg',
    ),
    Product(
      id: 'p8',
      name: 'Pishloq',
      price: 45000,
      imageUrl: 'assets/pishloq.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Orqa fon rangini biroz och qildik
      appBar: AppBar(
        title: const Text(
          'Shop 🛒',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 33, 145, 243),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          Consumer<CartProvider>(
            builder: (context, cart, child) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const CartScreen()),
                      );
                    },
                  ),
                  if (cart.totalQuantity > 0)
                    Positioned(
                      right: 6,
                      top: 6,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 20,
                          minHeight: 20,
                        ),
                        child: Text(
                          '${cart.totalQuantity}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(top: 12, bottom: 20),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductCard(
            product: products[index],
            onAdd: () {
              context.read<CartProvider>().addToCart(products[index]);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    '${products[index].name} savatchaga qo\'shildi',
                  ),
                  duration: const Duration(seconds: 1),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
