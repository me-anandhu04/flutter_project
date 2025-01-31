import 'package:flutter/material.dart';

class AllTransactionsPage extends StatelessWidget {
  final List<Map<String, String>> allTransactions;

  AllTransactionsPage({required this.allTransactions});

  double _calculateTotal(String transactionStr) {
    RegExp regExp = RegExp(r'price: (\d+\.?\d*).+?quantity: (\d+)');
    var matches = regExp.allMatches(transactionStr);
    
    double total = 0;
    for (var match in matches) {
      double price = double.parse(match.group(1) ?? '0');
      int quantity = int.parse(match.group(2) ?? '0');
      total += price * quantity;
    }
    return total;
  }

  List<Map<String, String>> _parseTransactionItems(String transactionStr) {
    List<Map<String, String>> items = [];
    
    // Extract item details from the transaction string
    RegExp itemRegExp = RegExp(r"item: '([^']+)', quantity: '(\d+)', price: '(\d+\.?\d*)'");
    var matches = itemRegExp.allMatches(transactionStr);
    
    for (var match in matches) {
      items.add({
        'item': match.group(1) ?? '',
        'quantity': match.group(2) ?? '',
        'price': match.group(3) ?? ''
      });
    }
    
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'All Transactions',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        color: Colors.orange,
        child: ListView.builder(
          padding: EdgeInsets.all(8.0),
          itemCount: allTransactions.length,
          itemBuilder: (context, index) {
            final transaction = allTransactions[index];
            final items = _parseTransactionItems(transaction['transaction'] ?? '');
            final total = _calculateTotal(transaction['transaction'] ?? '');
            
            return Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              color: Colors.blue,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header with Table and Transaction number
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${transaction['table']}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'T${index + 1}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    
                    // Column headers
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Item',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Qty',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Price',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                    Divider(color: Colors.white),
                    
                    // Items list
                    ...items.map((item) => Padding(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              item['item'] ?? '',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              item['quantity'] ?? '',
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '₹${item['price']}',
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    )).toList(),
                    
                    Divider(color: Colors.white),
                    // Total amount
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Total: ₹${total.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}