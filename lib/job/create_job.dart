import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CreateJob extends StatefulWidget {
  final String token;

  const CreateJob({Key key, this.token}) : super(key: key);

  @override
  CreateJobState createState() => CreateJobState();
}

class CreateJobState extends State<CreateJob> {
  List data;

  final jobTitleController = TextEditingController();
  final jobDescriptionController = TextEditingController();
  final jobRequirmentsController = TextEditingController();
  final jobPaymentController = TextEditingController();
  final jobLocationController = TextEditingController();
  final jobContactController = TextEditingController();

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
    jobTitleController.dispose();
    jobDescriptionController.dispose();
    jobRequirmentsController.dispose();
    jobPaymentController.dispose();
    jobLocationController.dispose();
    jobContactController.dispose();
    super.dispose();
  }

  void createJob() async{
    var res = await http.post(Uri.encodeFull('https://small-jobs-backend.herokuapp.com/jobs/create'), headers: {'Authorization': 'Token ' + widget.token}, body: {"title": jobTitleController.text, "description": jobDescriptionController.text, "requirments": jobRequirmentsController.text, "payment": jobPaymentController.text, "location": jobLocationController.text, "contact": jobContactController.text});
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: new Color.fromRGBO(240, 240, 240, 4),
      appBar: AppBar(
        title: Text(
            "Create Job",
            style: TextStyle(
                color: Colors.amberAccent)
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return new Container(
            margin: EdgeInsets.all(12),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(height: 86.0),
                  TextFormField(
                    controller: jobTitleController,
                    autocorrect: false,
                    decoration: InputDecoration(
                      border: new OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: new BorderSide(width: 0, color: Colors.blue, style: BorderStyle.none),
                      ),
                      labelStyle: new TextStyle(
                          color: Colors.lightGreen
                      ),
                      labelText: "Title",
                      hintText: 'Take the Trash Out',
                      hintStyle: TextStyle(fontSize: 16),
                      filled: true,
                      contentPadding: EdgeInsets.all(18),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: jobDescriptionController,
                    autocorrect: false,
                    decoration: InputDecoration(
                      border: new OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: new BorderSide(width: 0, color: Colors.blue, style: BorderStyle.none),
                      ),
                      labelStyle: new TextStyle(
                          color: Colors.lightGreen
                      ),
                      labelText: "Description",
                      hintText: 'Come to my door and ring the bell, I will give you the trash, just drop in the container outside the door.',
                      contentPadding: EdgeInsets.all(18),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: jobRequirmentsController,
                    autocorrect: false,
                    decoration: InputDecoration(
                      border: new OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: new BorderSide(width: 0, color: Colors.blue, style: BorderStyle.none),
                      ),
                      labelStyle: new TextStyle(
                          color: Colors.lightGreen
                      ),
                      labelText: "Requirments",
                      hintText: '',
                      contentPadding: EdgeInsets.all(18),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: jobPaymentController,
                    autocorrect: false,
                    decoration: InputDecoration(
                      border: new OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: new BorderSide(width: 0, color: Colors.blue, style: BorderStyle.none),
                      ),
                      labelStyle: new TextStyle(
                          color: Colors.lightGreen
                      ),
                      labelText: "Payment",
                      hintText: '5€',
                      contentPadding: EdgeInsets.all(18),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: jobLocationController,
                    autocorrect: false,
                    decoration: InputDecoration(
                      border: new OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: new BorderSide(width: 0, color: Colors.blue, style: BorderStyle.none),
                      ),
                      labelStyle: new TextStyle(
                          color: Colors.lightGreen
                      ),
                      labelText: "Location",
                      hintText: 'Rua do lado esquerdo, n4, Lisboa',
                      contentPadding: EdgeInsets.all(18),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: jobContactController,
                    autocorrect: false,
                    decoration: InputDecoration(
                      border: new OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: new BorderSide(width: 0, color: Colors.blue, style: BorderStyle.none),
                      ),
                      labelStyle: new TextStyle(
                          color: Colors.lightGreen
                      ),
                      labelText: "Contact",
                      hintText: '961234567',
                      contentPadding: EdgeInsets.all(18),
                    ),
                  ),
                  SizedBox(height: 46),
                  RaisedButton(
                    padding: const EdgeInsets.all(18.0),
                    onPressed: () => createJob(),
                    color: Colors.blue,
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(26.0)),
                    elevation: 2.0,
                    child: new Text("Add Job",
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,)),
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