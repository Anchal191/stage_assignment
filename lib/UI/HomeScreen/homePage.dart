import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Model/taskModel.dart';
import '../../Repoistory/authProvider.dart';
import '../../Repoistory/sharedPrefProvider.dart';
import '../../Repoistory/taskProvider.dart';
import '../Auth/sigIn.dart';



class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final firebaseAuthProvider = Provider.of<AuthProvider>(context);
    final tokenProvider = Provider.of<TokenProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text('Welcome to todo'),
        actions: [
          IconButton(
            onPressed: () {
              tokenProvider.clearSharedPref('token');
              firebaseAuthProvider.signOut();
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/sigInPage', (Route<dynamic> route) => false);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Consumer<TaskProvider>(
        builder: (context, value , child)=>
      value.task.length == 0 ? Center(child: Text('No Task'),)  : ListView.builder(
           itemCount: value.task.length,
             itemBuilder: (context,index){
          return Container(
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: Colors.white,
              boxShadow:  [
                BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 5.0,
                  offset: Offset(0, 5), // shadow direction: bottom right
                ),
              ],
            ),
            margin: const EdgeInsets.only(bottom: 15.0,top: 5),
            child: ListTile(
              title: Text(value.task[index].title.toString(),
              ),
              subtitle: Text(value.task[index].description.toString()),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(onPressed: (){
                  ValueNotifier<DateTime> selectedDate = ValueNotifier<DateTime>(DateTime.now());
                  Future<void> _selectDate(BuildContext context) async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2021),
                      lastDate: DateTime(2025),
                    );
                    if (picked != null) {
                      selectedDate.value = picked;
                      print(selectedDate.value);
                    }
                  }
                  TextEditingController _titleController = TextEditingController();
                  TextEditingController _descriptionController = TextEditingController();
                  showDialog(context: context, builder: (context) => AlertDialog(
                    title: const Text(
                      'Edit Your Task',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.cyan),
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: _titleController,
                          style: const TextStyle(fontSize: 14),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 20,
                            ),
                            hintText: 'Title',
                            hintStyle: const TextStyle(fontSize: 14),
                            icon: const Icon(CupertinoIcons.square_list, color: Colors.cyan),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          controller: _descriptionController,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          style: const TextStyle(fontSize: 14),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 20,
                            ),
                            hintText: 'Description',
                            hintStyle: const TextStyle(fontSize: 14),
                            icon: const Icon(CupertinoIcons.bubble_left_bubble_right, color: Colors.cyan),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Row(children: [
                          Icon(CupertinoIcons.calendar,color: Colors.cyan,),
                          const SizedBox(width: 15),
                          ElevatedButton(onPressed: () => _selectDate(context), child: Text('Pick your Date'))
                        ],)
                      ],),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.grey,
                        ),
                        child: const Text('Cancel'),
                      ),
                      ValueListenableBuilder<DateTime>(
                          valueListenable: selectedDate,
                          builder: (context, value, _) {
                            return  ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.cyan,
                                ),
                                onPressed: (){
                                  context.read<TaskProvider>().updateTask(Task(
                                      title:_titleController.text, description: _descriptionController.text,
                                      date:value.toString()
                                  ));
                                  Navigator.pop(context);
                                }, child: Text('Edit'));
                          }),
                    ],
                  ));
                }, icon:Icon( Icons.edit)),
                IconButton(onPressed: (){
                  context.read<TaskProvider>().removeTask(value.task[index].id);
                }, icon:Icon( Icons.delete,color: Colors.red,))
            ],),
            ),
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan,
        onPressed: () {
          ValueNotifier<DateTime> selectedDate = ValueNotifier<DateTime>(DateTime.now());
          Future<void> _selectDate(BuildContext context) async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2021),
              lastDate: DateTime(2025),
            );
            if (picked != null) {
              selectedDate.value = picked;
              print(selectedDate.value);
            }
          }
          TextEditingController _titleController = TextEditingController();
          TextEditingController _descriptionController = TextEditingController();
          showDialog(context: context, builder: (context) => AlertDialog(
            title: const Text(
              'New Task',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.cyan),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _titleController,
                  style: const TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    hintText: 'Title',
                    hintStyle: const TextStyle(fontSize: 14),
                    icon: const Icon(CupertinoIcons.square_list, color: Colors.cyan),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: _descriptionController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  style: const TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    hintText: 'Description',
                    hintStyle: const TextStyle(fontSize: 14),
                    icon: const Icon(CupertinoIcons.bubble_left_bubble_right, color: Colors.cyan),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Row(children: [
                  Icon(CupertinoIcons.calendar,color: Colors.cyan,),
                  const SizedBox(width: 15),
                  ElevatedButton(onPressed: () => _selectDate(context), child: Text('Pick your Date'))
                ],)
            ],),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey,
                ),
                child: const Text('Cancel'),
              ),
    ValueListenableBuilder<DateTime>(
    valueListenable: selectedDate,
    builder: (context, value, _) {
    return  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.cyan,
                    ),
                    onPressed: (){
                  context.read<TaskProvider>().addTask(Task(
                    title:_titleController.text, description: _descriptionController.text,
                    date:value.toString()
                  ));
                  Navigator.pop(context);
                }, child: Text('Add'));
              }),
            ],
          ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
