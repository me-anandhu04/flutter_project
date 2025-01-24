import 'package:flutter/material.dart';
import 'table_data.dart';

class DataStoragePage extends StatefulWidget {
  final TableData tableData;

  DataStoragePage({required this.tableData});

  @override
  _DataStoragePageState createState() => _DataStoragePageState();
}

class _DataStoragePageState extends State<DataStoragePage> {
  final TextEditingController _foodController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Data Storage for ${widget.tableData.tableName}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _foodController,
              decoration: InputDecoration(labelText: 'Food Name'),
            ),
            TextField(
              controller: _quantityController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Quantity'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  // Save the food item and quantity for the selected table
                  widget.tableData.foodOrders.add({
                    'food': _foodController.text,
                    'quantity': _quantityController.text,
                  });
                });

                // Clear the text fields
                _foodController.clear();
                _quantityController.clear();
              },
              child: Text('Add Food'),
            ),
            SizedBox(height: 20),
            // Display history of foods added to the selected table
            Expanded(
              child: ListView.builder(
                itemCount: widget.tableData.foodOrders.length,
                itemBuilder: (context, index) {
                  var foodItem = widget.tableData.foodOrders[index];
                  return ListTile(
                    title: Text('${foodItem['food']} - Quantity: ${foodItem['quantity']}'),
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
