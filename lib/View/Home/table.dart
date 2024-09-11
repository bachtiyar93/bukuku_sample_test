import 'package:bukuku_sample_test/Model/table.dart';
import 'package:bukuku_sample_test/core/AppHelpers.dart';
import 'package:bukuku_sample_test/global_state.dart';
import'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TableManagement extends StatefulWidget {
  const TableManagement({super.key});


  @override
  State<TableManagement> createState() => _TableManagementState();
}

class _TableManagementState extends State<TableManagement> {


  void _addTable() {
    setState(() {
      int newTableNumber = global.tables.length + 1;
      global.tables.add(TableData(number: newTableNumber, status: TableStatus.available));
    });
  }void _deleteTable(int tableNumber) {
    setState(() {
      global.tables.removeWhere((table) => table.number == tableNumber);
      // Perbarui nomor meja setelah penghapusan
      for (int i = 0; i < global.tables.length; i++) {
        global.tables[i].number = i + 1;
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
        itemCount: global.tables.length,
        itemBuilder: (context, index) {
          final table = global.tables[index];
          return GestureDetector(
            onTap: () {
              if(table.status==TableStatus.occupied){
                return AppHelpers.showSnackBar(content: Text('Meja terisi'), color: Colors.amber);
              }
              if(table.status==TableStatus.occupied && table==global.tableSelected){
                setState(() {
                  global.tables.where((element) => element==global.tableSelected).first.status=TableStatus.occupied;
                });
                 AppHelpers.showSnackBar(content: Text('Meja dipindahkan'), color: Colors.green);
              }
              setState(() {
                if (table.status == TableStatus.available) {
                  table.status = TableStatus.occupied;
                } else {
                  table.status = TableStatus.available;
                }});
              global.selectTable(table);
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

