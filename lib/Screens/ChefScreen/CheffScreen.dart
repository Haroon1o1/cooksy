import 'package:cooksy/Screens/ChatScreen/Screens/ChatDetailScreen.dart';
import 'package:cooksy/Screens/ChefScreen/widgets/ChefHeader.dart';
import 'package:cooksy/Screens/ChefScreen/widgets/CheffDetailsPosts.dart';
import 'package:cooksy/Screens/ChefScreen/widgets/CheffReviews.dart';
import 'package:cooksy/Screens/ChefScreen/widgets/cheffDetailsMenu.dart';
import 'package:cooksy/Screens/HomeScreen/Widgets/categoryItem.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CheffScreen extends StatefulWidget {
  const CheffScreen({super.key});

  @override
  State<CheffScreen> createState() => _CheffScreenState();
}

class _CheffScreenState extends State<CheffScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Height of header + overlapping card
    final double headerHeight = 260;
    final double cardOverlap = 40;

    return SafeArea(
      top: false,

      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFFA93929),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ChatDetailScreen()));
          },
          child: Icon(Icons.chat, color:Colors.white),
        ),
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    backgroundColor: Colors.white,
                    isScrollControlled: true,
                    builder: (context) {
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                          top: 20,
                          left: 20,
                          right: 20,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Container(
                                width: 50,
                                height: 5,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              "About Me",
                              style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "I am a professional chef with 10 years of experience specializing in BBQ and traditional cuisine. Passionate about creating unforgettable dining experiences.",
                              style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[700]),
                            ),
                            SizedBox(height: 20),
                            Text(
                              "Timing",
                              style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Mon - Fri: 10:00 AM - 8:00 PM\nSat - Sun: 11:00 AM - 6:00 PM",
                              style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[700]),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      );
                    },
                  );
                },
                icon: Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info, color: Color(0xFFA93929), size: 18),
                      SizedBox(width: 8),
                      Text(
                        "About me",
                        style: GoogleFonts.poppins(color: Colors.black, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
          backgroundColor: Colors.transparent,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.white),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
          ),
        ),
        body: Column(
          children: [
            // Header Stack
            SizedBox(height: headerHeight + cardOverlap, child: CheffDetailsHeader()),

            // TabBar
            Container(
              color: Colors.white,
              child: TabBar(
                dividerColor: Colors.white,
                controller: _tabController,
                indicatorColor: Color(0xFFA93929),
                unselectedLabelStyle: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  color: Colors.grey.shade600,
                ),
                labelStyle: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFA93929),
                ),
                tabs: [
                  Tab(text: "Menu"),
                  Tab(text: "Posts"),
                  Tab(text: "Reviews"),
                ],
              ),
            ),

            // TabBarView
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // MENU TAB
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CategoryItem(
                                icon: "assets/icons/menu.png",
                                title: "All",
                                isSelected: true,
                              ),
                              CategoryItem(icon: "assets/icons/discount.png", title: "Discounts"),
                              CategoryItem(icon: "assets/icons/veg.png", title: "Veg"),
                              CategoryItem(icon: "assets/icons/nonveg.png", title: "Non Veg"),
                            ],
                          ),

                          // Header Row
                          SizedBox(height: 10),

                          // List of menu items
                          ListView.builder(
                            padding: EdgeInsets.zero, // optional
                            shrinkWrap: true, // important: makes list take only needed space
                            physics: NeverScrollableScrollPhysics(), // disables internal scrolling
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return CheffDetailsMenu(
                                price: "2000 PKR",
                                imgUrl: "assets/images/veg1.jpg",
                                name: "Special BBQ Tikka",
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  // MEDIA TAB
                  ListView.builder(
                    padding: EdgeInsets.all(20),
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return CheffDetailsPosts(
                        description:
                            "Experience the ultimate BBQ delight with our Special Tikka, crafted from tender, marinated meat grilled to perfection. Bursting with rich, smoky flavors and balanced spices, it’s a treat for all barbecue enthusiasts. Perfect for family gatherings or a gourmet weekend feast, this dish promises an unforgettable culinary experience.",
                        imgUrl: "assets/images/veg1.jpg",
                        name: "Special BBQ Tikka",
                      );
                    },
                  ),

                  // REVIEWS TAB
                  ListView.builder(
                    padding: EdgeInsets.all(20),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return CheffReview(
                        rating: 4,
                        userName: 'John Smith',
                        date: '05 November',
                        review:
                            'Great food overall. I would have liked a bit more variety in the sides.',
                        avatarUrl: 'assets/images/profile.jpg',
                      );
                    },
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
