import 'package:flutter/material.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("CARent")),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'W E L C O M E   \nTO    \nCARent',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 1.0),
            Image.asset(
              'assets/login.jpg',
              width: 410.0, // Adjust the width as needed
              height: 410.0, // Adjust the height as needed
              fit: BoxFit.contain, // Adjust the BoxFit property as needed
            ),
            const SizedBox(height: 0.5),
            ElevatedButton(
              child: const Text("Start"),
              onPressed: () {
                //masuk ke home
                Navigator.pushNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
    );
  }
}
