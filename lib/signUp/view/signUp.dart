// ignore_for_file: use_build_context_synchronously, unawaited_futures, require_trailing_commas


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo/login/login.dart';
import 'package:todo/signUp/bloc/creation_bloc.dart';

class SignUpPage extends StatelessWidget {
  final TextEditingController fnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController snameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
 final TextEditingController phoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _regBloc = CreationBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>_regBloc,
      child: BlocListener<CreationBloc, CreationState>(
        listener: (context, state) {
          if (state is SignUpSucces) {
            Navigator.push(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (context) => LoginPage(),
                ));
          }else if(state is SignUpFailed){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 110, 109, 109),
          ),
          body: Padding(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      child: const Text(
                        'Sign in',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.length <= 4) {
                            return 'name should be atleast 4 charecter';
                          }
                          print('value');
                        },
                        controller: emailController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email ',
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: fnameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'first name ',
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: snameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Second Name ',
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: phoneController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'phone no',
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: TextFormField(
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
                              backgroundColor:
                                  Color.fromARGB(255, 54, 93, 125)),
                          child: const Text('SignUp'),
                          onPressed: () {
                          
                           
                            if (_formKey.currentState!.validate()) ;
                            _regBloc.add(SignEvent(
                                email: emailController.text,
                                fistnme: fnameController.text,
                                secondname: snameController.text,
                                phone: phoneController.text,
                                password: passwordController.text));
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
                ),
              )),
        ),
      ),
    );
  }

//   Future<void> createUser(
//     String email,
//     String password,
//     String fistnme,
//     String secondname,
//     String phone,
//     BuildContext context,
//   )
//   async {
//     final auth = FirebaseAuth.instance;
//     final userRef = FirebaseFirestore.instance.collection('users');
//     try {
//       await auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       await userRef.doc(auth.currentUser!.uid).set({
//         'userid': auth.currentUser!.uid,
//         'first name': fistnme,
//         'second name': secondname,
//         'email': email,
//         'password': password,
//         'profileImage': '',
//         'mobile': phone
//       });
//       Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => LoginPage(),
//           ));
//     } on FirebaseAuthException catch (e) {
//       print(e.code);
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text(e.code)));
//     }
//   }
// }
}
