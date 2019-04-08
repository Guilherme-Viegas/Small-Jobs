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
    myController.dispose();
    myController2.dispose();
    super.dispose();
  }

  void getToken() async {
    var res = await http.post(Uri.encodeFull('https://small-jobs-backend.herokuapp.com/users/get-token'), headers: {"Accept": "application/json"}, body: {"username": myController.text, "password": myController2.text});
    setState(() {
      var resBody = json.decode(res.body);
      Token = resBody["token"];
    });
    Navigator.of(context).push(
        new MaterialPageRoute(builder: (
            BuildContext context) =>
                new AvailableJobs(
                    token: Token
                )
        )
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 80.0),
            Column(
              children: <Widget>[
                Image.asset('assets/login_icon.png'),
              ]
            ),
            SizedBox(height: 86.0),
            TextFormField(
              controller: myController,
              autocorrect: false,
              decoration: InputDecoration(
                border: new OutlineInputBorder(
                  borderRadius: BorderRadius.circular(26),
                  borderSide: new BorderSide(width: 0, color: Colors.blue, style: BorderStyle.none),
                ),
                labelStyle: new TextStyle(
                    color: Colors.lightGreen
                ),
                labelText: "Email",
                hintText: 'example@gmail.com',
                hintStyle: TextStyle(fontSize: 16),
                filled: true,
                contentPadding: EdgeInsets.all(18),
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: myController2,
              obscureText: true,
              autocorrect: false,
              decoration: InputDecoration(
                border: new OutlineInputBorder(
                  borderRadius: BorderRadius.circular(26),
                  borderSide: new BorderSide(width: 0, color: Colors.blue, style: BorderStyle.none),
                ),
                labelStyle: new TextStyle(
                    color: Colors.lightGreen
                ),
                labelText: "Password",
                hintText: '*********',
                contentPadding: EdgeInsets.all(18),
              ),
            ),
            SizedBox(height: 46),
            RaisedButton(
              padding: const EdgeInsets.all(18.0),
              onPressed: () => getToken(),
              color: Colors.blue,
              shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(26.0)),
              elevation: 2.0,
              child: new Text("Login",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,)),
            ),
            SizedBox(height: 16),
            Text("Forgot Password?",
              style: TextStyle(
                fontSize: 16.0, color: Colors.grey
              ),
            ),
          ]
        ),
      )
    );
  }
}
