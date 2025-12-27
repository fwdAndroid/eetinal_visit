import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookingCard extends StatelessWidget {
  final String status;
  final VoidCallback onTap;

  const BookingCard({super.key, required this.status, required this.onTap});

  Color get badgeColor {
    switch (status) {
      case "completed":
        return Colors.green;
      case "pending":
        return Colors.orange;
      default:
        return Colors.blue;
    }
  }

  String get badgeText {
    switch (status) {
      case "completed":
        return "Completed";
      case "pending":
        return "Pending";
      default:
        return "Started";
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.only(bottom: 12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  "https://picsum.photos/200",
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("AC Repair Service",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold)),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: badgeColor,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            badgeText,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 12),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 6),
                    const Text("Service No: #SRV-2345"),
                    const SizedBox(height: 4),
                    const Text("₹ 1,200 • 12 Aug 2025 • 04:00 PM"),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
