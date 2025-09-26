import 'package:cooksy/Screens/ChatScreen/Widgets/chat_bubble.dart';
import 'package:cooksy/Screens/ChatScreen/Widgets/message_input_bar.dart';
import 'package:cooksy/Screens/ChatScreen/Widgets/time_label.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatDetailScreen extends StatelessWidget {
  const ChatDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFFA93929),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            CircleAvatar(radius: 18, backgroundImage: AssetImage("assets/images/profile.jpg")),
            const SizedBox(width: 10),
            Text(
              "PrimeNest Partners",
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.call_outlined, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              children: [
                TimeLabel(label: "Today"),
                ChatBubble(
                  isMe: false,
                  text:
                      "Hi, I'm looking for a 2-bedroom rental home in a quiet neighborhood. Do you have any available listings?",
                  time: "8:30 PM",
                  image: "assets/images/veg1.jpg",
                ),
                ChatBubble(
                  isMe: true,
                  text:
                      "Hello! Yes, we have several options that might suit you. Are you looking for any specific features like a garden, garage, or proximity to certain areas?",
                  time: "8:35 PM",
                  image: "assets/images/profile.jpg",
                ),
                ChatBubble(
                  isMe: false,
                  text:
                      "That's great to hear! I'm particularly interested in a place with a small garden and a garage. Proximity to schools would be a plus as well.",
                  time: "8:39 PM",
                  image: "assets/images/veg1.jpg",
                ),
                ChatBubble(
                  isMe: true,
                  text:
                      "I'll send you the details right away! Utilities are not included, but the house has energy-efficient appliances, so utility costs are relatively low.",
                  time: "9:00 PM",
                  image: "assets/images/profile.jpg",
                ),
                ChatBubble(
                  isMe: false,
                  text:
                      "Wonderful! I'll book the time and send you the address. Let me know if you have any questions before then.",
                  time: "9:30 PM",
                  image: "assets/images/veg1.jpg",
                ),
              ],
            ),
          ),
          const MessageInputBar(),
        ],
      ),
    );
  }
}
