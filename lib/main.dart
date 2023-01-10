import 'package:flutter/material.dart';
import 'package:flutter_wtih_sqflite/Login/login.dart';
import 'dbHelper/DatabaseHelper.dart';
import 'constants.dart';

// Here we are using a global variable. You can use something like
// get_it in a production app.
final dbHelper = DatabaseHelper();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dbHelper.init();
  runApp( MaterialApp(
    home: Home(),
  ));
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auth Screen 1',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: kPrimaryColor,
        textTheme: TextTheme(
          headline4: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          button: TextStyle(color: kPrimaryColor),
          headline1:
          TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
        ),
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white.withOpacity(.2),
            ),
          ),
        ),
      ),
      home: WelcomeScreen(),
    );
  }
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

void _showToast(BuildContext context) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: const Text('Added to favorite'),
      action: SnackBarAction(
          label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
    ),
  );
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


class WelcomeScreen  extends StatelessWidget {
  const WelcomeScreen ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  return  Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/perosn.jpeg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "WELCOME TO SQFLITE DEMO\n",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          height: 0.0006,
                        ),
                      ),

                      TextSpan(

                        text: "MASTER OF DATABASE",
                        style: Theme.of(context).textTheme.titleSmall,
                      )
                    ],
                  ),
                ),
                FittedBox(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return Login();
                        },
                      ));
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 25),
                      padding:
                      EdgeInsets.symmetric(horizontal: 26, vertical: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: kPrimaryColor,
                      ),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "START LEARNING",
                            style: Theme.of(context).textTheme.button?.copyWith(
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(width: 10),
                          const Icon(
                            Icons.arrow_forward,
                            color: Colors.black,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

