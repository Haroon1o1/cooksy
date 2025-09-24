import 'package:cooksy/Screens/ChefScreen/CheffScreen.dart';
import 'package:cooksy/Screens/foodDetail/widgets/priceContainer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FoodDetailsCheffTitle extends StatelessWidget {
  const FoodDetailsCheffTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => CheffScreen()));
          },
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(image: AssetImage("assets/images/profile.jpg")),
            ),
            // backgroundColor: Colors.grey[300],
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Baked Meatballs with Chickpeas',
                style: GoogleFonts.poppins(
                  fontSize: screenWidth < 350 ? 15 : 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 2),
              Text(
                'Ege Denon',
                style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600]),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        SizedBox(width: 8),
        Pricecontainer(),
      ],
    );
  }
}
