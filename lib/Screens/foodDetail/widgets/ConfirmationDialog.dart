import 'package:cooksy/Screens/foodDetail/widgets/OrderConfirmationSheet.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConfirmationDialog extends StatelessWidget {
  final String selectedDate;

  const ConfirmationDialog({super.key, required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(
        'Confirm Order',
        style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
      ),
      content: Text(
        'Are you sure you want to place this order for $selectedDate?',
        style: GoogleFonts.roboto(fontSize: 14, color: Colors.grey[600]),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel', style: GoogleFonts.roboto(fontSize: 14, color: Colors.grey[600])),
        ),
        ElevatedButton(
          onPressed: () => _handleConfirm(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFA93929),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: Text(
            'Confirm',
            style: GoogleFonts.roboto(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  void _handleConfirm(BuildContext context) {
    Navigator.pop(context); // Close dialog
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => OrderConfirmationSheet(selectedDate: selectedDate),
    );
  }
}
