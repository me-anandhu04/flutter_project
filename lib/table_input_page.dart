import 'package:flutter/material.dart';
import 'table_list_page.dart';
import 'table_data.dart';

class TableInputPage extends StatefulWidget {
  @override
  _TableInputPageState createState() => _TableInputPageState();
}

class _TableInputPageState extends State<TableInputPage> {
  final TextEditingController _controller = TextEditingController();
  List<TableData> tableList = [];  // List to hold table data

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Enter Number of Tables')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter number of tables',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                int tableCount = int.tryParse(_controller.text) ?? 0;
                if (tableCount > 0) {
                  setState(() {
                    // Create tables with empty history
                    tableList = List.generate(tableCount, (index) => TableData('Table ${index + 1}'));
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TableListPage(tableList: tableList),
                    ),
                  );
                }
              },
              child: Text('Submit'),
            ),
            SizedBox(height: 20),
            // Display the tables' food history
            Expanded(
              child: ListView.builder(
                itemCount: tableList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(tableList[index].tableName),
                    subtitle: Text('Food history: ${tableList[index].foodOrders.length} items'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
