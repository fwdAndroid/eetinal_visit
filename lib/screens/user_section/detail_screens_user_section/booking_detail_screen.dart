import 'package:flutter/material.dart';

class BookingDetailScreen extends StatelessWidget {
  final String status;
  const BookingDetailScreen({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Booking Details")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("AC Repair Service",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Text("Service Number: #SRV-2345"),
            const Text("Price: ₹ 1,200"),
            const Text("Date & Time: 12 Aug • 04:00 PM"),
            const Divider(height: 30),

            /// Only for IN PROGRESS
            if (status == "in_progress")
              ElevatedButton(
                onPressed: () {
                  // update status to completed
                },
                child: const Text("Mark Project Done"),
              ),

            /// Only for COMPLETED
            if (status == "completed") ...[
              const SizedBox(height: 20),
              const Text("Leave a Review",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextField(
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: "Write your review",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  // submit review
                },
                child: const Text("Submit Review"),
              )
            ],
          ],
        ),
      ),
    );
  }
}
