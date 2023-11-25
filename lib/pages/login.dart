import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email:',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: passwController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password:',
              ),
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              child: const Text("Log in"),
              onPressed: () {
                // Get user input
                String email = emailController.text;
                String password = passwController.text;

                // Check if both email and password are filled
                if (email.isNotEmpty && password.isNotEmpty) {
                  // Authentication successful, navigate to home page
                  Navigator.pushNamed(context, '/home');
                } else {
                  // Show an error message or handle authentication failure
                  // For simplicity, let's just print an error message
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
