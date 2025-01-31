import 'package:flutter/material.dart';
import 'package:flutter_application_2/all_transactions_page.dart';
import 'package:flutter_application_2/data_manager.dart';

class HistoryPage extends StatelessWidget {
  final DataManager dataManager = DataManager();

  @override
  Widget build(BuildContext context) {
    final allTransactions = dataManager.getAllTransactions();

    return Scaffold(
      appBar: AppBar(
        title: Text('History', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        actions: [
          TextButton(
            onPressed: () {
              _showAllTransactions(context);
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.blue, backgroundColor: Colors.white,
            ),
            child: Text(
              'All Transactions',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
      body: Container(
        color: Colors.orange,
        child: ListView(
          children: allTransactions.keys.map((tableName) {
            final transactions = allTransactions[tableName]!;
            return ExpansionTile(
              title: Text(tableName, style: TextStyle(color: Colors.blue)),
              children: transactions.asMap().entries.map((entry) {
                final index = entry.key;
                final transaction = entry.value;
                final totalAmount = _calculateTotal(transaction);

                return Card(
                  margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.red, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    title: Text(
                      'Transaction ${index + 1}',
                      style: TextStyle(color: Colors.blue),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: transaction
                          .map((item) => Text(
                                '${item['item']} - ${item['quantity']} x ${item['price']}',
                                style: TextStyle(color: Colors.blue),
                              ))
                          .toList(),
                    ),
                    trailing: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Total: ₹$totalAmount',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            _showDeleteConfirmationDialog(context, tableName, index);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          }).toList(),
        ),
      ),
    );
  }

  // Function to calculate total amount of a transaction
  double _calculateTotal(List<Map<String, String>> transaction) {
    return transaction.fold(0.0, (sum, item) {
      double price = double.tryParse(item['price'] ?? '0') ?? 0;
      int quantity = int.tryParse(item['quantity'] ?? '0') ?? 0;
      return sum + (price * quantity);
    });
  }

  void _showAllTransactions(BuildContext context) {
    final allTransactions = <Map<String, String>>[];
    final tableData = dataManager.getAllTransactions();

    for (var table in tableData.keys) {
      for (var transaction in tableData[table]!) {
        allTransactions.add({'table': table, 'transaction': transaction.toString()});
      }
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AllTransactionsPage(allTransactions: allTransactions),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, String tableName, int transactionIndex) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Transaction'),
          content: Text('Are you sure you want to delete this transaction?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                dataManager.tableTransactions[tableName]!.removeAt(transactionIndex);
                if (dataManager.tableTransactions[tableName]!.isEmpty) {
                  dataManager.tableTransactions.remove(tableName);
                }
                Navigator.of(context).pop();
                // ignore: invalid_use_of_protected_member
                (context as Element).reassemble();
              },
              child: Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
