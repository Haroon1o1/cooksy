import 'package:cooksy/Screens/HomeScreen/Widgets/bottomNavar.dart';
import 'package:cooksy/Screens/HomeScreen/Widgets/categoryItem.dart';
import 'package:cooksy/Screens/HomeScreen/Widgets/chefCard.dart';
import 'package:cooksy/Screens/HomeScreen/Widgets/searchField.dart';
import 'package:cooksy/Screens/HomeScreen/Widgets/topBar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  String _searchQuery = '';
  String _selectedCategory = 'All';

  final List<Map<String, dynamic>> _chefs = [
    {
      'name': "Sarah's Kitchen",
      'image': 'assets/images/nonveg1.jpg',
      'distance': '1.2 km',
      'rating': 4.7,
      'reviews': 143,
      'isFollowed': false,
    },
    {
      'name': "Emy's Kitchen",
      'image': 'assets/images/veg1.jpg',
      'distance': '2.7 km',
      'rating': 4.2,
      'reviews': 187,
      'isFollowed': false,
    },
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        break;
      case 1:
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Order screen')));
        break;
      case 2:
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Nearby screen')));
        break;
      case 3:
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profile screen')));
        break;
    }
  }

  void _toggleFollow(int index) {
    setState(() {
      _chefs[index]['isFollowed'] = !_chefs[index]['isFollowed'];
    });
  }

  List<Map<String, dynamic>> get _filteredChefs {
    return _chefs.where((chef) {
      final nameMatches = chef['name'].toLowerCase().contains(_searchQuery.toLowerCase());
      return nameMatches;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: Offset(0, -5)),
          ],
        ),
        child: CustomBottomNavBar(selectedIndex: _selectedIndex, onItemTapped: _onItemTapped),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeTopBar(),
                SizedBox(height: 10),

                // Search Bar
                SearchField(),
                SizedBox(height: 10),

                // Categories
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Categories",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    Icon(Icons.arrow_forward, color: Color(0xFFA93929), size: 20),
                  ],
                ),
                SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [


                    CategoryItem(icon:"assets/icons/menu.png", title: "All",),
                    CategoryItem(icon:"assets/icons/discount.png", title: "Discounts"),
                    CategoryItem(icon:"assets/icons/veg.png", title: "Veg"),
                    CategoryItem(icon:"assets/icons/nonveg.png", title: "Non Veg"),
                  ],
                ),
                SizedBox(height: 10),

                // Nearby Chefs
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Nearby Chefs",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),

                ..._filteredChefs.asMap().entries.map((entry) {
                  int index = entry.key;
                  Map<String, dynamic> chef = entry.value;
                  return Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: ChefCard(
                      name: chef['name'],
                      imgUrl: chef['image'],
                      distance: chef['distance'],
                      rating: chef['rating'],
                      reviews: chef['reviews'],
                      isFollowed: chef['isFollowed'],
                      onFollowTap: () => _toggleFollow(index),
                    ),
                  );
                }).toList(),

                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
