import 'package:flutter/material.dart';
import 'data_manager.dart';

class TableDetailsPage extends StatefulWidget {
  final String tableName;

  TableDetailsPage({required this.tableName});

  @override
  _TableDetailsPageState createState() => _TableDetailsPageState();
}

class _TableDetailsPageState extends State<TableDetailsPage> {
  final TextEditingController _itemController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  List<Map<String, String>> currentTransaction = [];
  final DataManager dataManager = DataManager();

  void _addItem() {
    setState(() {
      currentTransaction.add({
        'item': _itemController.text,
        'quantity': _quantityController.text,
        'price': _priceController.text,
      });
      _itemController.clear();
      _quantityController.clear();
      _priceController.clear();
    });
  }

  void _saveTransaction() {
    if (currentTransaction.isNotEmpty) {
      dataManager.addTransaction(widget.tableName, List.from(currentTransaction));
      setState(() {
        currentTransaction.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final tableHistory = dataManager.getTransactions(widget.tableName);

    return Scaffold(
      appBar: AppBar(title: Text(widget.tableName)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _itemController,
              decoration: InputDecoration(labelText: 'Item'),
            ),
            TextField(
              controller: _quantityController,
              decoration: InputDecoration(labelText: 'Quantity'),
            ),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Price'),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                ElevatedButton(onPressed: _addItem, child: Text('Add Item')),
                SizedBox(width: 10),
                ElevatedButton(onPressed: _saveTransaction, child: Text('Save Transaction')),
              ],
            ),
            SizedBox(height: 20),
            Text('Current Products:', style: TextStyle(fontWeight: FontWeight.bold)),
            ...currentTransaction.map((item) => ListTile(
                  title: Text(item['item'] ?? ''),
                  subtitle: Text('Quantity: ${item['quantity']}, Price: ${item['price']}'),
                )),
            SizedBox(height: 20),
            Text('Product History:', style: TextStyle(fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: tableHistory.length,
                itemBuilder: (context, index) {
                  final transaction = tableHistory[index];
                  return Card(
                    child: ListTile(
                      title: Text('Transaction ${index + 1}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: transaction
                            .map((item) =>
                                Text('${item['item']} - ${item['quantity']} x ${item['price']}'))
                            .toList(),
                      ),
                    ),
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
