import 'package:flutter/material.dart';
import 'table_input_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignInPage(),
    );
  }
}

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign In')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to table input page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TableInputPage()),
            );
          },
          child: Text('Sign In'),
        ),
      ),
    );
  }
}
