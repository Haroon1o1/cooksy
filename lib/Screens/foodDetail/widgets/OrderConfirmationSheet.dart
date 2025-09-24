import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderConfirmationSheet extends StatelessWidget {
  final String selectedDate;

  const OrderConfirmationSheet({super.key, required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [_buildHandleBar(), _buildContent(context)],
      ),
    );
  }

  Widget _buildHandleBar() {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      height: 4,
      width: 40,
      decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2)),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildSuccessIcon(),
          const SizedBox(height: 20),
          _buildTitle(),
          const SizedBox(height: 16),
          _buildOrderDetails(),
          const SizedBox(height: 20),
          _buildCustomerServiceText(),
          const SizedBox(height: 20),
          _buildKitchenInfo(),
          const SizedBox(height: 16),
          _buildPreparationTime(),
          const SizedBox(height: 20),
          _buildDoneButton(context),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }

  Widget _buildSuccessIcon() {
    return Container(
      width: 80,
      height: 80,
      decoration: const BoxDecoration(color: Color(0xFFFFF0F0), shape: BoxShape.circle),
      child: const Icon(Icons.check, color: Color(0xFFA93929), size: 40),
    );
  }

  Widget _buildTitle() {
    return Text(
      'We\'ve Received Your Order, Alex! 😊',
      style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildOrderDetails() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.grey[50], borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildOrderDetail('Order No:', '242342'),
          _buildOrderDetail('Order Time:', '14:32'),
          _buildOrderDetail('Delivery Date:', selectedDate),
        ],
      ),
    );
  }

  Widget _buildOrderDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: GoogleFonts.roboto(fontSize: 14, color: Colors.grey[600])),
          Text(
            value,
            style: GoogleFonts.roboto(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerServiceText() {
    return Text(
      'For any questions or updates, feel free to contact our customer service.',
      style: GoogleFonts.roboto(fontSize: 14, color: Colors.grey[600], height: 1.4),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildKitchenInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          _buildKitchenAvatar(),
          const SizedBox(width: 12),
          _buildKitchenDetails(),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildKitchenAvatar() {
    return CircleAvatar(
      radius: 20,
      backgroundColor: Colors.grey[300],
      child: Icon(Icons.store, color: Colors.grey[600], size: 20),
    );
  }

  Widget _buildKitchenDetails() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Olivia\'s Kitchen',
            style: GoogleFonts.roboto(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          Text('(Soho, London)', style: GoogleFonts.roboto(fontSize: 12, color: Colors.grey[300])),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        _buildIconButton(
          icon: Icons.message,
          backgroundColor: Colors.white,
          iconColor: Colors.black,
          onPressed: () {},
        ),
        _buildIconButton(
          icon: Icons.call,
          backgroundColor: const Color(0xFFA93929),
          iconColor: Colors.white,
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required Color backgroundColor,
    required Color iconColor,
    required VoidCallback onPressed,
  }) {
    return IconButton(
      onPressed: onPressed,
      icon: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
        child: Icon(icon, color: iconColor, size: 20),
      ),
    );
  }

  Widget _buildPreparationTime() {
    return Text(
      'Preparing / 14:42',
      style: GoogleFonts.roboto(fontSize: 12, color: Colors.grey[600]),
    );
  }

  Widget _buildDoneButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () => Navigator.pop(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFA93929),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 0,
        ),
        child: Text(
          'Done',
          style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
    );
  }
}
