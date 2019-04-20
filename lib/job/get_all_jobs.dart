import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:small_jobs/job/create_job.dart';
import 'package:small_jobs/job/job_details.dart';
import 'package:small_jobs/taken_job/active_created_jobs.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';

class AvailableJobs extends StatefulWidget {
  final String token;

  const AvailableJobs({Key key, this.token}) : super(key: key);

  @override
  AvailableJobsState createState() => AvailableJobsState();
}


class AvailableJobsState extends State<AvailableJobs> {
  List data;
  Map<String, double> currentLocation = new Map();
  StreamSubscription<Map<String, double>> locationSubscription;

  Location location = new Location();
  String error;



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

    //Default variable set is 0
    currentLocation['latitude'] = 0.0;
    currentLocation['longitude'] = 0.0;

    initPlatformState();
    locationSubscription = location.onLocationChanged().listen((Map<String, double> result) {
      setState(() {
        currentLocation = result;
      });
    });
    
    getData();
  }
  
  void initPlatformState() async {
    Map<String, double> my_location;
    try{
      my_location = await location.getLocation();
      error="";
    }on PlatformException catch(e) {
      if(e.code == 'PERMISSION_DENIED')
        error = 'Permission denied';
      else if(e.code == 'PERMISSION_DENIED_NEVER_ASK')
        error = 'Permission denied - please ask the user to enable it from the app settings';
      my_location = null;
    }
    setState(() {
      currentLocation = my_location;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void createJob() {

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
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.account_circle),
            color: Colors.blue ,
            tooltip: 'Your active created jobs',
            onPressed: () => Navigator.of(context).push(
                new MaterialPageRoute(builder: (
                    BuildContext context) => new ActiveCreatedJobs(token: widget.token,))),
          ),
        ],
      ),
      body: Container(
        child: new ListView.builder(
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
                    IconButton(
                      icon: Icon(Icons.add),
                      color: Colors.blue,
                      tooltip: 'Your active created jobs',
                      onPressed: () => Navigator.of(context).push(
                          new MaterialPageRoute(builder: (
                              BuildContext context) => new CreateJob(token: widget.token,))),
                    ),
                    Text('Lat/Lng:${currentLocation['latitude']}/${currentLocation['longitude']}', style:
                    TextStyle(fontSize: 20.0, color: Colors.blue),),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}