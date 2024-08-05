import 'package:around_me/bottom_nav_bar.dart';
import 'package:around_me/card_widget.dart';
import 'package:flutter/material.dart';

// import 'package:cloud_firestore/cloud_firestore.dart';
var documents = [
  {
    'name': 'Fitness Centre 1',
    'location': 'Location 1',
    'price': 45,
    'image': 'images/img.png',
  },
  {
    'name': 'Fitness Centre 2',
    'location': 'Location 2',
    'price': 45,
    'image': 'images/img_1.png',
  },
  {
    'name': 'Fitness Centre 3',
    'location': 'Location 3',
    'price': 300,
    'image': 'images/img_2.png',
  },
  {
    'name': 'Fitness Centre 4',
    'location': 'Location 4',
    'price': 400,
    'image': 'images/img_3.png',
  },
  {
    'name': 'Fitness Centre 5',
    'location': 'Location 5',
    'price': 500,
    'image': 'images/img_1.png',
  },
];

class ListScreen extends StatelessWidget {
  final String street;
  final String locality;
  final List<String> _categories = ['Gym', 'Swimming', 'Cricket', 'Yoga', 'Zumba'];

  ListScreen({required this.street, required this.locality});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(locality,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
              Text(street, style: const TextStyle(fontSize: 13)),
              // .overflow!(TextOverflow.ellipsis),
            ],
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ), 
        body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 16),
            child: Row(
              children: List.generate(_categories.length, (index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ChoiceChip(
                    label: Text(_categories[index]),
                    selected: 0 == index,
                    onSelected: (bool selected) {},
                    selectedColor: Colors.purple,
                    backgroundColor: Colors.white,
                    labelStyle: TextStyle(
                      color: 0 == index ? Colors.white : Colors.black,
                    ),
                    showCheckmark: false,
                  ),
                );
              }),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) {
                var data = documents[index];
                return CardWidget(title: data['name'].toString(), location: data['location'].toString(), imageUrl: data['image'].toString(), distance: "3.4", price: data['price'].toString());
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
