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
        title: Text('Table List'),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HistoryPage()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: tableCount,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(8.0),
            color: Colors.blue,
            child: ListTile(
              title: Text(
                'Table ${index + 1}',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
    );
  }
}