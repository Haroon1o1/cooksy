import 'package:flutter/material.dart';

class VoiceMessageBubble extends StatelessWidget {
  final bool isMe;
  final String time;
  final String image;

  const VoiceMessageBubble({
    super.key,
    required this.isMe,
    required this.time,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isMe) CircleAvatar(radius: 14, backgroundImage: AssetImage(image)),
          const SizedBox(width: 6),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 6),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.play_arrow, color: Colors.black),
                const SizedBox(width: 8),
                Container(
                  height: 24,
                  width: 120,
                  color: Colors.grey.shade400, // waveform placeholder
                ),
                const SizedBox(width: 8),
                const Icon(Icons.more_horiz, color: Colors.black),
              ],
            ),
          ),
          if (isMe) CircleAvatar(radius: 14, backgroundImage: AssetImage(image)),
        ],
      ),
    );
  }
}
