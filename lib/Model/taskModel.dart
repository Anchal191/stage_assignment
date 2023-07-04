import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  String? id;
  String title;
  String description;
   String? date;

  Task({this.id,required this.title, required this.description,this.date});
  factory Task.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return Task(
      id: snapshot.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
    );
  }
}