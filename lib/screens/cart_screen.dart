import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Map<String, dynamic>> _cartItems = [
    {
      'id': '1',
      'name': 'Chicken Biryani',
      'price': 350,
      'quantity': 1,
      'restaurant': 'Spice Village',
      'image': Icons.restaurant,
    },
    {
      'id': '2',
      'name': 'Zinger Burger',
      'price': 250,
      'quantity': 2,
      'restaurant': 'Food Court Express',
      'image': Icons.fastfood,
    },
    {
      'id': '3',
      'name': 'Cold Coffee',
      'price': 150,
      'quantity': 1,
      'restaurant': 'Food Court Express',
      'image': Icons.local_cafe,
    },
  ];

  double get _subtotal {
    return _cartItems.fold(0, (sum, item) => sum + (item['price'] * item['quantity']));
  }

  double get _deliveryFee => 50;
  double get _tax => _subtotal * 0.1;
  double get _total => _subtotal + _deliveryFee + _tax;

  void _updateQuantity(int index, int newQuantity) {
    setState(() {
      if (newQuantity <= 0) {
        _cartItems.removeAt(index);
      } else {
        _cartItems[index]['quantity'] = newQuantity;
      }
    });
  }

  void _removeItem(int index) {
    setState(() {
      _cartItems.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Item removed from cart')),
    );
  }

  void _checkout() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Order placed successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        actions: [
          if (_cartItems.isNotEmpty)
            TextButton(
              onPressed: () {
                setState(() {
                  _cartItems.clear();
                });
              },
              child: const Text('Clear All', style: TextStyle(color: Colors.white)),
            ),
        ],
      ),
      body: _cartItems.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey.shade400),
                  const SizedBox(height: 16),
                  Text(
                    'Your cart is empty',
                    style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Add items from restaurants to get started',
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Browse Restaurants'),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _cartItems.length,
                    itemBuilder: (context, index) {
                      final item = _cartItems[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF2D6A4F).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(item['image'], size: 30, color: const Color(0xFF2D6A4F)),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['name'],
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      item['restaurant'],
                                      style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Rs. ${item['price']}',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF2D6A4F),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.remove_circle_outline, size: 24),
                                        onPressed: () {
                                          _updateQuantity(index, item['quantity'] - 1);
                                        },
                                        color: const Color(0xFF2D6A4F),
                                      ),
                                      Container(
                                        width: 40,
                                        child: Text(
                                          item['quantity'].toString(),
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.add_circle_outline, size: 24),
                                        onPressed: () {
                                          _updateQuantity(index, item['quantity'] + 1);
                                        },
                                        color: const Color(0xFF2D6A4F),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  TextButton(
                                    onPressed: () => _removeItem(index),
                                    child: const Text(
                                      'Remove',
                                      style: TextStyle(color: Colors.red, fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                
                // Order Summary
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, -4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        const Text(
                          'Order Summary',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 12),
                        _buildSummaryRow('Subtotal', 'Rs. ${_subtotal.toStringAsFixed(0)}'),
                        _buildSummaryRow('Delivery Fee', 'Rs. ${_deliveryFee.toStringAsFixed(0)}'),
                        _buildSummaryRow('Tax (10%)', 'Rs. ${_tax.toStringAsFixed(0)}'),
                        const Divider(height: 24),
                        _buildSummaryRow(
                          'Total',
                          'Rs. ${_total.toStringAsFixed(0)}',
                          isTotal: true,
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _checkout,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: const Text(
                              'Proceed to Checkout',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? const Color(0xFF1E293B) : Colors.grey.shade600,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 18 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? const Color(0xFF2D6A4F) : Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }
}