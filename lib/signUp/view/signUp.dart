import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/home%20/view/home.dart';
import 'package:todo/login/login.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  static const String _title = 'Sample App';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                size: 20,
                color: Color.fromARGB(255, 153, 46, 46),
              )),
        ),
        body: const MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController fnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController snameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'TutorialKart',
                  style: TextStyle(
                      color: Color.fromARGB(255, 89, 127, 158),
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Sign in',
                  style: TextStyle(fontSize: 20),
                )),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email ',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: fnameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'first name ',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: snameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Second Name ',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: phoneController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'phone no',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                //forgot password screen
              },
              child: const Text(
                'Forgot Password',
              ),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 54, 93, 125)),
                  child: const Text('Login'),
                  onPressed: () {
                    createUser(
                      emailController.text,
                      passwordController.text,
                      fnameController.text,
                      snameController.text,
                      phoneController.text,
                      context,
                    );
                  },
                )),
            Row(
              // ignore: sort_child_properties_last
              children: <Widget>[
                const Text('Does not have account?'),
                TextButton(
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ));
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ],
        ));
  }

  Future<void> createUser(
    String email,
    String password,
    String fistnme,
    String secondname,
    String phone,
    BuildContext context,
  ) async {
    final auth = FirebaseAuth.instance;
    final userRef = FirebaseFirestore.instance.collection('users');
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await userRef.add({
        'userid': auth.currentUser!.uid,
        'first name': fistnme,
        'second name': secondname,
        'email': email,
        'password': password,
        'profileImage': '',
        'mobile':phone
      });
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ));
    } on FirebaseAuthException catch (e) {
      print(e.code);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.code)));
    }
  }
}
