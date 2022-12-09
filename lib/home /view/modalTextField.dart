// ignore_for_file: prefer_const_constructors, use_super_parameters, lines_longer_than_80_chars

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:motion_toast/motion_toast.dart';
import 'package:uuid/uuid.dart';

class ModalTextField extends StatelessWidget {
  ModalTextField(
      {Key? key,
      required this.buttonType,
      this.name,
      this.description,
      this.todoId})
      : super(key: key);
  bool buttonType;
  late TextEditingController discriptionController =
      TextEditingController(text: description);

  String? name, description;
  late TextEditingController todoNameController =
      TextEditingController(text: name);
  String? todoId;

  final todoRef = FirebaseFirestore.instance.collection('todo collection');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        color: Color.fromARGB(26, 72, 42, 136),
        height: 350,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            children: [
              Text(
                (buttonType) ? "Add Todo" : "Edit Todo",
                style: TextStyle(fontSize: 22, color: Colors.green),
              ),
              TextField(
                controller: todoNameController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: (Color.fromARGB(179, 134, 132, 132)),
                  border: InputBorder.none,
                  hintText: ' Enter Todo here',
                ),
              ),
              SizedBox(
                height: 5,
              ),
              TextField(
                controller: discriptionController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: (Color.fromARGB(179, 134, 132, 132)),
                  border: InputBorder.none,
                  hintText: ' Enter Todo description',
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (buttonType) {
                    createTodo(
                        name: todoNameController.text,
                        description: discriptionController.text);
                    Navigator.pop(context);
                    // MotionToast(
                    //         icon: Icons.done,
                    //         description: Text('success'),
                    //         primaryColor: Colors.green)
                    //
                    //    .show(context);
                  } else {
                    updateTodo(
                      todoName: todoNameController.text,
                      description: discriptionController.text,
                    );
                    Navigator.pop(context);
                  }
                },
                child: Text((buttonType) ? "Add" : "Edit"),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> createTodo({
    required String name,
    required String description,
  }) async {
    final auth = FirebaseAuth.instance;
    final userId = auth.currentUser!.uid;
    var uuid = Uuid();
    var todoId = uuid.v4();

    try {
      await todoRef.doc(todoId).set({
        'todo name ': name,
        'description': description,
        'userId': userId,
        'todoId': todoId,
      });
    } catch (e) {}
  }

  Future<void> updateTodo(
      {required String todoName, required String description}) async {
    try {
      await todoRef.doc(todoId).update({
        'todo name ': todoName,
        'description': description,
      });
    } catch (e) {}
  }
}
