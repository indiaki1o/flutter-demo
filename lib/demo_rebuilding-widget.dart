import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyDataTable(),
    );
  }
}

class MyDataTable extends StatefulWidget {
  @override
  _MyDataTableState createState() => _MyDataTableState();
}

class _MyDataTableState extends State<MyDataTable> {
  List<DataRow> _dataRows = [
    DataRow(cells: [
      DataCell(Text('John')),
      DataCell(Text('Doe')),
      DataCell(Text('30'))
    ]),
    DataRow(cells: [
      DataCell(Text('Jane')),
      DataCell(Text('Smith')),
      DataCell(Text('25'))
    ]),
    // Add more data rows...
  ];

  int _sortColumnIndex = 0;
  bool _isAscending = true;

  void _sort<T>(Comparable<T> Function(DataRow) getField, int columnIndex,
      bool ascending) {
    _dataRows.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });

    setState(() {
      _sortColumnIndex = columnIndex;
      _isAscending = ascending;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sortable DataTable')),
      body: SingleChildScrollView(
        child: DataTable(
          sortColumnIndex: _sortColumnIndex,
          sortAscending: _isAscending,
          columns: [
            DataColumn(
                label: Text('First Name'),
                onSort: (columnIndex, ascending) {
                  _sort<String>((row) => row.cells[columnIndex].child as String,
                      columnIndex, ascending);
                }),
            DataColumn(label: Text('Last Name')),
            DataColumn(label: Text('Age')),
          ],
          rows: _dataRows,
        ),
      ),
    );
  }
}
