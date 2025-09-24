import 'package:cooksy/Screens/foodDetail/widgets/ConfirmationDialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class DateSelectionSheet extends StatefulWidget {
  const DateSelectionSheet({super.key});

  @override
  State<DateSelectionSheet> createState() => _DateSelectionSheetState();
}

class _DateSelectionSheetState extends State<DateSelectionSheet> {
  String selectedDate = 'Today';

  final List<Map<String, String>> dates = [
    {'date': 'Today', 'day': ''},
    {'date': '13 March', 'day': 'Monday'},
    {'date': '14 March', 'day': 'Tuesday'},
    {'date': '15 March', 'day': 'Wednesday'},
    {'date': '16 March', 'day': 'Thursday'},
    {'date': '17 March', 'day': 'Friday'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHandleBar(),
          _buildContent(),
        ],
      ),
    );
  }

  Widget _buildHandleBar() {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      height: 4,
      width: 40,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(),
          const SizedBox(height: 20),
          _buildDateList(),
          const SizedBox(height: 20),
          _buildContinueButton(),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      'Select Date',
      style: GoogleFonts.roboto(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    );
  }

  Widget _buildDateList() {
    return Column(
      children: dates.map((dateInfo) => _buildDateItem(dateInfo)).toList(),
    );
  }

  Widget _buildDateItem(Map<String, String> dateInfo) {
    final isSelected = selectedDate == dateInfo['date'];

    return GestureDetector(
      onTap: () => setState(() => selectedDate = dateInfo['date']!),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFFF0F0) : Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFFA93929) : Colors.transparent,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            _buildRadioIndicator(isSelected),
            const SizedBox(width: 16),
            _buildDateText(dateInfo, isSelected),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioIndicator(bool isSelected) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? const Color(0xFFA93929) : Colors.transparent,
        border: Border.all(
          color: isSelected ? const Color(0xFFA93929) : Colors.grey[400]!,
          width: 2,
        ),
      ),
      child: isSelected
          ? Center(
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
            )
          : null,
    );
  }

  Widget _buildDateText(Map<String, String> dateInfo, bool isSelected) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            dateInfo['date']!,
            style: GoogleFonts.roboto(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          if (dateInfo['day']!.isNotEmpty)
            Text(
              dateInfo['day']!,
              style: GoogleFonts.roboto(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildContinueButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () => _handleContinuePressed(),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFA93929),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 0,
        ),
        child: Text(
          'Continue',
          style: GoogleFonts.roboto(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void _handleContinuePressed() {
    Navigator.pop(context); // Close the date selection sheet
    showDialog(
      context: context,
      builder: (context) => ConfirmationDialog(selectedDate: selectedDate),
    );
  }
}
