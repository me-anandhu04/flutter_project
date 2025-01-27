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
  final TextEditingController _priceController = TextEditingController();

  // Function to add an item to the table's history
  void _addItem() {
    if (_foodController.text.isNotEmpty &&
        _quantityController.text.isNotEmpty &&
        _priceController.text.isNotEmpty) {
      setState(() {
        // Add transaction to table's history
        widget.tableData.foodOrders.add({
          'food': _foodController.text,
          'quantity': _quantityController.text,
          'price': _priceController.text,
        });
      });

      // Clear input fields
      _foodController.clear();
      _quantityController.clear();
      _priceController.clear();

      // Show confirmation message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Item added to ${widget.tableData.tableName}!'),
        ),
      );
    } else {
      // Show error if any field is empty
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all fields before adding.'),
        ),
      );
    }
  }

  // Function to save the table's history
  void _saveItem() {
    if (widget.tableData.foodOrders.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${widget.tableData.tableName} history saved!'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('No items to save in ${widget.tableData.tableName}!'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.tableData.tableName}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Input for Food Name
            TextField(
              controller: _foodController,
              decoration: InputDecoration(labelText: 'Food Name'),
            ),
            SizedBox(height: 10),

            // Input for Quantity
            TextField(
              controller: _quantityController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Quantity'),
            ),
            SizedBox(height: 10),

            // Input for Price
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Price'),
            ),
            SizedBox(height: 20),

            // Buttons for "Add Item" and "Save Item"
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: _addItem,
                  child: Text('Add Item'),
                ),
                ElevatedButton(
                  onPressed: _saveItem,
                  child: Text('Save Items'),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Display Saved Transactions
            Expanded(
              child: ListView.builder(
                itemCount: widget.tableData.foodOrders.length,
                itemBuilder: (context, index) {
                  var foodOrder = widget.tableData.foodOrders[index];
                  return ListTile(
                    title: Text('Food: ${foodOrder['food']}'),
                    subtitle: Text(
                        'Quantity: ${foodOrder['quantity']}, Price: \$${foodOrder['price']}'),
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
