import 'package:flutter/material.dart';

import 'cart.dart';
import '../widgets/storefront_styles.dart';

class ProductPage extends StatelessWidget {
  final String name;
  final double price;
  final String imageUrl;
  final String category;

  const ProductPage({
    super.key,
    required this.name,
    required this.price,
    required this.imageUrl,
    this.category = 'Curated pick',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StorefrontColors.paper,
      appBar: AppBar(
        backgroundColor: StorefrontColors.paper,
        foregroundColor: StorefrontColors.ink,
        title: const Text(
          'THE FIND',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1.08,
              child: ProductPhoto(
                imageUrl: imageUrl,
                fit: BoxFit.contain,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(height: 22),
            Text(
              category.toUpperCase(),
              style: const TextStyle(
                color: StorefrontColors.green,
                fontSize: 11,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              name,
              style: const TextStyle(
                color: StorefrontColors.ink,
                fontSize: 27,
                height: 1.12,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Text(
                  '\$${price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: StorefrontColors.ink,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(width: 12),
                const Icon(
                  Icons.star_rounded,
                  color: StorefrontColors.coral,
                  size: 18,
                ),
                const Text(
                  '4.8',
                  style: TextStyle(
                    color: StorefrontColors.ink,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Text(
                  '  ·  Carefully selected',
                  style: TextStyle(color: StorefrontColors.muted, fontSize: 12),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Divider(color: StorefrontColors.line, height: 1),
            ),
            const Text(
              'Made to make the everyday feel a little better. A thoughtful pick for reliable performance, clean design, and lasting use.',
              style: TextStyle(
                color: StorefrontColors.muted,
                fontSize: 14,
                height: 1.55,
              ),
            ),
            const SizedBox(height: 20),
            const Row(
              children: [
                Icon(
                  Icons.local_shipping_outlined,
                  size: 18,
                  color: StorefrontColors.green,
                ),
                SizedBox(width: 8),
                Text(
                  'Free delivery on orders over \$50',
                  style: TextStyle(color: StorefrontColors.ink, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: StorefrontColors.line)),
          ),
          child: SizedBox(
            height: 52,
            child: FilledButton.icon(
              style: FilledButton.styleFrom(
                backgroundColor: StorefrontColors.green,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (_) => CartPage(
                    productName: name,
                    productPrice: price,
                    imageUrl: imageUrl,
                  ),
                ),
              ),
              icon: const Icon(Icons.shopping_bag_outlined),
              label: const Text('Add to bag'),
            ),
          ),
        ),
      ),
    );
  }
}
