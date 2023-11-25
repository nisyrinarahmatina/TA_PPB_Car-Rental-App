import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ta_ppb/pages/order_confirmation.dart';
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  // Define your screens or pages
  final List<Widget> _pages = [
    const Profile(),
    const CarDataPage(),
    CarSpecsPage(),
    Order(),
    Profil()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber.shade100,
      appBar: AppBar(
        title: const Text("CARrent"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.blueGrey,
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index >= 0 && index < _pages.length) {
            setState(() {
              _currentIndex = index;
            });
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.car_crash_outlined),
            label: 'List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.car_rental_outlined),
            label: 'Details',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'Order',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          )
        ],
      ),
    );
  }
}

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Text(
              'ABOUT US',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 360,
              child: Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 8.0,
                      spreadRadius: 1.0,
                      offset: Offset(0, 1),
                    ),
                  ],
                  color: Colors.blueGrey,
                ),
                child: Text(
                  'Welcome to CARent, your best solution for convenient and reliable car rental services. \nWe are dedicated to providing you with a hassle-free and enjoyable car rental experience.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 20,
                    letterSpacing: 1.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Why Choose Us?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: 360,
              child: Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 8.0,
                      spreadRadius: 1.0,
                      offset: Offset(0, 1),
                    ),
                  ],
                  color: Colors.blueGrey,
                ),
                child: Text(
                  '1. Affordability: \nWe believe in providing high-quality service at competitive prices and flexible rental plans for budget-conscious travelers. \n\n2. Convenience: \nBooking a car with us is easy and convenient. Whether you prefer to reserve online or speak with one of our friendly representatives, we strive to make the process hassle-free. \n\n3. \nCustomer Satisfaction: Your satisfaction is our priority. Our dedicated team is committed to delivering excellent customer service, addressing your queries, and ensuring a smooth rental experience from start to finish.\n\n4. Flexibility: \nWe understand that plans can change. That is why we offer flexible rental options, including daily, weekly, and monthly plans, so you can choose the duration that best fits your needs.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 14,
                    letterSpacing: 1.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () {
                    //masuk ke
                    Navigator.pushNamed(context, '/review');
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.people_alt_outlined,
                        size: 20.0,
                        color: Colors.black,
                      ),
                      SizedBox(height: 1.0),
                      Text(
                        'Reviews',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CarDataPage extends StatelessWidget {
  const CarDataPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber.shade100,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Car List:',
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: fetchData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  List<dynamic> apiData = snapshot.data as List<dynamic>;
                  return ListView.builder(
                    itemCount: apiData.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(apiData[index]['make']),
                        onTap: () {
                          // Navigate to CarDetailsPage with specific car details
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CarDetailsPage(
                                carDetails: CarDetail.fromJson(apiData[index]),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<List<dynamic>> fetchData() async {
    final String apiKey = 'f9748f64d0msh0db9bc2d0d0c998p191da9jsn2473fd06052f';
    final String apiUrl = 'https://car-data.p.rapidapi.com/cars';

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'X-RapidAPI-Key': apiKey,
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print('Failed to load data: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }
}

class CarDetailsPage extends StatelessWidget {
  final CarDetail carDetails;

  const CarDetailsPage({Key? key, required this.carDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Car ID:'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            Text(
              'ID: ${carDetails.id}',
              style: TextStyle(fontSize: 18),
            ),
            // Add more details as needed
          ],
        ),
      ),
    );
  }
}

class CarDetail {
  final String id;

  CarDetail({
    required this.id,
  });

  factory CarDetail.fromJson(Map<String, dynamic> json) {
    return CarDetail(id: json['id'].toString());
  }
}

class CarSpecsPage extends StatelessWidget {
  const CarSpecsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber.shade100,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Car ID:',
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: fetchData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  List<dynamic> apiData = snapshot.data as List<dynamic>;
                  return ListView.builder(
                    itemCount: apiData.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(apiData[index]['id'].toString()),
                        subtitle: Text(apiData[index]['make']),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CarSpecsDetails(
                                carSpecs: CarSpecs.fromJson(apiData[index]),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<List<dynamic>> fetchData() async {
    final String apiKey = 'f9748f64d0msh0db9bc2d0d0c998p191da9jsn2473fd06052f';
    final String apiUrl = 'https://car-data.p.rapidapi.com/cars';

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'X-RapidAPI-Key': apiKey,
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print('Failed to load data: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }
}

class CarSpecsDetails extends StatelessWidget {
  final CarSpecs carSpecs;

  const CarSpecsDetails({Key? key, required this.carSpecs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Car Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            Text(
              'Type: ${carSpecs.type}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Make: ${carSpecs.make}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Model: ${carSpecs.model}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Year: ${carSpecs.year}',
              style: TextStyle(fontSize: 18),
            ),
            // Add more details as needed
          ],
        ),
      ),
    );
  }
}

class CarSpecs {
  final String year;
  final String make;
  final String model;
  final String type;

  CarSpecs({
    required this.year,
    required this.make,
    required this.model,
    required this.type,
  });

  factory CarSpecs.fromJson(Map<String, dynamic> json) {
    return CarSpecs(
      year: json['year'].toString(),
      make: json['make'],
      model: json['model'],
      type: json['type'],
    );
  }
}

class Order extends StatefulWidget {
  const Order({Key? key}) : super(key: key);

  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _Controller = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  List<String> carTypes = [
    '9582 - Buick Enclave',
    '9583 - MINI Convertible',
    '9584 - Volvo XC90',
    '9585 - Ford Taurus',
    '9586 - Volvo XC60',
    '9587 - Hummer H2',
    '9588 - GMC Sierra 1500',
    '9689 - GMC Canyon',
    '9590 - Subaru Outback',
    '9591 - Mitsubishi Outlander'
  ];
  String selectedCarType = '9582 - Buick Enclave';

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Book Now',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Form(
                      child: Column(children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        hintText: 'Enter your name',
                      ),
                    ),
                    SizedBox(height: 20),
                    Text('Car:'),
                    DropdownButton<String>(
                      value: selectedCarType,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedCarType = newValue!;
                        });
                      },
                      items: carTypes
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _dateController,
                      decoration: InputDecoration(
                        labelText: 'Date',
                        hintText: 'YYYY-MM-DD',
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _timeController,
                      decoration: InputDecoration(
                        labelText: 'Time',
                        hintText: 'XX.XX 24 hour format',
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _locationController,
                      decoration: InputDecoration(
                        labelText: 'Location',
                        hintText: 'Please put the detail',
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        String name = _nameController.text;
                        String carType = selectedCarType;
                        String date = _dateController.text;
                        String time = _timeController.text;
                        String location = _locationController.text;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrderConfirmationPage(
                                name: name,
                                carType: carType,
                                date: date,
                                time: time,
                                location: location),
                          ),
                        );
                      },
                      child: Text('Place Order'),
                    )
                  ]))
                ])));
  }
}

class Profil extends StatelessWidget {
  const Profil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.amber.shade100,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Nisyrina Rahmatina',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '21120121140108',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Teknik Komputer 2021',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Add more content if needed
              ],
            ),
          ),
        ),
      ),
    );
  }
}
