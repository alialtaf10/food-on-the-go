import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _searchQuery = '';
  
  final List<Map<String, dynamic>> _allRestaurants = [
    {
      'name': 'Food Court Express',
      'cuisine': 'Fast Food',
      'rating': 4.5,
      'icon': Icons.fastfood,
      'color': const Color(0xFFFF6B6B),
    },
    {
      'name': 'Spice Village',
      'cuisine': 'Pakistani',
      'rating': 4.8,
      'icon': Icons.restaurant,
      'color': const Color(0xFF4ECDC4),
    },
    {
      'name': 'Pizza Hub',
      'cuisine': 'Italian',
      'rating': 4.6,
      'icon': Icons.local_pizza,
      'color': const Color(0xFFFFE66D),
    },
    {
      'name': 'Sushi Master',
      'cuisine': 'Japanese',
      'rating': 4.9,
      'icon': Icons.set_meal,
      'color': const Color(0xFFFF8C42),
    },
    {
      'name': 'BBQ Tonight',
      'cuisine': 'BBQ',
      'rating': 4.7,
      'icon': Icons.kitchen,
      'color': const Color(0xFFA06A4B),
    },
    {
      'name': 'Desi Dhaba',
      'cuisine': 'Pakistani',
      'rating': 4.4,
      'icon': Icons.ramen_dining,
      'color': const Color(0xFFD4A5A5),
    },
  ];

  final List<Map<String, dynamic>> _allFoodItems = [
    {'name': 'Chicken Biryani', 'price': 'Rs. 350', 'rating': 4.5, 'restaurant': 'Spice Village'},
    {'name': 'Zinger Burger', 'price': 'Rs. 250', 'rating': 4.3, 'restaurant': 'Food Court Express'},
    {'name': 'Chicken Karahi', 'price': 'Rs. 800', 'rating': 4.7, 'restaurant': 'Spice Village'},
    {'name': 'Margherita Pizza', 'price': 'Rs. 600', 'rating': 4.6, 'restaurant': 'Pizza Hub'},
    {'name': 'Club Sandwich', 'price': 'Rs. 180', 'rating': 4.2, 'restaurant': 'Food Court Express'},
    {'name': 'Cold Coffee', 'price': 'Rs. 150', 'rating': 4.4, 'restaurant': 'Food Court Express'},
    {'name': 'French Fries', 'price': 'Rs. 120', 'rating': 4.1, 'restaurant': 'Food Court Express'},
    {'name': 'BBQ Platter', 'price': 'Rs. 1200', 'rating': 4.8, 'restaurant': 'BBQ Tonight'},
    {'name': 'California Roll', 'price': 'Rs. 450', 'rating': 4.9, 'restaurant': 'Sushi Master'},
  ];

  List<Map<String, dynamic>> get _filteredRestaurants {
    if (_searchQuery.isEmpty) return _allRestaurants;
    return _allRestaurants.where((restaurant) =>
      restaurant['name'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
      restaurant['cuisine'].toLowerCase().contains(_searchQuery.toLowerCase())
    ).toList();
  }

  List<Map<String, dynamic>> get _filteredFoodItems {
    if (_searchQuery.isEmpty) return _allFoodItems;
    return _allFoodItems.where((item) =>
      item['name'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
      item['restaurant'].toLowerCase().contains(_searchQuery.toLowerCase())
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Search restaurants or dishes...',
                prefixIcon: const Icon(Icons.search, color: Color(0xFF2D6A4F)),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            _searchQuery = '';
                          });
                        },
                      )
                    : null,
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_searchQuery.isNotEmpty) ...[
              Text(
                'Found ${_filteredRestaurants.length + _filteredFoodItems.length} results for "$_searchQuery"',
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 16),
            ],
            
            // Restaurants Section
            if (_filteredRestaurants.isNotEmpty) ...[
              const Text(
                'Restaurants',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _filteredRestaurants.length,
                  itemBuilder: (context, index) {
                    final restaurant = _filteredRestaurants[index];
                    return Container(
                      width: 160,
                      margin: const EdgeInsets.only(right: 12),
                      child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: Column(
                          children: [
                            Container(
                              height: 100,
                              decoration: BoxDecoration(
                                color: restaurant['color'],
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                              ),
                              child: Center(
                                child: Icon(restaurant['icon'], size: 50, color: Colors.white),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    restaurant['name'],
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      const Icon(Icons.star, size: 12, color: Colors.amber),
                                      const SizedBox(width: 4),
                                      Text(restaurant['rating'].toString()),
                                      const SizedBox(width: 8),
                                      Text(
                                        restaurant['cuisine'],
                                        style: const TextStyle(fontSize: 11, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
            ],
            
            // Food Items Section
            if (_filteredFoodItems.isNotEmpty) ...[
              const Text(
                'Dishes',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _filteredFoodItems.length,
                itemBuilder: (context, index) {
                  final item = _filteredFoodItems[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      leading: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xFF2D6A4F).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.fastfood, color: Color(0xFF2D6A4F)),
                      ),
                      title: Text(item['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item['restaurant'], style: const TextStyle(fontSize: 12)),
                          Row(
                            children: [
                              const Icon(Icons.star, size: 12, color: Colors.amber),
                              const SizedBox(width: 4),
                              Text(item['rating'].toString()),
                            ],
                          ),
                        ],
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            item['price'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2D6A4F),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFF2D6A4F),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'Add',
                              style: TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
            
            if (_filteredRestaurants.isEmpty && _filteredFoodItems.isEmpty && _searchQuery.isNotEmpty)
              Center(
                child: Column(
                  children: [
                    const SizedBox(height: 100),
                    Icon(Icons.search_off, size: 64, color: Colors.grey.shade400),
                    const SizedBox(height: 16),
                    Text(
                      'No results found for "$_searchQuery"',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}