import 'package:cooksy/Screens/ChefScreen/CheffScreen.dart';
import 'package:cooksy/Screens/TrackingUIScreen/trackingUiScreen.dart';
import 'package:cooksy/widgets/CustomButton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BuildOrderCard extends StatelessWidget {
  final String name;
  final bool isRated;
  final String location;
  final List<Map<String, String>> items;
  final String date;
  final bool isActive; // ✅ new parameter

  BuildOrderCard({
    super.key,
    required this.name,
    required this.isRated,
    required this.location,
    required this.items,
    required this.date,
    this.isActive = false, // ✅ default false
  });

  @override
  Widget build(BuildContext context) {
    // ✅ Auto calculate total
    double totalAmount = 0;
    for (var item in items) {
      String priceStr = item["price"] ?? "0";
      priceStr = priceStr.replaceAll(RegExp(r'[^0-9.]'), "");
      totalAmount += double.tryParse(priceStr) ?? 0.0;
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300, width: 1.2),
      ),
      margin: EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ Top row with image, title
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CheffScreen()),
                        );
                      },
                      child: CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage("assets/images/profile.jpg"),
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name, style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                        Text(
                          location,
                          style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
                Icon(Icons.print, color: Color(0xFFA93929), size: 30),
              ],
            ),

            SizedBox(height: 8),

            // ✅ Items list with divider
            Column(
              children: [
                for (int i = 0; i < items.length; i++) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          items[i]["name"] ?? "",
                          style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[700]),
                          maxLines: 2,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        "PKR ${items[i]["price"]}",
                        style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87),
                      ),
                    ],
                  ),
                  if (i < items.length - 1)
                    Divider(color: Colors.grey.shade300, thickness: 1, height: 12),
                ],
              ],
            ),

            // ✅ Auto total
            Divider(color: Colors.grey.shade300, thickness: 1, height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Color(0xFFA93929),
                  ),
                ),
                Text(
                  "PKR ${totalAmount.toStringAsFixed(2)}",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Color(0xFFA93929),
                  ),
                ),
              ],
            ),

            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isActive ? '🟡 In Progress' : '✅ Delivered',
                  style: GoogleFonts.poppins(
                    color: isActive ? Color(0xFFE6A700) : Color(0xFF3BAD3F),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(date, style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey)),
              ],
            ),

            SizedBox(height: 12),

            // ✅ Buttons section
            if (isActive) ...[
              CustomButton(
                height: 50,
                textColor: Colors.white,
                text: "Track your order",
                press: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => TrackingUI()));
                },
                hasIcon: true,
                icon: "assets/icons/track.png",
                size: 14,
                color: Color(0xFFA93929),
              ),
            ] else ...[
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      height: 50,
                      textColor: isRated ? Colors.amber : Colors.white,
                      text: isRated ? "⭐ 4.5 Given" : "Rate",
                      press: () {},
                      hasIcon: false,
                      size: 14,
                      color: isRated ? Colors.black.withValues(alpha: 0.7) : Colors.black,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: CustomButton(
                      height: 50,
                      textColor: Colors.white,
                      text: "Re-order",
                      press: () {},
                      hasIcon: false,
                      size: 14,
                      color: Color(0xFFA93929),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
