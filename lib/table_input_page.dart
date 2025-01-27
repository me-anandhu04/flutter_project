import 'package:flutter/material.dart';
import 'history_page.dart';
import 'table_list_page.dart';

class TableInputPage extends StatefulWidget {
  @override
  _TableInputPageState createState() => _TableInputPageState();
}

class _TableInputPageState extends State<TableInputPage> {
  final TextEditingController _tableController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Table Input'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HistoryPage()),
              );
            },
            child: Text(
              'History',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _tableController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter Number of Tables',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
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
