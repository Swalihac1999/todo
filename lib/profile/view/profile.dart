// ignore_for_file: prefer_const_constructors, avoid_redundant_argument_values

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final users = FirebaseFirestore.instance.collection('users');
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To Do'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: StreamBuilder(
            stream: users.doc(auth.currentUser!.uid).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final userData = snapshot.data!;
                print(userData);
                return Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        'My Account',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 13),
                      child: SizedBox(
                        height: 150,
                        child: Card(
                          color: Colors.white54,
                          child: Row(children: [
                            CircleAvatar(
                                radius: 60,
                                backgroundColor: Colors.white,
                                child: (userData['profileImage'] == '')
                                    ? Text(
                                        userData['first name'][0]
                                            .toString()
                                            .toUpperCase(),
                                        style: TextStyle(
                                            fontSize: 50,
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold))
                                    : ClipOval(
                                      child: Image.network(
                                          userData['profileImage'].toString(),
                                          fit: BoxFit.cover,
                                          width: 100,
                                          height: 100,),
                                          
                                    )),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 50,
                                ),
                                Text(
                                  userData['first name'].toString(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  userData['email'].toString(),
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                TextButton(
                                    onPressed: getImage,
                                    child: Text('upload pic'))
                              ],
                            ),
                          ]),
                        ),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: Text('My Task'),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: Text('Task Done'),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: Text('Pending task'),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: Text('Address'),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: Text('Notification'),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: Text('About us'),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                    SizedBox(
                      width: 330,
                      child: ElevatedButton(
                          style:
                              ElevatedButton.styleFrom(backgroundColor: Colors.white),
                          onPressed: () {},
                          child: Text(
                            'Logout',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          )),
                    )
                  ],
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }

  Future<void> getImage() async {
    final _imagePicker = ImagePicker();
    try {
      final image = await _imagePicker.pickImage(source: ImageSource.gallery);
      await updateProfile(image!);
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateProfile(XFile image) async {
    final refrence =
        FirebaseStorage.instance.ref().child('profile_image').child(image.name);
    final file = File(image.path);
    await refrence.putFile(file);
    final imageLink = await refrence.getDownloadURL();
    await users.doc(auth.currentUser!.uid).update({'profileImage': imageLink});
    print(imageLink);
  }
}
