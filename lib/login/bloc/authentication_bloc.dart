
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<AuthenticationEvent>((event, emit) async {
      if (event is LoginEvent) {
        final _auth = FirebaseAuth.instance;
        try {
          await _auth.signInWithEmailAndPassword(
            email: event.email,
            password: event.password,
          );
          emit(LoginSucces());
        } on FirebaseAuthException catch (e) {
          emit(Loginfaild(message: e.code));
        }
      }
    });
  }
}
     // onPressed: () async {
                        //   final _auth = FirebaseAuth.instance;
                        //   try {
                        //     await _auth.signInWithEmailAndPassword(
                        //       email: mailController.text,
                        //       password: passwordController.text,
                        //     );
                        //     // ignore: unawaited_futures
                        //     Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //             builder: ((context) => HomeScreen())));
                        //   } on FirebaseAuthException catch (e) {
                        //     ScaffoldMessenger.of(context)
                        //         .showSnackBar(SnackBar(content: Text(e.code)));
                        //     print(e.code);
                        //     print('Login Faild');
                        //   }
                        // },