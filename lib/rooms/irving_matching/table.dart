import 'dart:convert';
import 'package:erp_dev/rooms/irving_matching/final_result_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyDataSource extends DataTableSource {
  List<Test> sortedData = [];
  Set<int> selectedRows = {};

  void setData(List<Test> rawData, int sortColumn, bool sortAscending) {
    sortedData = rawData.toList()
      ..sort((a, b) {
        final cellA = a.student1;
        final cellB = b.student1;
        return cellA.compareTo(cellB) * (sortAscending ? 1 : -1);
      });
    notifyListeners();
  }

  @override
  int get rowCount => sortedData.length;

  @override
  DataRow? getRow(int index) {
    return DataRow.byIndex(
      index: index,
      selected: selectedRows.contains(index),
      onSelectChanged: (selected) {
        if (selected == true) {
          selectedRows.add(index);
        } else {
          selectedRows.remove(index);
        }
        notifyListeners();
      },
      cells: [
        DataCell(Text(sortedData[index].student1)),
        // DataCell(Text(sortedData[index].))
        const DataCell(Text('NA')),
        DataCell(Text(sortedData[index].student1Sex)),
        DataCell(Text(sortedData[index].school)),
        const DataCell(Text('')), // Email
        // DataCell(Text(sortedData[index].prevSchool)),
        const DataCell(Text('Not assigned')), // Roommate
        const DataCell(Text('Not assigned')), // Room
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => selectedRows.length;
}

class DataTableExample extends StatefulWidget {
  const DataTableExample({super.key});

  @override
  State<DataTableExample> createState() => _DataTableExampleState();
}

class _DataTableExampleState extends State<DataTableExample> {
  final MyDataSource dataSource = MyDataSource();
  int _columnIndex = 0;
  bool _columnAscending = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final String response =
          await rootBundle.loadString('res/json/matches.json');
      final List<dynamic> data = json.decode(response);
      final List<Test> roommates =
          data.map((json) => Test.fromJson(json)).toList();

      // Debugging: Print the data to ensure it's being parsed correctly
      print('Loaded ${roommates.length} roommates');

      setState(() {
        dataSource.setData(roommates, _columnIndex, _columnAscending);
      });
    } catch (e) {
      // Debugging: Print any errors that occur during data loading
      print('Error loading data: $e');
    }
  }

  void _sort(int columnIndex, bool ascending) {
    setState(() {
      _columnIndex = columnIndex;
      _columnAscending = ascending;
      dataSource.setData(dataSource.sortedData, _columnIndex, _columnAscending);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PaginatedDataTable(
      sortColumnIndex: _columnIndex,
      sortAscending: _columnAscending,
      columns: [
        DataColumn(
            label: const Text('ID'),
            onSort: (columnIndex, ascending) => _sort(columnIndex, ascending)),
        const DataColumn(
          label: Text('Name'),
        ),
        DataColumn(
            label: const Text('Sex'),
            onSort: (columnIndex, ascending) => _sort(columnIndex, ascending)),
        DataColumn(
            label: const Text('School'),
            onSort: (columnIndex, ascending) => _sort(columnIndex, ascending)),
        const DataColumn(label: Text('Email')),
        const DataColumn(label: Text('Roommate')),
        const DataColumn(label: Text('Room')),
      ],
      source: dataSource,
    );
  }
}
