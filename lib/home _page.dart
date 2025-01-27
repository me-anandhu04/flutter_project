import 'package:flutter/material.dart';
import 'signin_page.dart'; // Import the Sign In page
import 'signup_page.dart'; // Import the Sign Up page

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Waiter Table Management', // App bar title
          style: TextStyle(
            fontSize: 24, // You can change the size as per your preference
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue, // Customize the AppBar color
        centerTitle: true, // Centers the title
      ),
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/waiter.png'), // Background image
                fit: BoxFit.cover, // Makes sure the image covers the entire screen
              ),
            ),
          ),
          
          // Content
          Column(
            mainAxisAlignment: MainAxisAlignment.center, // Centers the content vertically
            children: [
              // "WTM" Text in the center with black color
              Center(
                child: Text(
                  '', // Text to display
                  style: TextStyle(
                    fontSize: 80, // Big font size
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // Black color for the text
                  ),
                ),
              ),
              
              // Spacer for spacing between WTM and buttons
              SizedBox(height: 100),

              // Sign In and Sign Up buttons
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to the Sign In page
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignInPage()),
                      );
                    },
                    child: Text('Sign In'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to the Sign Up page
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpPage()),
                      );
                    },
                    child: Text('Sign Up'),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}