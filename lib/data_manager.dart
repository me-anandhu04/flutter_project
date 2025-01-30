class DataManager {
  static final DataManager _instance = DataManager._internal();

  factory DataManager() {
    return _instance;
  }

  DataManager._internal();

  // Stores all transactions table-wise
  final Map<String, List<List<Map<String, String>>>> tableTransactions = {};

  void addTransaction(String tableName, List<Map<String, String>> transaction) {
    if (!tableTransactions.containsKey(tableName)) {
      tableTransactions[tableName] = [];
    }
    tableTransactions[tableName]!.add(transaction);
  }

  List<List<Map<String, String>>> getTransactions(String tableName) {
    return tableTransactions[tableName] ?? [];
  }

  Map<String, List<List<Map<String, String>>>> getAllTransactions() {
    return tableTransactions;
  }
}