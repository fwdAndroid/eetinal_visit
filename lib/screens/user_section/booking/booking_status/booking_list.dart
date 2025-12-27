import 'package:eetinal_visit/screens/user_section/detail_screens_user_section/booking_detail_screen.dart';
import 'package:eetinal_visit/widgets/booking_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookingList extends StatelessWidget {
  final String status;
  const BookingList({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: 5, // replace with API data
      itemBuilder: (context, index) {
        return BookingCard(
          status: status,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BookingDetailScreen(status: status),
              ),
            );
          },
        );
      },
    );
  }
}
