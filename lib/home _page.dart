import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/signin_page.dart';
import 'package:flutter_application_2/signup_page.dart';

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

  void _signOut() async {
    await _auth.signOut();
    setState(() {
      _user = null;
    });
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
                image: AssetImage('assets/waiter.jpeg'),  // Ensure the correct path here
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content on top of the background
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'WTM', 
                  style: TextStyle(
                    fontSize: 80, 
                    fontWeight: FontWeight.bold, 
                    color: Colors.black
                  )
                ),
                SizedBox(height: 100),
                _user != null
                    ? Column(
                        children: [
                          Text(
                            'Welcome, ${_user?.displayName ?? 'User'}', 
                            style: TextStyle(
                              fontSize: 20, 
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Email: ${_user?.email}', 
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 30),
                          ElevatedButton(
                            onPressed: _signOut,
                            child: Text('Sign Out'),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context, 
                                MaterialPageRoute(builder: (context) => SignInPage())
                              );
                            },
                            child: Text('Sign In'),
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context, 
                                MaterialPageRoute(builder: (context) => SignUpPage())
                              );
                            },
                            child: Text('Sign Up'),
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
