import 'package:flutter/material.dart';
import 'data_storage_page.dart';
import 'table_data.dart';

class TableListPage extends StatelessWidget {
  final List<TableData> tableList;

  TableListPage({required this.tableList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select Table')),
      body: ListView.builder(
        itemCount: tableList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(tableList[index].tableName),
            onTap: () {
              // Navigate to data storage page when a table is clicked
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DataStoragePage(tableData: tableList[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
