import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:small_jobs/job/job_details.dart';


class AvailableJobs extends StatefulWidget {
  final String token;

  const AvailableJobs({Key key, this.token}) : super(key: key);

  @override
  AvailableJobsState createState() => AvailableJobsState();
}


class AvailableJobsState extends State<AvailableJobs> {
  List data;

  void getData() async {
    var res = await http.get(Uri.encodeFull("https://small-jobs-backend.herokuapp.com/jobs/jobs"), headers: {"Accept": "application/json", "Authorization": "Token " + widget.token});
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
            "Jobs",
            style: TextStyle(
                color: Colors.amberAccent)
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 0,
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
                    onTap: () =>   Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => new JobDetails(token: widget.token, details: data[index]))),
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