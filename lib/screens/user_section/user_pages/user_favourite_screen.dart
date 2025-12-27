import 'package:eetinal_visit/utils/colors.dart';
import 'package:flutter/material.dart';

class UserFavouriteScreen extends StatefulWidget {
  const UserFavouriteScreen({super.key});

  @override
  State<UserFavouriteScreen> createState() => _UserFavouriteScreenState();
}

class _UserFavouriteScreenState extends State<UserFavouriteScreen> {
 // Dummy favorite providers
  List<Map<String, dynamic>> favorites = [
    {
      "name": "John Electrician",
      "image": "https://i.pravatar.cc/300?img=1",
      "isFavorite": true,
    },
    {
      "name": "Ali Plumber",
      "image": "https://i.pravatar.cc/300?img=2",
      "isFavorite": true,
    },
    {
      "name": "Sara Cleaner",
      "image": "https://i.pravatar.cc/300?img=3",
      "isFavorite": true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: mainColor,
        title: const Text("Favorite Providers",style: TextStyle(color: Colors.white),),
      ),
      body: favorites.isEmpty
          ? const Center(child: Text("No favorites added"))
          : GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.75,
              ),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final provider = favorites[index];

                return Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(16),
                              ),
                              child: Image.network(
                                provider["image"],
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              provider["name"],
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Heart Icon
                    Positioned(
                      top: 8,
                      right: 8,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            favorites.removeAt(index);
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }
}