import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.blue,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
        ).copyWith(
          secondary: Colors.cyan,
        ),
      ),
      //'accentColor : Colors.cyan' As of Flutter 2.5, accentColor has been deprecated.
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String studentName = '', studentID = '', studyProgramID = '';
  double? studentGPA;

  getStudentName(name) {
    studentName = name;
  }

  getStudentID(id) {
    studentID = id;
  }

  getStudyProgramID(programID) {
    studyProgramID = programID;
  }

  getStudentGPA(gpa) {
    studentGPA = double.tryParse(gpa);
  }

  createData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("MyStudents").doc(studentID);

    //create Map
    Map<String, dynamic> students = {
      "studentName": studentName,
      "studentID": studentID,
      "studyProgramID": studyProgramID,
      "studentGPA": studentGPA
    };

    documentReference.set(students).whenComplete(() {
      print("$studentName created");
    }).catchError((e) {
      print("Error: $e");
    });
  }

  readData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("MyStudents").doc(studentID);

    documentReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        //Access data safty
        Map<String, dynamic>? data =
            datasnapshot.data() as Map<String, dynamic>?;

        if (data != null) {
          print("Student Name : ${data['studentName']}");
          print("Student ID : ${data['studentID']}");
          print("Study Program : ${data['studyProgramID']}");
          print("Student GPA : ${data['studentGPA']}");
        } else {
          print("Document dose not exist");
        }
      }
    }).catchError((e) {
      print("Error: $e");
    });
  }

  updateData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("MyStudents").doc(studentID);

    //create Map
    Map<String, dynamic> students = {
      "studentName": studentName,
      "studentID": studentID,
      "studyProgramID": studyProgramID,
      "studentGPA": studentGPA
    };

    documentReference.set(students).whenComplete(() {
      print("$studentName updated");
    }).catchError((e) {
      print("Error: $e");
    });
  }

  deleteData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("MyStudents").doc(studentID);

    documentReference.delete().whenComplete(() {
      print("$studentName deleted");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Flutter College",
          style: TextStyle(color: Colors.white), //Ensure text iswhite
        ),
        backgroundColor: Colors.blue, // set background color to blue
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: "Student ID",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue, width: 2.0))),
                onChanged: (String id) {
                  getStudentID(id);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: "Name",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue, width: 2.0))),
                onChanged: (String name) {
                  getStudentName(name);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: "Study Program ID",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue, width: 2.0))),
                onChanged: (String programID) {
                  getStudyProgramID(programID);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: "GPA",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue, width: 2.0))),
                onChanged: (String gpa) {
                  getStudentGPA(gpa);
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                //RaisedButton(onPressed:null) The RaisedButton widget has been deprecated in Flutter.
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, //Button backgrond color
                    foregroundColor: Colors.white, //text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    //action whem the button is clicked
                    createData();
                  },
                  child: Text("Create"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, //Button backgrond color
                    foregroundColor: Colors.white, //text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    //action whem the button is clicked
                    readData();
                  },
                  child: Text("Read"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange, //Button backgrond color
                    foregroundColor: Colors.white, //text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    //action whem the button is clicked
                    updateData();
                  },
                  child: Text("Update"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, //Button backgrond color
                    foregroundColor: Colors.white, //text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    //action whem the button is clicked
                    deleteData();
                  },
                  child: Text("Delete"),
                )
              ],
            ),

            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                textDirection: TextDirection.ltr,
                children: <Widget>[
                  Expanded(
                    child: Text("Student ID"),
                  ),
                  Expanded(
                    child: Text("Name"),
                  ),
                  Expanded(
                    child: Text("Program ID"),
                  ),
                  Expanded(
                    child: Text("GPA"),
                  ),
                ],
              ),
            ),

            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("MyStudents")
                    .snapshots(),
                builder: (context, snapshots) {
                  if (snapshots.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  if (snapshots.hasError) {
                    return Text('Error: ${snapshots.error}'); //handle erros
                  }
                  if (snapshots.hasData && snapshots.data != null) {
                    //Safety accessing data with null checks
                    QuerySnapshot querySnapshot =
                        snapshots.data as QuerySnapshot;
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: querySnapshot
                          .docs.length, //Using docs from QuerySnapshot
                      itemBuilder: (context, index) {
                        DocumentSnapshot documentSnapshot =
                            querySnapshot.docs[index]; // use correct snapshot

                        //Safely handlinh the GPA as double
                        double gpa = (documentSnapshot["studentGPA"] is double)
                            ? documentSnapshot["studentGPA"]
                            : double.tryParse(documentSnapshot["studentGPA"]
                                    .toString()) ??
                                0.0;
                        return Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(documentSnapshot["studentID"] ??
                                  "No ID"), //handel null values
                            ),
                            Expanded(
                              child: Text(documentSnapshot["studentName"] ??
                                  "No Name"), //handel null values
                            ),
                            Expanded(
                              child: Text(documentSnapshot["studyProgramID"] ??
                                  "No studyProgramID"), //handel null values
                            ),
                            Expanded(
                              child: Text(gpa.toString() ??
                                  "No GPA"), //handel null values
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    return Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
