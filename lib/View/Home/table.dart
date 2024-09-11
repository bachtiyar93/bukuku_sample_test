import 'package:bukuku_sample_test/Model/table.dart';
import 'package:bukuku_sample_test/core/AppHelpers.dart';
import 'package:bukuku_sample_test/global_state.dart';
import'package:flutter/material.dart';

class TableManagement extends StatefulWidget {
  const TableManagement({super.key});


  @override
  State<TableManagement> createState() => _TableManagementState();
}

class _TableManagementState extends State<TableManagement> {
  List<TableData> tables = [
    TableData(number: 1, status: TableStatus.available),
    TableData(number: 2, status: TableStatus.occupied),
    TableData(number: 3, status: TableStatus.available),
    // Tambahkan data meja lainnya di sini
  ];

  void _addTable() {
    setState(() {
      int newTableNumber = tables.length + 1;
      tables.add(TableData(number: newTableNumber, status: TableStatus.available));
    });
  }void _deleteTable(int tableNumber) {
    setState(() {
      tables.removeWhere((table) => table.number == tableNumber);
      // Perbarui nomor meja setelah penghapusan
      for (int i = 0; i < tables.length; i++) {
        tables[i].number = i + 1;
      }
    });
  }
  late final GlobalState global;
  @override
  void initState() {
    global = AppHelpers.getState<GlobalState>(listen: false);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Table Management'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1.0,
        ),
        itemCount: tables.length,
        itemBuilder: (context, index) {
          final table = tables[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                if (table.status == TableStatus.available) {
                  table.status = TableStatus.occupied;
                } else {
                  table.status = TableStatus.available;
                }});
            },
            child: Card(
              color: table.status == TableStatus.available
                  ? Colors.grey
                  : Colors.green,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Icon(
                    Icons.table_restaurant,
                    color: Colors.white,
                    size: 48,
                  ),
                  Positioned(
                    bottom: 8,
                    child: Text(
                      'Table ${table.number}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.white),
                      onPressed: () => _deleteTable(table.number),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTable,
        child: const Icon(Icons.add),
      ),
    );
  }
}

