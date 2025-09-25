import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatBubble extends StatelessWidget {
  final bool isMe;
  final String text;
  final String time;
  final String image;

  const ChatBubble({
    super.key,
    required this.isMe,
    required this.text,
    required this.time,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isMe) CircleAvatar(radius: 14, backgroundImage: AssetImage(image)),
          const SizedBox(width: 6),
          Flexible(
            child: Column(
              crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: isMe ? Colors.red.shade50 : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    text,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Text(time, style: GoogleFonts.poppins(fontSize: 10, color: Colors.grey)),
              ],
            ),
          ),
          if (isMe) const SizedBox(width: 6),
          if (isMe) CircleAvatar(radius: 14, backgroundImage: AssetImage(image)),
        ],
      ),
    );
  }
}
