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
