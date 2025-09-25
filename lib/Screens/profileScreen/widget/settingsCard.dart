// widgets/settings_card.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsCard extends StatelessWidget {
  final List<Map<String, dynamic>> items;

  const SettingsCard({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 3, offset: const Offset(2, 2))],
      ),
      child: Column(
        children: items
            .map(
              (item) => Column(
                children: [
                  ListTile(
                    leading: Icon(item["icon"], color: Colors.black87, size: 20), // smaller icon
                    title: Text(
                      item["title"],
                      style: GoogleFonts.poppins(fontSize: 13), // smaller font
                    ),
                    trailing: const Icon(Icons.chevron_right, size: 18),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12), // tighter padding
                    dense: true, // optional (older Flutter versions)
                    visualDensity: const VisualDensity(
                      horizontal: 0,
                      vertical: -4,
                    ), // reduce height
                    onTap: () {},
                  ),

                  if (item != items.last) const Divider(indent: 50, thickness: 0.5),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}
