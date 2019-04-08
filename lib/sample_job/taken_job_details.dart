import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class TakenJobDetails extends StatefulWidget {
  final int taken_job_id;

  const TakenJobDetails({Key key, this.taken_job_id}) : super(key: key);

  @override
  TakenJobDetailsState createState() => TakenJobDetailsState();
}

class TakenJobDetailsState extends State<TakenJobDetails> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }

}