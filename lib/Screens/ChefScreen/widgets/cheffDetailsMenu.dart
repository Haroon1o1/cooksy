import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CheffDetailsMenu extends StatelessWidget {
  final String name;
  final String imgUrl;
  final String price;
  final bool isFavorite;

  const CheffDetailsMenu({
    super.key,
    required this.name,
    required this.imgUrl,
    required this.price,
    this.isFavorite = false,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        width: MediaQuery.of(context).size.width * 0.89,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 10,
              offset: const Offset(2, 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.asset(
                    imgUrl,
                    height: 160,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                // Name + Favorite
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFFA93929),
                          ),
                        ),
                      ),
                      Icon(Icons.favorite, color: isFavorite ? Colors.red : Colors.grey),
                    ],
                  ),
                ),
              ],
            ),

            // Price Tag
            Positioned(
              top: 12,
              right: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFA93929),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  price,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
