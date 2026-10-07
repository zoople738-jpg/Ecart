import 'package:flutter/material.dart';

import '../widgets/storefront_styles.dart';

class CheckoutPage extends StatefulWidget {
  final String productName;
  final double productPrice;
  final String imageUrl;
  final int quantity;

  const CheckoutPage({
    super.key,
    required this.productName,
    required this.productPrice,
    this.imageUrl = '',
    this.quantity = 1,
  });

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _formKey = GlobalKey<FormState>();
  String _paymentMethod = 'Card';

  double get _subtotal => widget.productPrice * widget.quantity;
  double get _delivery => _subtotal >= 50 ? 0 : 7.95;
  double get _tax => _subtotal * 0.08;
  double get _total => _subtotal + _delivery + _tax;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StorefrontColors.paper,
      appBar: AppBar(
        backgroundColor: StorefrontColors.paper,
        foregroundColor: StorefrontColors.ink,
        title: const Text(
          'CHECKOUT',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800),
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'The final details.',
                  style: TextStyle(
                    color: StorefrontColors.ink,
                    fontSize: 27,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'A few details and it’s on its way.',
                  style: TextStyle(color: StorefrontColors.muted),
                ),
                const SizedBox(height: 20),
                _OrderItem(
                  name: widget.productName,
                  price: widget.productPrice,
                  imageUrl: widget.imageUrl,
                  quantity: widget.quantity,
                ),
                const SizedBox(height: 26),
                const _SectionHeading(number: '01', title: 'Delivery details'),
                const SizedBox(height: 14),
                TextFormField(
                  key: const Key('checkout-name'),
                  textInputAction: TextInputAction.next,
                  decoration: _inputDecoration(
                    'Full name',
                    Icons.person_outline,
                  ),
                  validator: _required,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  key: const Key('checkout-address'),
                  textInputAction: TextInputAction.next,
                  decoration: _inputDecoration(
                    'Street address',
                    Icons.home_outlined,
                  ),
                  validator: _required,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        key: const Key('checkout-city'),
                        textInputAction: TextInputAction.next,
                        decoration: _inputDecoration(
                          'City',
                          Icons.location_city_outlined,
                        ),
                        validator: _required,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        key: const Key('checkout-postal'),
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        decoration: _inputDecoration('ZIP code', null),
                        validator: _required,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 26),
                const _SectionHeading(number: '02', title: 'Payment method'),
                const SizedBox(height: 14),
                SegmentedButton<String>(
                  segments: const [
                    ButtonSegment(
                      value: 'Card',
                      label: Text('Card'),
                      icon: Icon(Icons.credit_card_outlined),
                    ),
                    ButtonSegment(
                      value: 'On delivery',
                      label: Text('On delivery'),
                      icon: Icon(Icons.local_shipping_outlined),
                    ),
                  ],
                  selected: {_paymentMethod},
                  onSelectionChanged: (selection) =>
                      setState(() => _paymentMethod = selection.first),
                ),
                if (_paymentMethod == 'Card') ...[
                  const SizedBox(height: 12),
                  TextFormField(
                    key: const Key('checkout-card'),
                    keyboardType: TextInputType.number,
                    decoration: _inputDecoration(
                      'Card number',
                      Icons.credit_card_outlined,
                    ),
                    validator: (value) {
                      final digits = (value ?? '').replaceAll(
                        RegExp(r'\D'),
                        '',
                      );
                      if (_paymentMethod == 'Card' && digits.length < 12) {
                        return 'Enter a valid card number';
                      }
                      return null;
                    },
                  ),
                ],
                const SizedBox(height: 24),
                const _SectionHeading(number: '03', title: 'Order summary'),
                const SizedBox(height: 14),
                _PriceRow(label: 'Subtotal', value: _subtotal),
                const SizedBox(height: 8),
                _PriceRow(
                  label: 'Delivery',
                  value: _delivery,
                  freeWhenZero: true,
                ),
                const SizedBox(height: 8),
                _PriceRow(label: 'Estimated tax', value: _tax),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 13),
                  child: Divider(color: StorefrontColors.line, height: 1),
                ),
                _PriceRow(label: 'Total', value: _total, isTotal: true),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: FilledButton.icon(
                    key: const Key('place-order'),
                    style: FilledButton.styleFrom(
                      backgroundColor: StorefrontColors.green,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: _placeOrder,
                    icon: const Icon(Icons.lock_outline, size: 18),
                    label: Text('Place order · \$${_total.toStringAsFixed(2)}'),
                  ),
                ),
                const SizedBox(height: 10),
                const Center(
                  child: Text(
                    'Demo checkout · no payment is processed',
                    style: TextStyle(
                      color: StorefrontColors.muted,
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? _required(String? value) =>
      value == null || value.trim().isEmpty ? 'This field is required' : null;

  InputDecoration _inputDecoration(String label, IconData? icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: icon == null ? null : Icon(icon),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: StorefrontColors.line),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: StorefrontColors.line),
      ),
    );
  }

  void _placeOrder() {
    if (!_formKey.currentState!.validate()) return;

    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        icon: const Icon(
          Icons.check_circle_outline,
          color: StorefrontColors.green,
          size: 42,
        ),
        title: const Text('Order placed'),
        content: const Text(
          'Thanks for your order. Your delivery details have been received.',
        ),
        actions: [
          FilledButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            child: const Text('Continue shopping'),
          ),
        ],
      ),
    );
  }
}

class _OrderItem extends StatelessWidget {
  final String name;
  final double price;
  final String imageUrl;
  final int quantity;

  const _OrderItem({
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: const Border.fromBorderSide(
          BorderSide(color: StorefrontColors.line),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 64,
            height: 64,
            child: ProductPhoto(
              imageUrl: imageUrl,
              fit: BoxFit.contain,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: StorefrontColors.ink,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Qty $quantity  ·  \$${price.toStringAsFixed(2)} each',
                  style: const TextStyle(
                    color: StorefrontColors.muted,
                    fontSize: 12,
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

class _SectionHeading extends StatelessWidget {
  final String number;
  final String title;

  const _SectionHeading({required this.number, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          number,
          style: const TextStyle(
            color: StorefrontColors.coral,
            fontSize: 11,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(width: 9),
        Text(
          title,
          style: const TextStyle(
            color: StorefrontColors.ink,
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
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
