import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'job/get_all_jobs.dart';




void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Small Jobs',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final myController = TextEditingController();
  final myController2 = TextEditingController();

  String Token;

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myController.dispose();
    myController2.dispose();
    super.dispose();
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/token.txt');
  }

  Future<File> writeCounter(String token) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString(token, mode: FileMode.write);
  }

  void getToken() async {
    var res = await http.post(Uri.encodeFull('https://small-jobs-backend.herokuapp.com/users/get-token'), headers: {"Accept": "application/json"}, body: {"username": myController.text, "password": myController2.text});
    setState(() {
      var resBody = json.decode(res.body);
      Token = resBody["token"];
      writeCounter(Token);
    });
    Navigator.of(context).push(
        new MaterialPageRoute(builder: (
            BuildContext context) =>
        new AvailableJobs(
            token: Token)));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: myController,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Username'
              ),
            ),
            TextField(
              controller: myController2,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Password'
              ),
            ),
            RaisedButton(
              padding: const EdgeInsets.all(12.0),
              onPressed: () => getToken(),
              color: Colors.blue,
              shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(8.0)),
              elevation: 2.0,
              child: new Text("Login",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,)),
            ),
          ],
        ),
      ),
    );
  }
}
