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
    final item = _itemController.text;
    final quantity = _quantityController.text;
    final price = _priceController.text;

    if (item.isEmpty || quantity.isEmpty || price.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields (Item, Quantity, Price)')),
      );
      return;
    }

    if (!_isNumber(quantity) || !_isNumber(price)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Quantity and Price must be valid numbers')),
      );
      return;
    }

    setState(() {
      currentTransaction.add({
        'item': item,
        'quantity': quantity,
        'price': price,
      });
      _itemController.clear();
      _quantityController.clear();
      _priceController.clear();
    });
  }

  bool _isNumber(String value) {
    return double.tryParse(value) != null;
  }

  void _saveTransaction() {
    if (currentTransaction.isNotEmpty) {
      dataManager.addTransaction(widget.tableName, List.from(currentTransaction));
      setState(() {
        currentTransaction.clear();
      });
    }
  }

  double _calculateTotal(List<Map<String, String>> transaction) {
    return transaction.fold(0.0, (sum, item) {
      double price = double.tryParse(item['price'] ?? '0') ?? 0;
      int quantity = int.tryParse(item['quantity'] ?? '0') ?? 0;
      return sum + (price * quantity);
    });
  }

  @override
  Widget build(BuildContext context) {
    final tableHistory = dataManager.getTransactions(widget.tableName);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.tableName, style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        color: Colors.orange,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Item Input Field
            TextField(
              controller: _itemController,
              decoration: InputDecoration(
                labelText: 'Item',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            // Quantity Input Field
            TextField(
              controller: _quantityController,
              decoration: InputDecoration(
                labelText: 'Quantity',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            // Price Input Field
            TextField(
              controller: _priceController,
              decoration: InputDecoration(
                labelText: 'Price',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            Row(
              children: [
                ElevatedButton(
                  onPressed: _addItem,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: Text('Add Item'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _saveTransaction,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: Text('Save Transaction'),
                ),
              ],
            ),
            SizedBox(height: 20),
            
            // Current Products Section
            Text(
              'Current Products:',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            Container(
              color: Colors.green,
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: currentTransaction.map((item) => Container(
                      padding: EdgeInsets.all(8.0),
                      margin: EdgeInsets.symmetric(vertical: 4.0),
                      decoration: BoxDecoration(
                        color: Colors.green[200],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text('${item['item']}', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                              SizedBox(width: 20),
                              Expanded(child: Text('₹${item['price'] ?? ''}', style: TextStyle(color: Colors.white))),
                            ],
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text('Qty: ${item['quantity']}', style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                    )).toList(),
              ),
            ),
            
            SizedBox(height: 20),

            // Product History Section
            Text(
              'Product History:',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            Expanded(
              child: Container(
                color: Colors.green,
                child: ListView.builder(
                  itemCount: tableHistory.length,
                  itemBuilder: (context, index) {
                    final transaction = tableHistory[index];
                    final totalAmount = _calculateTotal(transaction); // Calculate total

                    return Card(
                      color: Colors.green[200],
                      margin: EdgeInsets.all(8.0),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Transaction ${index + 1}', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                            SizedBox(height: 5),
                            ...transaction.map((item) => Row(
                                  children: [
                                    Text('${item['item']}', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                                    SizedBox(width: 20),
                                    Expanded(child: Text('₹${item['price'] ?? ''}', style: TextStyle(color: Colors.white))),
                                    Text('Qty: ${item['quantity']}', style: TextStyle(color: Colors.white)),
                                  ],
                                )),
                            SizedBox(height: 5),
                            Divider(color: Colors.white), // Separator
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'Total: ₹$totalAmount',
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
