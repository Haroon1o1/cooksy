import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TrackingUI extends StatelessWidget {
  final int currentStep; // which stage is active

  const TrackingUI({super.key, this.currentStep = 2});

  @override
  Widget build(BuildContext context) {
    final stages = [
      {"title": "Order Placed", "icon": Icons.shop, "time": "14:10"},
      {"title": "Preparing Food", "icon": Icons.shop, "time": "14:20"},
      {"title": "Cooking", "icon": Icons.shop, "time": "14:35"},
      {"title": "Out for Delivery", "icon": Icons.shop, "time": "15:00"},
      {"title": "Delivered", "icon": Icons.shop, "time": "15:30"},
    ];

    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Order Tracking", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
          backgroundColor: const Color(0xFFA93929),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Header card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFA93929),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage("assets/images/profile.jpg"),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Emma's Kitchen",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Soho, London",
                            style: GoogleFonts.poppins(fontSize: 12, color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "PKR 2000",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Timeline
              Expanded(
                child: ListView.builder(
                  itemCount: stages.length,
                  itemBuilder: (context, index) {
                    final stage = stages[index];
                    final isActive = index <= currentStep;

                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Timeline column
                        Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isActive ? const Color(0xFFA93929) : Colors.grey.shade300,
                              ),
                              child: Icon(
                                stage["icon"] as IconData,
                                size: 20,
                                color: isActive ? Colors.white : Colors.grey,
                              ),
                            ),
                            if (index < stages.length - 1)
                              Container(
                                height: 50,
                                width: 2,
                                color: isActive ? const Color(0xFFA93929) : Colors.grey.shade300,
                              ),
                          ],
                        ),
                        const SizedBox(width: 16),

                        // Stage text
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                stage["title"] as String,
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: isActive ? const Color(0xFFA93929) : Colors.grey.shade600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                stage["time"] as String,
                                style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey),
                              ),
                              const SizedBox(height: 30),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              // Bottom button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFA93929),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text(
                    "Contact Rider",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
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
