import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Model/taskModel.dart';

class TaskProvider with ChangeNotifier{
  List<Task> _task = [];
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  DateTime _selectedDate = DateTime.now();
  DateTime get selectedDate => _selectedDate;

  List<Task> get task => _task;

  addTask(Task tasks) async {

   await firestore.collection("tasks").add({
      "title":tasks.title,
      "description":tasks.description,
     "date": tasks.date
    }).then((value) {
      tasks.id = value.id;
      task.add(tasks);
   });
    notifyListeners();
  }
  removeTask(id) async {
    var index = task.indexWhere((element) => element.id == id);
    if(index != -1) {
      await firestore.collection("tasks").doc(id).delete();
      task.removeAt(index);
    }
    notifyListeners();
  }
  updateTask(Task tasks) async {
    var index = task.indexWhere((element) => element.id == tasks.id);
    if(index != -1){
      await firestore.collection("tasks").doc(tasks.id).update({
        "title": tasks.title,
        "description":tasks.description,
        "date": tasks.date
      }).then( // implement error handling
            (_) => Fluttertoast.showToast(
            msg: "Task updated successfully",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.SNACKBAR,
            backgroundColor: Colors.black54,
            textColor: Colors.white,
            fontSize: 14.0),
      )
          .catchError(
            (error) => Fluttertoast.showToast(
            msg: "Failed: $error",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.SNACKBAR,
            backgroundColor: Colors.black54,
            textColor: Colors.white,
            fontSize: 14.0),
      );
    }
    notifyListeners();
  }

  void updateSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  Future<void> fetchTasks() async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection('tasks').get();
      _task = snapshot.docs.map<Task>((doc) => Task.fromSnapshot(doc)).toList();
      print(_task.length);
      notifyListeners();
    } catch (error) {
      print('Error fetching tasks: $error');
    }
  }
}