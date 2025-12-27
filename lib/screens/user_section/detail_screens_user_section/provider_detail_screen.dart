import 'package:eetinal_visit/screens/user_section/booking/booking_page_step_1.dart';
import 'package:eetinal_visit/utils/colors.dart';
import 'package:flutter/material.dart';

class ProviderDetailScreen extends StatelessWidget {
  final Map<String, dynamic> provider;

  const ProviderDetailScreen({Key? key, required this.provider}) : super(key: key);

  // Sample fake reviews
  final List<Map<String, dynamic>> fakeReviews = const [
    {
      "userName": "Alice Johnson",
      "userPic": "https://via.placeholder.com/50",
      "rating": 5.0,
      "message": "Excellent service! Highly recommended."
    },
    {
      "userName": "Michael Smith",
      "userPic": "https://via.placeholder.com/50",
      "rating": 4.5,
      "message": "Very professional and punctual."
    },
    {
      "userName": "Sarah Lee",
      "userPic": "https://via.placeholder.com/50",
      "rating": 4.0,
      "message": "Good experience overall, would hire again."
    },
  ];

  @override
  Widget build(BuildContext context) {
    final List<String> images = List<String>.from(provider['images'] ?? [provider['image']]);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: colorWhite),
        title: Text(provider['name'], style: TextStyle(color: Colors.white)),
        backgroundColor: mainColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image gallery
                  SizedBox(
                    height: 250,
                    child: PageView.builder(
                      itemCount: images.length,
                      itemBuilder: (context, index) {
                        return Image.network(
                          images[index],
                          fit: BoxFit.cover,
                          width: double.infinity,
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 12),
                  // Name & Rating
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          provider['name'],
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.orange),
                            SizedBox(width: 4),
                            Text(provider['rating'].toString()),
                            SizedBox(width: 4),
                            Text("(${provider['reviews'] ?? 0} reviews)",
                                style: TextStyle(color: Colors.grey[600])),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12),
                  // About
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "About",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                    child: Text(
                      provider['about'] ??
                          "This provider is experienced and professional. They provide excellent services for all clients with quality and reliability. Highly recommended for anyone looking for top-notch service.",
                      style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Reviews Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "Reviews",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: fakeReviews.length,
                    itemBuilder: (context, index) {
                      final review = fakeReviews[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6),
                        child: ExpansionTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(review['userPic']),
                          ),
                          title: Row(
                            children: [
                              Text(
                                review['userName'],
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 8),
                              Icon(Icons.star, color: Colors.orange, size: 16),
                              SizedBox(width: 4),
                              Text(review['rating'].toString()),
                            ],
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                              child: Text(review['message']),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 100), // Extra space for buttons
                ],
              ),
            ),
          ),
          // Buttons at bottom
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      print("Chat with ${provider['name']}");
                    },
                    icon: Icon(Icons.chat, color: colorWhite),
                    label: Text("Chat",style: TextStyle(color: colorWhite),),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mainColor,
                      foregroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (builder) => BookingPage()));
                    },
                    child: Text("Book Now",style: TextStyle(color: colorWhite),),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mainColor,
                      padding: EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 50,)
        ],
      ),
    );
  }
}
