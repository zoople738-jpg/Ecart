import 'package:flutter/material.dart';

import '../widgets/storefront_styles.dart';
import 'checkout.dart';

class CartPage extends StatefulWidget {
  final String productName;
  final double productPrice;
  final String imageUrl;

  const CartPage({
    super.key,
    required this.productName,
    required this.productPrice,
    this.imageUrl = '',
  });

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int _quantity = 1;
  bool _removed = false;

  double get _subtotal => widget.productPrice * _quantity;
  double get _delivery => _subtotal >= 50 ? 0 : 7.95;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StorefrontColors.paper,
      appBar: AppBar(
        backgroundColor: StorefrontColors.paper,
        foregroundColor: StorefrontColors.ink,
        title: const Text(
          'YOUR BAG',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800),
        ),
      ),
      body: _removed
          ? _EmptyCart(
              onContinue: () =>
                  Navigator.of(context).popUntil((route) => route.isFirst),
            )
          : ListView(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
              children: [
                const Text(
                  'Your bag',
                  style: TextStyle(
                    color: StorefrontColors.ink,
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '$_quantity ${_quantity == 1 ? 'item' : 'items'} set aside for you',
                  style: const TextStyle(color: StorefrontColors.muted),
                ),
                const SizedBox(height: 22),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: const Border.fromBorderSide(
                      BorderSide(color: StorefrontColors.line),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 88,
                        height: 88,
                        child: ProductPhoto(
                          imageUrl: widget.imageUrl,
                          fit: BoxFit.contain,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.productName,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: StorefrontColors.ink,
                                fontSize: 15,
                                height: 1.2,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '\$${widget.productPrice.toStringAsFixed(2)}',
                              style: const TextStyle(
                                color: StorefrontColors.ink,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                _QuantityButton(
                                  label: 'Decrease quantity',
                                  icon: Icons.remove,
                                  onPressed: _quantity > 1
                                      ? () => setState(() => _quantity--)
                                      : null,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                  ),
                                  child: Text(
                                    '$_quantity',
                                    key: const Key('cart-quantity'),
                                    style: const TextStyle(
                                      color: StorefrontColors.ink,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                _QuantityButton(
                                  label: 'Increase quantity',
                                  icon: Icons.add,
                                  onPressed: () => setState(() => _quantity++),
                                ),
                                const Spacer(),
                                IconButton(
                                  onPressed: () =>
                                      setState(() => _removed = true),
                                  tooltip: 'Remove item',
                                  visualDensity: VisualDensity.compact,
                                  icon: const Icon(
                                    Icons.delete_outline,
                                    color: StorefrontColors.muted,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8EEE7),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.local_shipping_outlined,
                        color: StorefrontColors.green,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Free shipping on orders over \$50',
                          style: TextStyle(
                            color: StorefrontColors.ink,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                _PriceRow(label: 'Subtotal', value: _subtotal),
                const SizedBox(height: 10),
                _PriceRow(
                  label: 'Delivery',
                  value: _delivery,
                  freeWhenZero: true,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  child: Divider(color: StorefrontColors.line, height: 1),
                ),
                _PriceRow(
                  label: 'Estimated total',
                  value: _subtotal + _delivery,
                  isTotal: true,
                ),
              ],
            ),
      bottomNavigationBar: _removed
          ? null
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 14),
                child: SizedBox(
                  height: 52,
                  child: FilledButton(
                    key: const Key('proceed-checkout'),
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
                        builder: (_) => CheckoutPage(
                          productName: widget.productName,
                          productPrice: widget.productPrice,
                          imageUrl: widget.imageUrl,
                          quantity: _quantity,
                        ),
                      ),
                    ),
                    child: const Text('Proceed to checkout'),
                  ),
                ),
              ),
            ),
    );
  }
}

class _QuantityButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback? onPressed;

  const _QuantityButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30,
      height: 30,
      child: IconButton(
        onPressed: onPressed,
        tooltip: label,
        padding: EdgeInsets.zero,
        visualDensity: VisualDensity.compact,
        style: IconButton.styleFrom(
          foregroundColor: StorefrontColors.ink,
          side: const BorderSide(color: StorefrontColors.line),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        icon: Icon(icon, size: 16),
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  final String label;
  final double value;
  final bool isTotal;
  final bool freeWhenZero;

  const _PriceRow({
    required this.label,
    required this.value,
    this.isTotal = false,
    this.freeWhenZero = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            color: isTotal ? StorefrontColors.ink : StorefrontColors.muted,
            fontSize: isTotal ? 16 : 13,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
        const Spacer(),
        Text(
          freeWhenZero && value == 0 ? 'FREE' : '\$${value.toStringAsFixed(2)}',
          style: TextStyle(
            color: StorefrontColors.ink,
            fontSize: isTotal ? 17 : 13,
            fontWeight: isTotal ? FontWeight.w800 : FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _EmptyCart extends StatelessWidget {
  final VoidCallback onContinue;

  const _EmptyCart({required this.onContinue});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.shopping_bag_outlined,
              color: StorefrontColors.green,
              size: 48,
            ),
            const SizedBox(height: 16),
            const Text(
              'Your bag is taking a break',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: StorefrontColors.ink,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Find something you love and it will show up here.',
              textAlign: TextAlign.center,
              style: TextStyle(color: StorefrontColors.muted),
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: onContinue,
              child: const Text('Keep browsing'),
            ),
          ],
        ),
      ),
    );
  }
}
