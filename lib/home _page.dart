import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/table_input_page.dart'; // Import TableInputPage
import 'package:flutter_application_2/signin_page.dart'; // Import SignInPage
import 'package:flutter_application_2/signup_page.dart'; // Import SignUpPage

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
    _auth.authStateChanges().listen((User? user) {
      setState(() {
        _user = user;
      });
    });
  }

  // Function to sign out
  void _signOut() async {
    await _auth.signOut();
    setState(() {
      _user = null;  // Clear the user state
    });
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignInPage()), // Redirect to Sign In after sign out
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Waiter Table Management'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/waiter.jpeg'), // Ensure the correct path
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content on top of the background
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start, // Align content to the top
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10), // Small margin to move WTM near the top
                Text(
                  'WTM',
                  style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 244, 19, 19)),
                ),
                SizedBox(height: 50), // Adjust space after WTM

                // If the user is logged in, show welcome message and Start button
                _user != null
                    ? Column(
                        children: [
                          Text(
                            'Welcome, ${_user?.displayName ?? 'User'}',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => TableInputPage()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              side: BorderSide(color: Colors.red),
                              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                            ),
                            child: Text(
                              'Start',
                              style: TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                          SizedBox(height: 20),
                          GestureDetector(
                            onTap: _signOut,
                            child: Text(
                              'Sign Out',
                              style: TextStyle(color: Colors.blue, fontSize: 16),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          // If the user is not logged in, show Sign In and Sign Up buttons
                          SizedBox(height: 100), // Adjust space from the top
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignInPage()));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue, // Blue background
                              side: BorderSide(color: Colors.red), // Red border
                              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50), // Increase button size
                            ),
                            child: Text(
                              'Sign In',
                              style: TextStyle(
                                color: Colors.white, // White text
                                fontSize: 18, // Increase font size
                              ),
                            ),
                          ),
                          SizedBox(height: 20), // Add space between buttons
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUpPage()));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue, // Blue background
                              side: BorderSide(color: Colors.red), // Red border
                              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50), // Increase button size
                            ),
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                color: Colors.white, // White text
                                fontSize: 18, // Increase font size
                              ),
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
