// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, inference_failure_on_function_invocation, inference_failure_on_instance_creation, prefer_single_quotes, must_be_immutable, lines_longer_than_80_chars

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:motion_toast/motion_toast.dart';
import 'package:todo/home%20/home.dart';
import 'package:todo/profile/profile.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  CollectionReference todoRef =
      FirebaseFirestore.instance.collection("todo collection");
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Todo'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.person,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(),
                ),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: todoRef
            .where("userId", isEqualTo: _auth.currentUser!.uid)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data!.docs);
            final todoItems = snapshot.data!.docs;
            return ListView.builder(
              itemCount: todoItems.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(todoItems[index]['todo name '].toString()),
                  subtitle: Text(todoItems[index]['description'].toString()),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          deleteTodo(todoItems[index]['todoId'].toString());
                        },
                        icon: Icon(
                          Icons.delete_forever,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (context) => ModalTextField(
                              buttonType: false,
                              name: todoItems[index]['todo name '].toString(),
                              description:
                                  todoItems[index]['description'].toString(),
                              todoId: todoItems[index]['todoId'].toString(),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.edit,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return ModalTextField(
                buttonType: true,
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
  Future <void> deleteTodo(String id)async{

final todoRef=FirebaseFirestore.instance.collection('todo collection');
try { await todoRef.doc(id).delete();
  
} catch (e) {
  
}
  }
// ignore: eol_at_end_of_file
}
