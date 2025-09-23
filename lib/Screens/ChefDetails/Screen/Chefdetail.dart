import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FoodDeliveryScreen extends StatefulWidget {
  @override
  _FoodDeliveryScreenState createState() => _FoodDeliveryScreenState();
}

class _FoodDeliveryScreenState extends State<FoodDeliveryScreen> {
  int selectedPortionCount = 1;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenHeight < 600;
    final expandedHeight = isSmallScreen ? 200.0 : (screenHeight * 0.35).clamp(200.0, 320.0);

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: expandedHeight,
            floating: false,
            pinned: true,
            elevation: 0,
            backgroundColor: Colors.white,
            leading: GestureDetector(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(Icons.arrow_back, color: Colors.black, size: 20),
              ),
            ),
            actions: [
              GestureDetector(
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(Icons.share, color: Colors.black, size: 20),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset('assets/images/veg1.jpg', fit: BoxFit.cover),
                  // Rating overlay
                  Positioned(
                    bottom: 16,
                    right: 16,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.star, color: Colors.red, size: 16),
                          SizedBox(width: 2),
                          Text(
                            '4.4',
                            style: GoogleFonts.roboto(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
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
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(screenWidth * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.grey[300],
                        child: Icon(Icons.person, color: Colors.grey[600], size: 20),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Baked Meatballs with Chickpeas',
                              style: GoogleFonts.roboto(
                                fontSize: screenWidth < 350 ? 16 : 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Ege Denonca',
                              style: GoogleFonts.roboto(fontSize: 14, color: Colors.grey[600]),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        '€ 2.7',
                        style: GoogleFonts.roboto(
                          fontSize: screenWidth < 350 ? 18 : 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 16),
                  Text(
                    'A traditional and delicious Turkish dish made with tender meatballs and chickpeas, baked to perfection with a rich blend of spices. Perfect for a hearty meal.',
                    style: GoogleFonts.roboto(fontSize: 14, color: Colors.grey[600], height: 1.4),
                  ),

                  SizedBox(height: 24),
                  Wrap(
                    spacing: 12,
                    runSpacing: 8,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Color(0xFFFFF0F0),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.access_time, color: Colors.red, size: 16),
                            SizedBox(width: 4),
                            Text(
                              'Today',
                              style: GoogleFonts.roboto(
                                fontSize: 12,
                                color: Colors.red,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Color(0xFFFFF0F0),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          '600 mg',
                          style: GoogleFonts.roboto(
                            fontSize: 12,
                            color: Colors.red,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      if (screenWidth > 320)
                        Text(
                          'Normal Delivery',
                          style: GoogleFonts.roboto(fontSize: 12, color: Colors.grey[600]),
                        ),
                    ],
                  ),

                  SizedBox(height: 24),
                  Text(
                    'Select Portion/Person Count',
                    style: GoogleFonts.roboto(
                      fontSize: screenWidth < 350 ? 15 : 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),

                  SizedBox(height: 12),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children:
                          List.generate(5, (index) {
                            int count = index + 1;
                            bool isSelected = selectedPortionCount == count;
                            double buttonSize = screenWidth < 350 ? 36 : 40;

                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedPortionCount = count;
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 12),
                                width: buttonSize,
                                height: buttonSize,
                                decoration: BoxDecoration(
                                  color: isSelected ? Colors.red : Colors.grey[100],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    count.toString(),
                                    style: GoogleFonts.roboto(
                                      fontSize: screenWidth < 350 ? 14 : 16,
                                      fontWeight: FontWeight.w500,
                                      color: isSelected ? Colors.white : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }) +
                          [
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                width: screenWidth < 350 ? 36 : 40,
                                height: screenWidth < 350 ? 36 : 40,
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.grey[600],
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                    ),
                  ),

                  SizedBox(height: 24),
                  Text(
                    'Leave a Note for the Seller',
                    style: GoogleFonts.roboto(
                      fontSize: screenWidth < 350 ? 15 : 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),

                  SizedBox(height: 12),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      maxLines: isSmallScreen ? 2 : 3,
                      decoration: InputDecoration(
                        hintText: 'Type here...',
                        hintStyle: GoogleFonts.roboto(fontSize: 14, color: Colors.grey[500]),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                      style: GoogleFonts.roboto(fontSize: 14, color: Colors.black),
                    ),
                  ),

                  SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(screenWidth * 0.05),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: Offset(0, -2)),
          ],
        ),
        child: SafeArea(
          child: Container(
            width: double.infinity,
            height: isSmallScreen ? 45 : 50,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                elevation: 0,
              ),
              child: Text(
                'Add to Basket',
                style: GoogleFonts.roboto(
                  fontSize: screenWidth < 350 ? 15 : 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
