<<<<<<< HEAD
import 'package:flutter/material.dart';

class AllTransactionsPage extends StatelessWidget {
  final List<Map<String, String>> allTransactions;

  const AllTransactionsPage({super.key, required this.allTransactions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Transactions'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: allTransactions.length,
          itemBuilder: (context, index) {
            final transaction = allTransactions[index];
            final table = transaction['table'] ?? 'Unknown';
            final transactionDetails = transaction['transaction'] ?? 'No details';

            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.blue, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16.0),
                title: Text('T${index + 1} - Table: $table'),
                subtitle: Text(transactionDetails),
                trailing: IconButton(
                  icon: const Icon(Icons.print),
                  onPressed: () {
                    _printTransaction(transactionDetails);
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Function to handle print action
  void _printTransaction(String transactionDetails) {
    // Implement print functionality here (e.g., save to PDF, print to physical printer, etc.)
    print('Printing transaction details: $transactionDetails');
  }
}
=======
import 'package:flutter/material.dart';

class AllTransactionsPage extends StatelessWidget {
  final List<Map<String, String>> allTransactions;

  // ignore: prefer_const_constructors_in_immutables
  AllTransactionsPage({super.key, required this.allTransactions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Transactions'),
      ),
      body: ListView.builder(
        itemCount: allTransactions.length,
        itemBuilder: (context, index) {
          final transaction = allTransactions[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
            child: ListTile(
              title: Text('T${index + 1}'),
              subtitle: Text(
                  'Table: ${transaction['table']}\nTransaction: ${transaction['transaction']}'),
            ),
          );
        },
      ),
    );
  }
}
>>>>>>> 70f31b5c133fc4ae4635c1cd3b2af9952d5576b0
