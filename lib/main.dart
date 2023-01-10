import 'package:flutter/material.dart';
import 'dbHelper/DatabaseHelper.dart';

// Here we are using a global variable. You can use something like
// get_it in a production app.
final dbHelper = DatabaseHelper();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dbHelper.init();
  runApp(const MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SqfLiteDemo"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Stack(children: [
        const Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Welcome to SqFlite Demo for beginners',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),
            borderOnForeground: true,
            elevation: 2,
            color: Colors.amberAccent,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            margin: EdgeInsets.all(8),

          ),
        ),
        Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  _insert();
                },
                child: const Text('insert Value'),
              ),
              ElevatedButton(
                onPressed: () {
                  _query();
                },
                child: const Text('Query Value'),
              ),
              ElevatedButton(
                onPressed: () {
                  _update();
                },
                child: const Text('Update Value'),
              ),
              ElevatedButton(
                onPressed: () {
                  _delete();
                },
                child: const Text('Delete Value'),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

// Button onPressed methods

void _insert() async {
  // row to insert
  Map<String, dynamic> row = {
    DatabaseHelper.columnName: 'Smit Modi',
    DatabaseHelper.columnAge: 32
  };
  final id = await dbHelper.insert(row);
  debugPrint('inserted row id: $id');
}

void _query() async {
  final allRows = await dbHelper.queryAllRows();
  debugPrint('query all rows:');
  for (final row in allRows) {
    debugPrint(row.toString());
  }
}

void _update() async {
  // row to update
  Map<String, dynamic> row = {
    DatabaseHelper.columnId: 1,
    DatabaseHelper.columnName: 'Mary',
    DatabaseHelper.columnAge: 32
  };
  final rowsAffected = await dbHelper.update(row);
  debugPrint('updated $rowsAffected row(s)');
}

void _delete() async {
  // Assuming that the number of rows is the id for the last row.
  final id = await dbHelper.queryRowCount();
  final rowsDeleted = await dbHelper.delete(id);
  debugPrint('deleted $rowsDeleted row(s): row $id');
}
