import 'package:cooksy/Screens/HomeScreen/Widgets/searchField.dart';
import 'package:cooksy/Screens/orderHistory/widget/orderCard.dart';
import 'package:cooksy/widgets/CustomButton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderHistoryScreen extends StatelessWidget {
  OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xFFA93929),
          title: Text(
            'My Orders',
            style: GoogleFonts.poppins(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SizedBox(height: 16),

                // Tabs
                DefaultTabController(
                  length: 2,
                  child: Expanded(
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TabBar(
                            dividerColor: Colors.white,
                            indicator: BoxDecoration(
                              color: Color(0xFFA93929),
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                            ),
                            indicatorSize:
                                TabBarIndicatorSize.tab, // ✅ makes indicator cover full tab
                            labelColor: Colors.white,
                            unselectedLabelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w400),
                            labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                            unselectedLabelColor: Color(0xFFA93929),
                            tabs: [
                              Tab(text: 'Active Orders'),
                              Tab(text: 'Past Orders'),
                            ],
                          ),
                        ),

                        SizedBox(height: 8),

                        // Search bar
                        SearchField(),

                        SizedBox(height: 8),

                        // Tab contents
                        Expanded(
                          child: TabBarView(
                            children: [
                              // Active Orders Tab
                              ListView(
                                children: [
                                  BuildOrderCard(
                                    isActive: true,
                                    isRated: false,
                                    name: "Healthy Bites",
                                    location: "Camden, London",
                                    items: [
                                      {"name": "2 Portions Olive Oil Bulgur Salad", "price": "900"},
                                      {"name": "2 Portions Steamed Broccoli", "price": "950"},
                                      {"name": "2 Portions Steamed Broccoli", "price": "950"},
                                    ],
                                    date: "10.03.23 - Friday | 11:30",
                                  ),
                                ],
                              ),

                              // Past Orders Tab
                              ListView(
                                children: [
                                  BuildOrderCard(
                                    isRated: true,
                                    name: "Emma's Kitchen",
                                    location: "Soho, London",
                                    items: [
                                      {"name": "1 Portion Olive Oil Fresh Beans", "price": "550"},
                                      {"name": "1 Portion Vermicelli Rice", "price": "250"},
                                    ],
                                    date: "14.03.23 - Tuesday | 14:43",
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
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
}
