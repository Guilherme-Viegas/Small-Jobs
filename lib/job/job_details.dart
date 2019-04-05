import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class JobDetails extends StatefulWidget {
  final String token;
  final Map details;

  const JobDetails({Key key, this.token, this.details}) : super(key: key);

  @override
  JobDetailsState createState() => JobDetailsState();
}

class JobDetailsState extends State<JobDetails> {
  Map data;

  Future takeJob() async {
    var res = await http.get(Uri.encodeFull("https://small-jobs-backend.herokuapp.com/jobs/take"), headers: {"Accept": "application/json", "Authorization": "Token " + widget.token}); // Not finished. I need to change the backend to get the id in the url and not the body because we can't do a get with body on flutter
    setState(() {
      var resBody = json.decode(res.body);
      data = resBody;
    });
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