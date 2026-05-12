import 'package:flutter/material.dart';
import 'search_screen.dart';
import 'profile_screen.dart';
import 'cart_screen.dart';

class CustomerDashboard extends StatefulWidget {
  final String userName;
  const CustomerDashboard({super.key, required this.userName});

  @override
  State<CustomerDashboard> createState() => _CustomerDashboardState();
}

class _CustomerDashboardState extends State<CustomerDashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  String _selectedStop = 'Sukheki';
  String? _selectedCuisine = 'All';

  final List<String> _stopLocations = [
    'Sukheki',
    'Sial',
    'Bhera',
    'Kallar Kahar',
    'Chakri',
    'Sheikhupura',
    'Khanqah Dogran',
    'Makhdoom',
    'Kot Momin',
    'Salem',
    'Lilla',
    'Balkasar',
    'Neelah Dullah',
  ];

  final List<String> _cuisines = ['All', 'Pakistani', 'Fast Food', 'Chinese', 'Italian', 'BBQ'];

  final List<Map<String, dynamic>> _restaurants = [
    {
      'name': 'Food Court Express',
      'cuisine': 'Fast Food',
      'rating': 4.5,
      'deliveryTime': '20-30 min',
      'icon': Icons.fastfood,
      'color': const Color(0xFFFF6B6B),
      'stop': 'Sukheki',
      'price': '\$\$',
    },
    {
      'name': 'Spice Village',
      'cuisine': 'Pakistani',
      'rating': 4.8,
      'deliveryTime': '30-40 min',
      'icon': Icons.restaurant,
      'color': const Color(0xFF4ECDC4),
      'stop': 'Sial',
      'price': '\$\$\$',
    },
    {
      'name': 'Pizza Hub',
      'cuisine': 'Italian',
      'rating': 4.6,
      'deliveryTime': '25-35 min',
      'icon': Icons.local_pizza,
      'color': const Color(0xFFFFE66D),
      'stop': 'Bhera',
      'price': '\$\$',
    },
    {
      'name': 'Sushi Master',
      'cuisine': 'Japanese',
      'rating': 4.9,
      'deliveryTime': '35-45 min',
      'icon': Icons.set_meal,
      'color': const Color(0xFFFF8C42),
      'stop': 'Kallar Kahar',
      'price': '\$\$\$\$',
    },
    {
      'name': 'BBQ Tonight',
      'cuisine': 'BBQ',
      'rating': 4.7,
      'deliveryTime': '40-50 min',
      'icon': Icons.kitchen,
      'color': const Color(0xFFA06A4B),
      'stop': 'Chakri',
      'price': '\$\$\$',
    },
    {
      'name': 'Desi Dhaba',
      'cuisine': 'Pakistani',
      'rating': 4.4,
      'deliveryTime': '25-35 min',
      'icon': Icons.ramen_dining,
      'color': const Color(0xFFD4A5A5),
      'stop': 'Sheikhupura',
      'price': '\$',
    },
    {
      'name': 'Taste of Lahore',
      'cuisine': 'Pakistani',
      'rating': 4.9,
      'deliveryTime': '30-40 min',
      'icon': Icons.restaurant,
      'color': const Color(0xFF9B59B6),
      'stop': 'Sukheki',
      'price': '\$\$\$',
    },
    {
      'name': 'Burger House',
      'cuisine': 'Fast Food',
      'rating': 4.7,
      'deliveryTime': '15-25 min',
      'icon': Icons.fastfood,
      'color': const Color(0xFFE67E22),
      'stop': 'Sial',
      'price': '\$\$',
    },
  ];

  final List<Map<String, dynamic>> _dishes = [
    {'name': 'Chicken Biryani', 'price': 'Rs. 350', 'rating': 4.5, 'restaurant': 'Spice Village', 'image': Icons.restaurant, 'color': const Color(0xFF4ECDC4)},
    {'name': 'Zinger Burger', 'price': 'Rs. 250', 'rating': 4.3, 'restaurant': 'Food Court Express', 'image': Icons.fastfood, 'color': const Color(0xFFFF6B6B)},
    {'name': 'Chicken Karahi', 'price': 'Rs. 800', 'rating': 4.7, 'restaurant': 'Spice Village', 'image': Icons.restaurant, 'color': const Color(0xFF4ECDC4)},
    {'name': 'Margherita Pizza', 'price': 'Rs. 600', 'rating': 4.6, 'restaurant': 'Pizza Hub', 'image': Icons.local_pizza, 'color': const Color(0xFFFFE66D)},
    {'name': 'Club Sandwich', 'price': 'Rs. 180', 'rating': 4.2, 'restaurant': 'Food Court Express', 'image': Icons.fastfood, 'color': const Color(0xFFFF6B6B)},
    {'name': 'Cold Coffee', 'price': 'Rs. 150', 'rating': 4.4, 'restaurant': 'Food Court Express', 'image': Icons.local_cafe, 'color': const Color(0xFFFF6B6B)},
    {'name': 'French Fries', 'price': 'Rs. 120', 'rating': 4.1, 'restaurant': 'Food Court Express', 'image': Icons.fastfood, 'color': const Color(0xFFFF6B6B)},
    {'name': 'BBQ Platter', 'price': 'Rs. 1200', 'rating': 4.8, 'restaurant': 'BBQ Tonight', 'image': Icons.kitchen, 'color': const Color(0xFFA06A4B)},
    {'name': 'California Roll', 'price': 'Rs. 450', 'rating': 4.9, 'restaurant': 'Sushi Master', 'image': Icons.set_meal, 'color': const Color(0xFFFF8C42)},
    {'name': 'Seekh Kabab', 'price': 'Rs. 400', 'rating': 4.6, 'restaurant': 'BBQ Tonight', 'image': Icons.kitchen, 'color': const Color(0xFFA06A4B)},
    {'name': 'Butter Chicken', 'price': 'Rs. 550', 'rating': 4.7, 'restaurant': 'Taste of Lahore', 'image': Icons.restaurant, 'color': const Color(0xFF9B59B6)},
    {'name': 'Loaded Burger', 'price': 'Rs. 350', 'rating': 4.5, 'restaurant': 'Burger House', 'image': Icons.fastfood, 'color': const Color(0xFFE67E22)},
  ];

  List<Map<String, dynamic>> get _filteredRestaurants {
    return _restaurants.where((r) {
      bool stopMatch = _selectedStop == 'All' || r['stop'] == _selectedStop;
      bool cuisineMatch = _selectedCuisine == 'All' || r['cuisine'] == _selectedCuisine;
      return stopMatch && cuisineMatch;
    }).toList();
  }

  List<Map<String, dynamic>> get _topRatedRestaurants {
    List<Map<String, dynamic>> sorted = List.from(_restaurants);
    sorted.sort((a, b) => b['rating'].compareTo(a['rating']));
    return sorted.take(5).toList();
  }

  List<Map<String, dynamic>> get _filteredDishes {
    if (_selectedCuisine != 'All') {
      return _dishes.where((dish) {
        return _restaurants.any((r) => r['name'] == dish['restaurant'] && r['cuisine'] == _selectedCuisine);
      }).toList();
    }
    return _dishes;
  }

  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages.addAll([
      HomePage(
        userName: widget.userName,
        selectedStop: _selectedStop,
        onStopChanged: (newStop) {
          setState(() {
            _selectedStop = newStop;
          });
        },
        selectedCuisine: _selectedCuisine,
        onCuisineChanged: (newCuisine) {
          setState(() {
            _selectedCuisine = newCuisine;
          });
        },
        filteredRestaurants: _filteredRestaurants,
        topRatedRestaurants: _topRatedRestaurants,
        filteredDishes: _filteredDishes,
        stopLocations: _stopLocations,
        cuisines: _cuisines,
      ),
      const SearchScreen(),
      const CartScreen(),
      const ProfileScreen(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedItemColor: const Color(0xFF2D6A4F),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final String userName;
  final String selectedStop;
  final Function(String) onStopChanged;
  final String? selectedCuisine;
  final Function(String?) onCuisineChanged;
  final List<Map<String, dynamic>> filteredRestaurants;
  final List<Map<String, dynamic>> topRatedRestaurants;
  final List<Map<String, dynamic>> filteredDishes;
  final List<String> stopLocations;
  final List<String> cuisines;

  const HomePage({
    super.key,
    required this.userName,
    required this.selectedStop,
    required this.onStopChanged,
    required this.selectedCuisine,
    required this.onCuisineChanged,
    required this.filteredRestaurants,
    required this.topRatedRestaurants,
    required this.filteredDishes,
    required this.stopLocations,
    required this.cuisines,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF2D6A4F),
        title: const Text('FoodOnTheGo', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchScreen()),
              );
            },
          ),
          const SizedBox(width: 8),
          Container(
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2),
              shape: BoxShape.circle,
            ),
            child: const CircleAvatar(
              radius: 16,
              backgroundColor: Colors.white,
              child: Icon(Icons.directions_car, color: Color(0xFF2D6A4F), size: 20),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Original Hero Banner (restored)
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF2D6A4F), Color(0xFF52B788)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 32, 24, 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(
                            Icons.emoji_events,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Welcome back, $userName!',
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Ready for your next meal on the motorway?',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white.withOpacity(0.9),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatItem(Icons.restaurant, '15+', 'Restaurants'),
                        _buildStatItem(Icons.star, '4.5', 'Avg Rating'),
                        _buildStatItem(Icons.access_time, '30min', 'Fast Delivery'),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Stop Filter Dropdown
            Padding(
              padding: const EdgeInsets.all(20),
              child: DropdownButtonFormField<String>(
                initialValue: selectedStop,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: const Icon(Icons.location_on, color: Color(0xFF2D6A4F)),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                ),
                items: [
                  const DropdownMenuItem(value: 'All', child: Text('All Motorway Stops')),
                  ...stopLocations.map((s) => DropdownMenuItem(value: s, child: Text(s))),
                ],
                onChanged: (val) => onStopChanged(val!),
              ),
            ),

            // Cuisine Horizontal List (Chips style)
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: cuisines.length,
                itemBuilder: (context, i) {
                  bool isSelected = selectedCuisine == cuisines[i];
                  return GestureDetector(
                    onTap: () => onCuisineChanged(cuisines[i]),
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFF2D6A4F) : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: isSelected ? Colors.transparent : Colors.grey[300]!),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        cuisines[i],
                        style: TextStyle(color: isSelected ? Colors.white : Colors.black, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 25),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text('Top Rated Restaurants', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),

            // Top Restaurants Horizontal List
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(20),
                itemCount: topRatedRestaurants.length,
                itemBuilder: (context, i) {
                  final r = topRatedRestaurants[i];
                  return Container(
                    width: 160,
                    margin: const EdgeInsets.only(right: 15),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 80,
                          decoration: BoxDecoration(color: r['color'], borderRadius: const BorderRadius.vertical(top: Radius.circular(20))),
                          child: Center(child: Icon(r['icon'], color: Colors.white, size: 40)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(r['name'], style: const TextStyle(fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis),
                              Text(r['cuisine'], style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  const Icon(Icons.star, color: Colors.orange, size: 14),
                                  Text(' ${r['rating']}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                                  const Spacer(),
                                  const Icon(Icons.access_time, size: 12, color: Colors.grey),
                                  Text(' ${r['deliveryTime'].split(' ')[0]}', style: const TextStyle(fontSize: 11, color: Colors.grey)),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text('Popular Dishes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),

            // Fixed Grid View - No overflow
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 0.72,
              ),
              itemCount: filteredDishes.length,
              itemBuilder: (context, i) {
                final dish = filteredDishes[i];
                return Container(
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(color: dish['color'].withOpacity(0.2), borderRadius: const BorderRadius.vertical(top: Radius.circular(20))),
                          child: Center(child: Icon(dish['image'], size: 50, color: dish['color'])),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(dish['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14), maxLines: 1, overflow: TextOverflow.ellipsis),
                            Text(dish['restaurant'], style: TextStyle(color: Colors.grey[500], fontSize: 11), maxLines: 1),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(dish['price'], style: const TextStyle(color: Color(0xFF2D6A4F), fontWeight: FontWeight.bold, fontSize: 13)),
                                Row(
                                  children: [
                                    const Icon(Icons.star, color: Colors.orange, size: 12),
                                    Text(' ${dish['rating']}', style: const TextStyle(fontSize: 11)),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: double.infinity,
                              height: 35,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF2D6A4F),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  padding: EdgeInsets.zero,
                                ),
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Added ${dish['name']} to cart')),
                                  );
                                },
                                child: const Text('Add to Cart', style: TextStyle(color: Colors.white, fontSize: 12)),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 24),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}