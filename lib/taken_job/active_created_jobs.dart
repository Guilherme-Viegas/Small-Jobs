import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:small_jobs/job/job_details.dart';
import 'package:small_jobs/taken_job/taken_job_details.dart';


class ActiveCreatedJobs extends StatefulWidget {
  final String token;

  const ActiveCreatedJobs({Key key, this.token}) : super(key: key);

  @override
  ActiveCreatedJobsState createState() => ActiveCreatedJobsState();
}


class ActiveCreatedJobsState extends State<ActiveCreatedJobs> {
  List data;

  void getData() async {
    var res = await http.get(Uri.encodeFull("https://small-jobs-backend.herokuapp.com/jobs/user/active"), headers: {"Accept": "application/json", "Authorization": "Token " + widget.token});
    setState(() {
      var resBody = json.decode(res.body);
      data = resBody;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: new Color.fromRGBO(240, 240, 240, 4),
      appBar: AppBar(
        title: Text(
            "Your Active Created Jobs",
            style: TextStyle(
                color: Colors.amberAccent)
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.account_circle),
            color: Colors.blue ,
            tooltip: 'Your active created jobs',
//            onPressed: () => Navigator.of(context).push(
//                new MaterialPageRoute(builder: (
//                    BuildContext context) => new SavedRecipesStage())),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return new Container(
            height: 200,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  InkWell(
                    onTap: () =>   Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => new TakenJobDetails(token: widget.token, taken_job_id: data[index]["id"]))),
                    child: Column(
                      children: <Widget>[
                        Text(data[index]["title"]),
                        Text(data[index]["description"]),
                        Text(data[index]["payment"].toString() + "€"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}