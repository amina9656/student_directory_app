import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Future<void> AddStudent(String name, String email, String course,BuildContext context) async {
  await FirebaseFirestore.instance.collection("students").add({
    "NAME": name,
    "EMAIL": email,
    "COURSE": course,
  });
  Navigator.pop(context);
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Student added Succesfully")));
}
Stream<QuerySnapshot> getStudents(){
  return FirebaseFirestore.instance.collection("students").snapshots();
}
Future<void>deletestudent(String id,BuildContext context)async{
  await FirebaseFirestore.instance.collection("students").doc(id).delete();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Deleted Succesfully")));
}
Future<void>updatestudent(String id,String name,String email, String course,BuildContext context) async{
  await FirebaseFirestore.instance.collection("students").doc(id).update({ "NAME": name,
    "EMAIL": email,
    "COURSE": course,});
   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Updated successfully")));
}
