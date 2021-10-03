import 'package:bulletin_board_app/components/rounded_button.dart';
import 'package:bulletin_board_app/constant.dart';
import 'package:bulletin_board_app/screens/thread_list_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  static const String id = "/registration";

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  late String email;
  late String password;
  bool _saving = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _saving,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text(
                'BBS',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 50.0,
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'enter your email',
                ),
                onChanged: (value) {
                  email = value;
                },
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                obscureText: true,
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'enter your password',
                ),
                onChanged: (value) {
                  password = value;
                },
              ),
              const SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                color: Colors.lightBlueAccent,
                title: 'Register',
                onPressed: () async {
                  setState(() {
                    _saving = true;
                  });
                  try {
                    UserCredential userCredential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                      email: email,
                      password: password,
                    );
                    Navigator.pushNamed(context, ThreadListScreen.id);
                  } on FirebaseAuthException catch (e) {
                    if (e.code == "weak-password") {
                      print('The password provided is too weak.');
                    } else if (e.code == "email-already-in-use") {
                      print('The account already exists for that email.');
                    }
                  } catch (e) {
                    print(e);
                  }
                  setState(() {
                    _saving = false;
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
