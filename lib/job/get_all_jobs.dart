import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';


class AvailableJobs extends StatefulWidget {
  final String token;

  const AvailableJobs({Key key, this.token}) : super(key: key);

  @override
  AvailableJobsState createState() => AvailableJobsState();
}


class AvailableJobsState extends State<AvailableJobs> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(widget.token),
          ],
        ),
      ),
    );
  }
}