import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_application/data/auth.dart';
import 'package:todo_application/utils/todo_dialog.dart';

import '../constant/app_constant.dart';
import '../models/task_model.dart';
import '../models/user_model.dart';
import '../widgets/clock_painter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  TextEditingController titleController = TextEditingController();
  late DateTime _currentTime;
  final _currentTimeNotifier =
      ValueNotifier<DateTime>(DateTime.now()); // Add this

  // Rest of your code...

  @override
  void initState() {
    super.initState();
    // Initialize the time
    _currentTime = DateTime.now();
    // Update the time every second
    Timer.periodic(const Duration(seconds: 1), (timer) {
      final newTime = DateTime.now();
      if (!DateTimeUtilities.isSameMinute(_currentTime, newTime)) {
        // Notify only when the minute changes
        _currentTimeNotifier.value = newTime;
      }
      _currentTime = newTime;
    });
  }

  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              StreamBuilder(
                  stream: _firestore
                      .collection("users")
                      .doc(_auth.currentUser!.uid.toString())
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    } else {
                      Map<String, dynamic> userData =
                          snapshot.data?.data() as Map<String, dynamic>;

                      UserModel userModel = UserModel.fromJson(userData);
                      return Container(
                        color: AppConstant.backgroundColor,
                        width: width,
                        height: height / 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: height * 0.15,
                              width: width * 0.4,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Color(0xffD8605B), width: 3),
                                  image: const DecorationImage(
                                    image: NetworkImage(
                                        "https://www.shareicon.net/data/512x512/2016/05/24/770117_people_512x512.png"),
                                  )),
                            ),
                            Text(
                              userModel.fullName,
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.6,
                              ),
                            ),
                            Text(
                              "@${userModel.fullName}".toLowerCase(),
                              style: GoogleFonts.poppins(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: Color(0xffD8605B),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Auth().signOut(context: context);
                              },
                              child: Container(
                                width: width * 0.3,
                                padding: EdgeInsets.all(8),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Color(0xffF4C27F),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: const Text("Log Out"),
                              ),
                            )
                          ],
                        ),
                      );
                    }
                  }),
              SizedBox(
                height: height * 0.04,
              ),
              SizedBox(
                width: 200.0,
                height: 200.0,
                child: CustomPaint(
                  painter: ClockPainter(_currentTime),
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Task List",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        letterSpacing: 0.6,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.add_circle_outline_outlined,
                        color: Color(0xffF4C27F),
                        size: 35,
                      ),
                      onPressed: () {
                        showAddTodoDialog(context: context);
                      },
                    )
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              SizedBox(
                  height: height,
                  width: width,
                  child: StreamBuilder(
                    stream: _firestore
                        .collection("todos")
                        .doc(_auth.currentUser!.uid)
                        .collection("My-todos")
                        .snapshots(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      } else {
                        List<Task> todos = [];
                        if (snapshot.data != null) {
                          // Adjust the casting based on the actual type
                          todos = (snapshot.data!
                                  as QuerySnapshot<Map<String, dynamic>>)
                              .docs
                              .map(
                                  (document) => Task.fromJson(document.data()!))
                              .toList();
                        }
                        return ListView.builder(
                          itemCount: todos.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      15.0), // Adjust the radius as needed
                                ),
                                tileColor: Colors.grey.shade300,
                                contentPadding: const EdgeInsets.all(8.0),
                                onLongPress: () async {
                                  String documentId = todos[index].id;
                                  _firestore
                                      .collection("todos")
                                      .doc(_auth.currentUser!.uid)
                                      .collection("My-todos")
                                      .doc(documentId)
                                      .delete();
                                },
                                leading: Checkbox(
                                  value: todos[index].isCompleted,
                                  onChanged: (bool? value) async {
                                    String documentId = todos[index].id;
                                    DocumentReference documentReference =
                                        _firestore
                                            .collection("todos")
                                            .doc(_auth.currentUser!.uid)
                                            .collection("My-todos")
                                            .doc(documentId);

                                    try {
                                      // Update the 'isCompleted' field in Firestore
                                      await documentReference.update(
                                        {'isCompleted': value!},
                                      );
                                      print("Task updated successfully");
                                    } catch (error) {
                                      print("Error updating task: $error");

                                      // Handle the error here, for example, display a message to the user
                                    }
                                    setState(() {});
                                  },
                                ),
                                title: Text(todos[index].title),
                                trailing: IconButton(
                                  onPressed: () {
                                    showDialog<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                      title: Text('Add Todo'),
                                      content: TextField(
                                        controller: titleController,
                                        decoration:
                                            InputDecoration(labelText: 'Title'),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pop(); // Close the dialog
                                          },
                                          child: Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            String documentId = todos[index].id;
                                            DocumentReference
                                                documentReference = _firestore
                                                    .collection("todos")
                                                    .doc(_auth.currentUser!.uid)
                                                    .collection("My-todos")
                                                    .doc(documentId);

                                            try {
                                              // Update the 'isCompleted' field in Firestore
                                              await documentReference.update(
                                                {'title': titleController.text},
                                              );
                                              print(
                                                  "Task updated successfully");
                                            } catch (error) {
                                              print(
                                                  "Error updating task: $error");

                                              // Handle the error here, for example, display a message to the user
                                            }

                                            Navigator.of(context)
                                                .pop(); // Close the dialog
                                          },
                                          child: Text('Update'),
                                        ),
                                      ],
                                    );
    },
    );
                                  },
                                  icon: const Icon(Icons.edit),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
