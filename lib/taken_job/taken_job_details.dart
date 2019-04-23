import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class TakenJobDetails extends StatefulWidget {
  final int taken_job_id;
  final String token;


  const TakenJobDetails({Key key, this.taken_job_id, this.token}) : super(key: key);

  @override
  TakenJobDetailsState createState() => TakenJobDetailsState();
}

class TakenJobDetailsState extends State<TakenJobDetails> {
  Map data;
  bool done_job;
  int i = 0;

  void verifyJob() async {
    await http.get(Uri.encodeFull("https://small-jobs-backend.herokuapp.com/jobs/validate/job=" + widget.taken_job_id.toString()), headers: {"Accept": "application/json", "Authorization": "Token " + widget.token});
  }

  Future<bool> CheckDoneJob() async {
    var res = await http.get(Uri.encodeFull("https://small-jobs-backend.herokuapp.com/jobs/taken_job/job=" + widget.taken_job_id.toString()), headers: {"Accept": "application/json", "Authorization": "Token " + widget.token});
    setState(() {
      var resBody = json.decode(res.body);
      data = resBody;
      if(data["worker_done"] == true && data["owner_done"] == true){
        done_job = true;
      }else{
        done_job = false;
      }
      i++;
    });
    return done_job;
  }


  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 3), (Timer t) => CheckDoneJob());
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
                  Text(
                      done_job == true ? "Job Done" : "Job in process"
                  ),
                  RaisedButton(
                    padding: const EdgeInsets.all(12.0),
                    onPressed: () => verifyJob(),
                    color: Colors.blue,
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(8.0)),
                    elevation: 2.0,
                    child: new Text("Job Done",
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