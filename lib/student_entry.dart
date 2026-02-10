import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:student_directory_app/service.dart';

class StudentEntry extends StatefulWidget {
  const StudentEntry({super.key});

  @override
  State<StudentEntry> createState() => _StudentEntryState();
}

class _StudentEntryState extends State<StudentEntry> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController coursecontroller = TextEditingController();
  void editbox(DocumentSnapshot doc) {
    namecontroller.text = doc["NAME"];
    namecontroller.text = doc["EMAIL"];
    namecontroller.text = doc["COURSE"];
    showModalBottomSheet(
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.only(left: 30,right: 30),
        child: Column(
          children: [
            Text("edit student"),
             SizedBox(height: 20,),
            TextField(
              controller: namecontroller,
              decoration: InputDecoration(
                hintText: "Name",
                fillColor: Colors.grey,
                filled: true,
                labelStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(9),
                ),
              ),
            ),
            SizedBox(height: 20,),
            TextField(
              controller: emailcontroller,
              decoration: InputDecoration(
                fillColor: Colors.grey,
                filled: true,
                labelStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(9),
                ),
                hintText: "Email",
              ),
            ),
         SizedBox(height: 20,),
            TextField(
              controller: coursecontroller,
              decoration: InputDecoration(
                fillColor: Colors.grey,
                filled: true,
                hintText: "Course",
                labelStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(9),
              ),
            ),),
            SizedBox(height: 20),
            SizedBox(
              height: 40,
              width: 300,
              child: ElevatedButton(
                onPressed: () {
                  updatestudent(
                    doc.id,
                    namecontroller.text,
                    emailcontroller.text,
                    coursecontroller.text,
                    context,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text("edit"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: getStudents(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final studentdata = snapshot.data!.docs;

          return ListView.builder(
            itemCount: studentdata.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(studentdata[index]['NAME']),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(studentdata[index]['EMAIL']),
                    Text(studentdata[index]['COURSE']),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {editbox(studentdata[index]);},
                      icon: Icon(Icons.edit, color: Colors.blue),
                    ),
                    IconButton(
                      onPressed: () {
                        deletestudent(studentdata[index].id, context);
                      },
                      icon: Icon(Icons.delete, color: Colors.red),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: Text("Student directory"),
        centerTitle: true,
        leading: Icon(Icons.menu),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Add Student"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: namecontroller,
                      decoration: InputDecoration(
                        fillColor: Colors.grey,
                        filled: true,
                        hintText: "Name",
                      ),
                    ),
                    SizedBox(height: 20),

                    TextField(
                      controller: emailcontroller,
                      decoration: InputDecoration(
                        fillColor: Colors.grey,
                        filled: true,
                        hintText: "Email",
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: coursecontroller,
                      decoration: InputDecoration(
                        fillColor: Colors.grey,
                        filled: true,
                        hintText: "Course",
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: () {
                        AddStudent(
                          namecontroller.text,
                          emailcontroller.text,
                          coursecontroller.text,
                          context,
                        );
                      },
                      child: Text(
                        "Add",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.deepPurpleAccent,
      ),
    );
  }
}
