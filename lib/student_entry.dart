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
                      onPressed: () {},
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
