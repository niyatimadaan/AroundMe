import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final String title;
  final String location;
  final String imageUrl;
  final String distance;
  final String price;

  CardWidget(
      {required this.title,
      required this.location,
      required this.imageUrl,
      required this.distance,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.asset(imageUrl, fit: BoxFit.cover, width: double.infinity),
              // const Positioned(
              //   right: 10,
              //   top: 10,
              //   child: Icon(Icons.favorite_border),
              // ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                        Text(
                          location,
                          style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              fontWeight: FontWeight.w400),
                        ),
                      ]),
                  const Spacer(),
                  Text(
                    '~ $distance Km',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                ]),
                //make a line
                const Padding(padding: EdgeInsets.only(top: 10)),
                const Divider(
                  color: Color.fromARGB(255, 191, 191, 191),
                  height: 1,
                  thickness: 1,
                  indent: 0,
                  endIndent: 0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '₹${price} / session',
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Book Slot'),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.purple,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
