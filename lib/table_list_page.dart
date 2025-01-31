import 'package:flutter/material.dart';
import 'history_page.dart';
import 'table_details_page.dart';

class TableListPage extends StatelessWidget {
  final int tableCount;

  TableListPage({required this.tableCount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Table List',
          style: TextStyle(color: Colors.white), // Set AppBar title text color to white
        ),
        backgroundColor: Colors.blue, // Set AppBar background color to blue
        actions: [
          IconButton(
            icon: Icon(Icons.history, color: Colors.white), // Set the history icon color to white
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HistoryPage()),
              );
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.orange, // Set the body background color to orange
        child: ListView.builder(
          itemCount: tableCount,
          itemBuilder: (context, index) {
            return Card(
              margin: EdgeInsets.all(8.0),
              color: Colors.blue, // Set card color to blue
              child: ListTile(
                title: Text(
                  'Table ${index + 1}',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold), // Set text color to white
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TableDetailsPage(tableName: 'Table ${index + 1}'),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
