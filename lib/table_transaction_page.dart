import 'package:flutter/material.dart';
import 'table_data.dart';

class TableTransactionPage extends StatelessWidget {
  final TableData tableData;

  TableTransactionPage({required this.tableData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${tableData.tableName} Transactions')),
      body: ListView.builder(
        itemCount: tableData.foodOrders.length,
        itemBuilder: (context, index) {
          var foodOrder = tableData.foodOrders[index];
          return ListTile(
            title: Text('Food: ${foodOrder['food']}'),
            subtitle: Text('Quantity: ${foodOrder['quantity']}'),
          );
        },
      ),
    );
  }
}
