
import 'package:flutter/material.dart';
import 'package:todo_application/data/database.dart';

Future<void> showAddTodoDialog({required BuildContext context}) async {
  TextEditingController titleController = TextEditingController();

  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Add Todo'),
        content: TextField(
          controller: titleController,
          decoration: InputDecoration(labelText: 'Title'),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Database().addTodo( title: titleController.text);
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('Add'),
          ),
        ],
      );
    },
  );
}
class DateTimeUtilities {
  static bool isSameMinute(DateTime dateTime1, DateTime dateTime2) {
    return dateTime1.year == dateTime2.year &&
        dateTime1.month == dateTime2.month &&
        dateTime1.day == dateTime2.day &&
        dateTime1.hour == dateTime2.hour &&
        dateTime1.minute == dateTime2.minute;
  }
}
Future<void> showUpdateTodoDialog({required BuildContext context}) async {
  TextEditingController titleController = TextEditingController();

  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Add Todo'),
        content: TextField(
          controller: titleController,
          decoration: InputDecoration(labelText: 'Title'),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Database().addTodo( title: titleController.text);
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('Add'),
          ),
        ],
      );
    },
  );
}