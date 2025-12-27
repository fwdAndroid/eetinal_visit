import 'dart:ffi';

import 'package:eetinal_visit/screens/user_section/care_request/add_care_request_service.dart';
import 'package:eetinal_visit/utils/colors.dart';
import 'package:eetinal_visit/widgets/need_care_page_card_widget.dart';
import 'package:flutter/material.dart';

class CarePage extends StatefulWidget {
  const CarePage({super.key});

  @override
  State<CarePage> createState() => _CarePageState();
}

class _CarePageState extends State<CarePage> {
  final List<Map<String, String>> services = [
    {
      "image": "https://picsum.photos/200",
      "title": "Cleaning",
      "price": "\$90",
      "description": "Clean the grave and put flowers on it",
    },
    {
      "image": "https://picsum.photos/201",
      "title": "Maintenance",
      "price": "\$120",
      "description": "Grave maintenance and repair service",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: mainColor,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (builder) => AddCareRequestService() ));
        },child: Icon(Icons.add,color: colorWhite,),) ,
      body: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: services.length,
          itemBuilder: (context, index) {
            final item = services[index];
            return NeedCarePageCardWidget(
              imageUrl: item["image"]!,
              title: item["title"]!,
              price: item["price"]!,
              description: item["description"]!,
              onTap: () {
                // handle card tap
              },
            );
          },
        ),
    );;
  }
}