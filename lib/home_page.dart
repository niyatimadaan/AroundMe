import 'package:around_me/bottom_nav_bar.dart';
import 'package:around_me/card_widget.dart';
import 'package:around_me/list_screen.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as geo;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

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
];

class _HomePageState extends State<HomePage> {
  String _location = 'Loading...';
  String street = "";
  String locality = "";

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    Location location = new Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();

    if (_locationData.latitude != null && _locationData.longitude != null) {
      List<geo.Placemark> placemarks = await geo.placemarkFromCoordinates(
          _locationData.latitude!, _locationData.longitude!);
      print(placemarks[0].street);
      setState(() {
        street = placemarks[0].street != null ? placemarks[0].street! : "";
        locality =
            placemarks[0].locality != null ? placemarks[0].locality! : "";
      });
      print(placemarks[0].locality);
    }

    setState(() {
      _location = '${_locationData.latitude}, ${_locationData.longitude}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 224, 188, 230),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  const Padding(padding: EdgeInsets.only(top: 20)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(locality,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              const Icon(Icons.arrow_drop_down),
                            ],
                          ),
                          Text(street, style: const TextStyle(fontSize: 13)),
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              // Icon(Icons.star_border_rounded,
                              //     color: Colors.yellow),
                              SizedBox(
                                height: 20,
                                width: 20,
                                child: Image.asset('images/img_4.png'),
                              ),
                              const Text("Points",
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Text("3752", style: TextStyle(fontSize: 18))
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Hello, Niyati!',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Poppins'),
                      ),
                    ],
                  ),
                  const Text(
                    'What would you like to do today?',
                    style: TextStyle(
                        fontSize: 28,
                        color: Colors.purple,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: 'Find a nearby activity',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: const Icon(Icons.settings),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ListScreen(
                                street: street,
                                locality: locality,
                              )),
                    );
                  },
                  child: const Column(
                    children: [
                      Icon(Icons.fitness_center, size: 40),
                      Text('Gym'),
                    ],
                  ),
                ),
                const Column(
                  children: [
                    Icon(Icons.pool, size: 40),
                    Text('Swimming'),
                  ],
                ),
                const Column(
                  children: [
                    Icon(Icons.sports_handball, size: 40),
                    Text('Badminton'),
                  ],
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Icon(Icons.self_improvement, size: 40),
                    Text('Yoga'),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.accessibility_new_outlined, size: 40),
                    Text('Zumba'),
                  ],
                ),
                Text('View all',
                    style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.blue)),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            Column(
              children: documents.map((data) {
                return CardWidget(
                  title: data['name'].toString(),
                  location: data['location'].toString(),
                  imageUrl: data['image'].toString(),
                  distance: "3.4",
                  price: data['price'].toString(),
                );
              }).toList(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
