import 'package:cooksy/Screens/ChefScreen/widgets/cheffDetailsMenu.dart';
import 'package:cooksy/models/restaurants.dart';
import 'package:cooksy/widgets/CustomButton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


   void resturantInfo(BuildContext context, Restaurant resturant) {
     showModalBottomSheet(
      backgroundColor: Colors.white,
      isScrollControlled: true, // important for scrollable content
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 150,
                  height: 7,
                  decoration: BoxDecoration(
                    color: Color(0xFFA93929),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              // TOP ROW
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: MediaQuery.of(context).size.width * 0.08,
                    backgroundImage: AssetImage('assets/images/profile.jpg'),
                  ),
                  SizedBox(width: 16),

                  // Name + Location + Rating
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Olivia's Kitchen",
                          style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "Soho, London",
                          style: GoogleFonts.poppins(color: Colors.grey[600], fontSize: 11),
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Color(0xFFA93929),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.star, color: Colors.white, size: 12),
                                  SizedBox(width: 4),
                                  Text(
                                    "4.4",
                                    style: GoogleFonts.poppins(color: Colors.white, fontSize: 10),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 8),
                            Flexible(
                              child: Text(
                                "98 Reviews",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(color: Colors.grey[600], fontSize: 10),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Buttons
                  Column(
                    children: [
                      SizedBox(
                        width: 100,
                        child: CustomButton(
                          height: 30,
                          textColor: Colors.white,
                          text: "Follow",
                          press: () {},
                          size: 13,
                          hasIcon: false,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 100,
                        child: CustomButton(
                          height: 30,
                          textColor: Colors.white,
                          text: "Explore",
                          press: () {},
                          size: 13,
                          hasIcon: false,
                          color: Color(0xFFA93929),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 12),

              // Description
              Text(
                "Description written for testing very long description to see if it’s flexible...",
                style: GoogleFonts.poppins(color: Colors.grey[600], fontSize: 12),
              ),

              SizedBox(height: 12),

              // Horizontal Menu Items
              SizedBox(
                height: 250, // <-- fixed height here
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: CheffDetailsMenu(
                        price: "2000 PKR",
                        imgUrl: "assets/images/veg1.jpg",
                        name: "Special BBQ Tikka",
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
