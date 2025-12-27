import 'package:eetinal_visit/widgets/care_provider_widget.dart';
import 'package:flutter/material.dart';

class OfferCarePage extends StatefulWidget {
  const OfferCarePage({super.key});

  @override
  State<OfferCarePage> createState() => _OfferCarePageState();
}

class _OfferCarePageState extends State<OfferCarePage> {
   final List<Map<String, dynamic>> providers = [
    {
      "image": "https://picsum.photos/201",
      "name": "Anderson Smith",
      "location": "New York",
      "rating": 4.5,
    },
    {
      "image": "https://picsum.photos/201",
      "name": "Alice Johnson",
      "location": "Los Angeles",
      "rating": 4.0,
    },
    // Add more providers here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: providers.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (context, index) {
            final provider = providers[index];
            return ProviderCard(
              image: provider['image'],
              name: provider['name'],
              location: provider['location'],
              rating: provider['rating'],
              onTap: () {
                print("Tapped ${provider['name']}");
              },
            );
          },
        ),
      ),
    );
  }
}