import 'package:flutter/material.dart';

class OrderConfirmationPage extends StatelessWidget {
  final String name;
  final String carType;
  final String date;
  final String time;
  final String location;
  OrderConfirmationPage(
      {required this.name,
      required this.carType,
      required this.date,
      required this.time,
      required this.location});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Handle the back button press here (e.g., navigate to a different page)
        return true; // Return true to allow back navigation
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Order Confirmation'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Thank you for your order!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Name: $name',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  'ID - Car: $carType',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  'Date: $date',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  'Time: $time',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  'Location: $location',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    //masuk ke
                    Navigator.pushNamed(context, '/intropage');
                  },
                  child: Text('Exit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
