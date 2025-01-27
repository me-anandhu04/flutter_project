import 'package:flutter/material.dart';
import 'package:flutter_application_2/all_transactions_page.dart';
import 'data_manager.dart';

class HistoryPage extends StatelessWidget {
  final DataManager dataManager = DataManager();

  @override
  Widget build(BuildContext context) {
    final allTransactions = dataManager.getAllTransactions();

    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
        actions: [
          TextButton(
            onPressed: () {
              _showAllTransactions(context);
            },
            child: Text(
              'All Transactions',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: ListView(
        children: allTransactions.keys.map((tableName) {
          final transactions = allTransactions[tableName]!;
          return ExpansionTile(
            title: Text(tableName),
            children: transactions.asMap().entries.map((entry) {
              final index = entry.key;
              final transaction = entry.value;
              return Card(
                margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                child: ListTile(
                  title: Text('Transaction ${index + 1}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: transaction
                        .map((item) => Text(
                            '${item['item']} - ${item['quantity']} x ${item['price']}'))
                        .toList(),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      _showDeleteConfirmationDialog(
                          context, tableName, index);
                    },
                  ),
                ),
              );
            }).toList(),
          );
        }).toList(),
      ),
    );
  }

  void _showAllTransactions(BuildContext context) {
    final allTransactions = <Map<String, String>>[];
    final tableData = dataManager.getAllTransactions();

    // Combine all transactions from all tables
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

  void _showDeleteConfirmationDialog(
      BuildContext context, String tableName, int transactionIndex) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Transaction'),
          content: Text('Are you sure you want to delete this transaction?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Delete the transaction
                dataManager.tableTransactions[tableName]!.removeAt(transactionIndex);
                if (dataManager.tableTransactions[tableName]!.isEmpty) {
                  dataManager.tableTransactions.remove(tableName);
                }
                Navigator.of(context).pop(); // Close the dialog
                (context as Element).reassemble(); // Refresh the UI
              },
              child: Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
