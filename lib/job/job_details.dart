import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:small_jobs/sample_job/taken_job_details.dart';


class JobDetails extends StatefulWidget {
  final String token;
  final Map details;

  const JobDetails({Key key, this.token, this.details}) : super(key: key);

  @override
  JobDetailsState createState() => JobDetailsState();
}

class JobDetailsState extends State<JobDetails> {
  int data;

  Future takeJob() async {
    var res = await http.get(Uri.encodeFull("https://small-jobs-backend.herokuapp.com/jobs/take/job=" + widget.details["id"].toString()), headers: {"Accept": "application/json", "Authorization": "Token " + widget.token});
    setState(() {
      var resBody = json.decode(res.body);
      data = resBody["taken_job_id"];
    });
    Navigator.of(context).push(
        new MaterialPageRoute(builder: (
            BuildContext context) =>
        new TakenJobDetails(
            taken_job_id: data
        )
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text("Title: " + widget.details["title"]),
                  Text("Description: " + widget.details["description"]),
                  Text("Payment: " + widget.details["payment"].toString() + "€"),
                  Text("Author: " + widget.details["author"]),
                  Text("Requirments: " + widget.details["requirments"]),
                  Text("Location: " + widget.details["location"]),
                  Text("Contact: " + widget.details["contact"]),
                  Text("Publish date: " + widget.details["publish_date"]),
                  RaisedButton(
                    padding: const EdgeInsets.all(12.0),
                    onPressed: () => takeJob(),
                    color: Colors.blue,
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(8.0)),
                    elevation: 2.0,
                    child: new Text("Take job",
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,)),
                  ),
                ],
              ),
            ],
          ),
        )
    );
  }

}