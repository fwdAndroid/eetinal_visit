import 'package:eetinal_visit/screens/user_section/booking/booking_status/booking_list.dart';
import 'package:eetinal_visit/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserBookingScreen extends StatefulWidget {
  const UserBookingScreen({super.key});

  @override
  State<UserBookingScreen> createState() => _UserBookingScreenState();
}

class _UserBookingScreenState extends State<UserBookingScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: mainColor,
          title: const Text("My Bookings",style: TextStyle(color: Colors.white),),
          bottom: const TabBar(
            tabs: [
              Tab(text: "In Progress"),
              Tab(text: "Completed"),
              Tab(text: "Pending"),
            ],
            indicatorColor: Colors.white,
            labelColor: Colors.white,
          ),
        ),
        body: const TabBarView(
          children: [
            BookingList(status: "in_progress"),
            BookingList(status: "completed"),
            BookingList(status: "pending"),
          ],
        ),
      ),
    );
  }
}
