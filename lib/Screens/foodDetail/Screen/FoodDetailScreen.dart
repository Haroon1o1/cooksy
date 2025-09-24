import 'package:cooksy/Screens/foodDetail/widgets/appBar.dart';
import 'package:cooksy/Screens/foodDetail/widgets/bottomButton.dart';
import 'package:cooksy/Screens/foodDetail/widgets/chefTitle.dart';
import 'package:cooksy/Screens/foodDetail/widgets/featuresTileWidget.dart';
import 'package:cooksy/Screens/foodDetail/widgets/portionWidget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FoodDetailScreen extends StatefulWidget {
  @override
  _FoodDetailScreenState createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  int selectedPortionCount = 1;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenHeight < 600;

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          FoodDetailsAppBar(),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(screenWidth * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FoodDetailsCheffTitle(),

                  SizedBox(height: 16),
                  Text(
                    'A traditional and delicious Turkish dish made with tender meatballs and chickpeas, baked to perfection with a rich blend of spices. Perfect for a hearty meal.',
                    style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[600], height: 1.2),
                  ),

                  SizedBox(height: 24),
                  Row(
                    children: [
                      FoodFeaturesTileWidget(
                        isBg: true,
                        text: 'Today',
                        icon: "assets/icons/timer.png",
                      ),
                      SizedBox(width: 8),
                      FoodFeaturesTileWidget(
                        isBg: true,
                        text: '600 mg',
                        icon: "assets/icons/weight.png",
                      ),
                      FoodFeaturesTileWidget(isBg: false, text: 'Normal Delievery', icon: ""),
                    ],
                  ),

                  SizedBox(height: 24),
                  Text(
                    'Select Portion (Person Count)',
                    style: GoogleFonts.poppins(
                      fontSize: screenWidth < 350 ? 14 : 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),

                  SizedBox(height: 12),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(5, (index) {
                        int count = index + 1;
                        return PortionWidget(
                          isSelected: count == 1 ? true : false,
                          value: count.toString(),
                        );
                      }),
                    ),
                  ),

                  SizedBox(height: 24),
                  Text(
                    'Leave a Note for the Seller',
                    style: GoogleFonts.poppins(
                      fontSize: screenWidth < 350 ? 14 : 15,
                      fontWeight: FontWeight.w500,
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
                        hintStyle: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[500]),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                      style: GoogleFonts.poppins(fontSize: 14, color: Colors.black),
                    ),
                  ),

                  SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomButton(),
    );
  }
}
