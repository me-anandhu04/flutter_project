import 'package:flutter/material.dart';
import 'package:flutter_application_2/all_transactions_page.dart';
import 'package:flutter_application_2/data_manager.dart';

class HistoryPage extends StatelessWidget {
  final DataManager dataManager = DataManager();

  HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final allTransactions = dataManager.getAllTransactions();

    return Scaffold(
      appBar: AppBar(
        title: const Text('History', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        actions: [
          TextButton(
            onPressed: () {
              _showAllTransactions(context);
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.blue, backgroundColor: Colors.white,
            ),
            child: const Text(
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
              title: Text(tableName, style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 18)),
              children: transactions.asMap().entries.map((entry) {
                final index = entry.key;
                final transaction = entry.value;
                final totalAmount = _calculateTotal(transaction);

                return Dismissible(
                  key: UniqueKey(),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  confirmDismiss: (direction) async {
                    return await _confirmDelete(context);
                  },
                  onDismissed: (direction) {
                    _deleteTransaction(context, tableName, index);
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.red, width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Transaction ${index + 1}',
                            style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                          ),
                          const Divider(color: Colors.black),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Expanded(child: Text('Item', style: TextStyle(fontWeight: FontWeight.bold))),
                              SizedBox(width: 40, child: Center(child: Text('Qty', style: TextStyle(fontWeight: FontWeight.bold)))),
                              Expanded(child: Align(alignment: Alignment.centerRight, child: Text('Price', style: TextStyle(fontWeight: FontWeight.bold)))),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: transaction
                                .map((item) => Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(child: Text(item['item'] ?? '')),
                                        SizedBox(width: 40, child: Center(child: Text(item['quantity'] ?? ''))),
                                        Expanded(child: Align(alignment: Alignment.centerRight, child: Text('₹${item['price']}'))),
                                      ],
                                    ))
                                .toList(),
                          ),
                          const Divider(color: Colors.black),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'Total: ₹$totalAmount',
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                        ],
                      ),
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

  Future<bool?> _confirmDelete(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Transaction'),
          content: const Text('Are you sure you want to delete this transaction?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void _deleteTransaction(BuildContext context, String tableName, int transactionIndex) {
    dataManager.tableTransactions[tableName]!.removeAt(transactionIndex);
    if (dataManager.tableTransactions[tableName]!.isEmpty) {
      dataManager.tableTransactions.remove(tableName);
    }
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Transaction deleted')));
  }
}
