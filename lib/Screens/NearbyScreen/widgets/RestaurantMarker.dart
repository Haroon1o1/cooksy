import 'package:cooksy/models/restaurants.dart';
import 'package:flutter/material.dart';

class RestaurantMarker extends StatelessWidget {
  final Restaurant restaurant;
  final VoidCallback onTap;
  final Offset position;

  RestaurantMarker({
    super.key,
    required this.restaurant,
    required this.onTap,
    required this.position,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx - 25,
      top: position.dy - 25,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Center(
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[300],
                    image: DecorationImage(image: AssetImage(restaurant.image)),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 10,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                  decoration: BoxDecoration(
                    color: Color(0xFFA93929),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.star, color: Colors.white, size: 10),
                      SizedBox(width: 2),
                      Text(
                        '${restaurant.rating}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
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
    );
  }
}
