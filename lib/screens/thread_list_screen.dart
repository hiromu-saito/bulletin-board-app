import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ThreadListScreen extends StatefulWidget {
  const ThreadListScreen({Key? key}) : super(key: key);
  static const String id = '/thread';

  @override
  _ThreadListScreenState createState() => _ThreadListScreenState();
}

class _ThreadListScreenState extends State<ThreadListScreen> {
  bool _saving = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _saving,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: const Text(
            'BBS',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 26.0,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.redAccent),
                  ),
                  onPressed: () async {
                    setState(() {
                      _saving = true;
                    });
                    await FirebaseAuth.instance.signOut();
                    setState(() {
                      _saving = false;
                    });
                    Navigator.pushNamed(context, '/');
                  },
                  child: const Text(
                    'Log out',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )),
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: Container(
          child: Text('ThreadScreen'),
        ),
      ),
    );
  }
}
