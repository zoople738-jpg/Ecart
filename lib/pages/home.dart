import 'package:flutter/material.dart';

import '../widgets/product_tile.dart';
import '../widgets/storefront_styles.dart';
import 'product.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const List<Map<String, dynamic>> _products = [
    {
      'name': 'Apple iPhone 13',
      'price': 999.99,
      'category': 'Phones',
      'imageUrl': 'https://images.unsplash.com/photo-1592750475338-74b7b21085ab?auto=format&fit=crop&w=900&q=85',
    },
    {
      'name': 'Dell XPS 13 Laptop',
      'price': 1299.99,
      'category': 'Computers',
      'imageUrl': 'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?auto=format&fit=crop&w=900&q=85',
    },
    {
      'name': 'Samsung Galaxy Tab S7',
      'price': 699.99,
      'category': 'Tablets',
      'imageUrl': 'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?auto=format&fit=crop&w=900&q=85',
    },
    {
      'name': 'Sony WH-1000XM4 Headphones',
      'price': 349.99,
      'category': 'Audio',
      'imageUrl': 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&w=900&q=85',
    },
    {
      'name': 'Apple MacBook Pro',
      'price': 1999.99,
      'category': 'Computers',
      'imageUrl': 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?auto=format&fit=crop&w=900&q=85',
    },
    {
      'name': 'Google Pixel 6',
      'price': 599.99,
      'category': 'Phones',
      'imageUrl': 'https://images.unsplash.com/photo-1598327105666-5b89351aff97?auto=format&fit=crop&w=900&q=85',
    },
    {
      'name': 'Amazon Echo Dot (4th Gen)',
      'price': 49.99,
      'category': 'Home',
      'imageUrl': 'https://images.unsplash.com/photo-1543512214-318c7553f230?auto=format&fit=crop&w=900&q=85',
    },
    {
      'name': 'Fitbit Charge 5',
      'price': 149.99,
      'category': 'Wearables',
      'imageUrl': 'https://images.unsplash.com/photo-1557935728-e6d1eaabe558?auto=format&fit=crop&w=900&q=85',
    },
    {
      'name': 'Nintendo Switch',
      'price': 299.99,
      'category': 'Gaming',
      'imageUrl': 'https://images.unsplash.com/photo-1578303512597-81e6cc155b3e?auto=format&fit=crop&w=900&q=85',
    },
    {
      'name': 'Canon EOS R5 Camera',
      'price': 3899.99,
      'category': 'Cameras',
      'imageUrl': 'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?auto=format&fit=crop&w=900&q=85',
    },
  ];

  static const _categories = [
    'All',
    'Phones',
    'Computers',
    'Tablets',
    'Audio',
    'Home',
    'Wearables',
    'Gaming',
    'Cameras',
  ];

  String _selectedCategory = 'All';
  String _query = '';
  final Set<String> _favorites = {};

  List<Map<String, dynamic>> get _visibleProducts {
    return _products.where((product) {
      final matchesCategory =
          _selectedCategory == 'All' ||
          product['category'] == _selectedCategory;
      final matchesSearch = (product['name'] as String).toLowerCase().contains(
        _query.toLowerCase(),
      );
      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StorefrontColors.paper,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: StorefrontColors.green,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.shopping_bag_outlined,
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'E-CART',
                          style: TextStyle(
                            color: StorefrontColors.ink,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE9EDE7),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Row(
                            children: [
                              Icon(
                                Icons.circle,
                                size: 7,
                                color: StorefrontColors.coral,
                              ),
                              SizedBox(width: 6),
                              Text(
                                'CURATED DAILY',
                                style: TextStyle(
                                  color: StorefrontColors.ink,
                                  fontSize: 9,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 26),
                    const Text(
                      'The good stuff,\nfor everyday.',
                      style: TextStyle(
                        color: StorefrontColors.ink,
                        fontSize: 31,
                        height: 1.06,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 9),
                    const Text(
                      'Useful things. Thoughtfully chosen.',
                      style: TextStyle(
                        color: StorefrontColors.muted,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      onChanged: (value) =>
                          setState(() => _query = value.trim()),
                      decoration: InputDecoration(
                        hintText: 'Search the collection',
                        hintStyle: const TextStyle(
                          color: StorefrontColors.muted,
                        ),
                        prefixIcon: const Icon(Icons.search),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    SizedBox(
                      height: 38,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _categories.length,
                        separatorBuilder: (_, _) => const SizedBox(width: 8),
                        itemBuilder: (context, index) {
                          final category = _categories[index];
                          final selected = category == _selectedCategory;
                          return ChoiceChip(
                            label: Text(category),
                            selected: selected,
                            onSelected: (_) =>
                                setState(() => _selectedCategory = category),
                            showCheckmark: false,
                            labelStyle: TextStyle(
                              color: selected
                                  ? Colors.white
                                  : StorefrontColors.ink,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                            selectedColor: StorefrontColors.green,
                            backgroundColor: Colors.white,
                            side: BorderSide.none,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 22),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          'Popular right now',
                          style: TextStyle(
                            color: StorefrontColors.ink,
                            fontSize: 19,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '${_visibleProducts.length} PICKS',
                          style: const TextStyle(
                            color: StorefrontColors.muted,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
            if (_visibleProducts.isEmpty)
              const SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: Text(
                    'No items found. Try another search.',
                    style: TextStyle(color: StorefrontColors.muted),
                  ),
                ),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                sliver: SliverGrid.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 230,
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 14,
                    childAspectRatio: 0.68,
                  ),
                  itemCount: _visibleProducts.length,
                  itemBuilder: (context, index) {
                    final product = _visibleProducts[index];
                    final name = product['name'] as String;
                    final price = product['price'] as double;
                    final imageUrl = product['imageUrl'] as String;
                    final category = product['category'] as String;
                    return ProductTile(
                      name: name,
                      price: price,
                      category: category,
                      imageUrl: imageUrl,
                      isFavorite: _favorites.contains(name),
                      onFavoriteTap: () => setState(() {
                        if (!_favorites.add(name)) _favorites.remove(name);
                      }),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (_) => ProductPage(
                            name: name,
                            price: price,
                            imageUrl: imageUrl,
                            category: category,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
