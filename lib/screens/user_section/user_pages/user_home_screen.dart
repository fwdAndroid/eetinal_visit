import 'package:eetinal_visit/screens/auth/login_screen.dart';
import 'package:eetinal_visit/screens/user_section/user_tabs_section/care_page.dart';
import 'package:eetinal_visit/screens/user_section/user_tabs_section/offer_care_page.dart';
import 'package:eetinal_visit/utils/colors.dart';
import 'package:flutter/material.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen>   with SingleTickerProviderStateMixin{
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
       appBar: AppBar(
        backgroundColor: colorWhite,
        actions: [
          TextButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (builder) => LoginScreen()));
          }, child: Text("Login",style: TextStyle(color: mainColor),))
        ],
        leading: Image.asset("assets/splash.png"),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(110),
          child: Column(
            children: [
              // Search Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: "Search care or providers",
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // Tabs
              TabBar(
                controller: _tabController,
                labelColor: mainColor,
                unselectedLabelColor: Colors.grey,
                indicatorColor: mainColor,
                tabs: const [
                  Tab(text: "Care"),
                  Tab(text: "Offer Care"),
                ],
              ),
            ],
          ),
        ),
     ), body: TabBarView(
              controller: _tabController,

      children: [
          CarePage(),
          OfferCarePage(),
      ]), );
  }
}