import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'history_page.dart';
import 'table_list_page.dart';

class TableInputPage extends StatefulWidget {
  @override
  _TableInputPageState createState() => _TableInputPageState();
}

class _TableInputPageState extends State<TableInputPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _tableController = TextEditingController();

  // Controllers to edit the user information
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _userEmailController = TextEditingController();
  TextEditingController _userPasswordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  // Current user details
  String userName = '';
  String userEmail = '';

  @override
  void initState() {
    super.initState();
    _fetchUserInfo();
  }

  // Fetch current user information from Firebase
  void _fetchUserInfo() {
    User? user = _auth.currentUser;
    if (user != null) {
      setState(() {
        userName = user.displayName ?? 'No Name';
        userEmail = user.email ?? 'No Email';
      });
      _userNameController.text = userName;
      _userEmailController.text = userEmail;
    }
  }

  // Show dialog to edit user information
  void _editUserInfo() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit User Information'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _userNameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _userEmailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _userPasswordController,
                obscureText: true, // Hide the password text
                decoration: InputDecoration(
                  labelText: 'New Password',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _confirmPasswordController,
                obscureText: true, // Hide the confirm password text
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                // Get current user
                User? user = _auth.currentUser;
                if (user != null) {
                  try {
                    // Validate password and confirm password match
                    if (_userPasswordController.text != _confirmPasswordController.text) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Passwords do not match!')),
                      );
                      return;
                    }

                    // Update the user's display name and email
                    await user.updateDisplayName(_userNameController.text);
                    await user.updateEmail(_userEmailController.text);

                    // If password is not empty, update the password
                    if (_userPasswordController.text.isNotEmpty) {
                      await user.updatePassword(_userPasswordController.text);
                    }

                    // Refresh the user data after update
                    await user.reload();
                    user = _auth.currentUser;

                    // Update the UI with new info
                    setState(() {
                      userName = user?.displayName ?? '';
                      userEmail = user?.email ?? '';
                    });

                    Navigator.pop(context); // Close the dialog after saving
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('User information updated!')),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error updating user info: $e')),
                    );
                  }
                }
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Table Input'),
        backgroundColor: Colors.blue, // Set the AppBar color to blue
        actions: [
          IconButton(
            icon: Icon(Icons.info, color: Colors.white), // White info icon
            onPressed: _editUserInfo, // When clicked, edit user information
          ),
        ],
      ),
      body: Container(
        color: Colors.orange, // Set the background color to orange
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, // Align content to the top
          crossAxisAlignment: CrossAxisAlignment.center, // Center content horizontally
          children: [
            // Displaying the current user info
            Text(
              'Hi : $userName',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20), // Space between user info and input fields

            // Input field for table count
            TextField(
              controller: _tableController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'ENTER THE TABLES YOU NEED',
                filled: true,
                fillColor: Colors.red, // Set background to red
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2), // Set blue border
                ),
              ),
            ),
            SizedBox(height: 20), // Space between input and button

            // Button to create tables
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.blue, // Set the background color to blue
                side: BorderSide(color: Colors.red, width: 2), // Set the text color to white
              ),
              onPressed: () {
                int tableCount = int.tryParse(_tableController.text) ?? 0;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TableListPage(tableCount: tableCount),
                  ),
                );
              },
              child: Text('Create Tables'),
            ),
          ],
        ),
      ),
    );
  }
}
