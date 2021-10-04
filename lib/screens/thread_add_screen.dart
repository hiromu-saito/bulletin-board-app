import 'package:bulletin_board_app/components/rounded_button.dart';
import 'package:bulletin_board_app/constant.dart';
import 'package:bulletin_board_app/screens/thread_list_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ThreadAddScreen extends StatefulWidget {
  const ThreadAddScreen({Key? key}) : super(key: key);
  static const String id = '/thread_add';

  @override
  _ThreadAddScreenState createState() => _ThreadAddScreenState();
}

class _ThreadAddScreenState extends State<ThreadAddScreen> {
  late String newThreadName;
  late QueryDocumentSnapshot managementThreadIdSnapShot;
  CollectionReference threadIdManagement =
      FirebaseFirestore.instance.collection('threadIdManagement');

  @override
  void initState() {
    super.initState();
    getMaxThreadId();
  }

  void getMaxThreadId() async {
    final snapshot = await threadIdManagement.get();
    setState(() {
      managementThreadIdSnapShot = snapshot.docs[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'BBS',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 26.0,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 0),
          child: Column(
            children: [
              TextField(
                textAlign: TextAlign.center,
                decoration: kTextFieldDecoration,
                onChanged: (value) {
                  newThreadName = value;
                },
              ),
              RoundedButton(
                title: 'add thread',
                color: Colors.blue,
                onPressed: () async {
                  await FirebaseFirestore.instance
                      .runTransaction((transaction) async {
                    int threadId = managementThreadIdSnapShot['threadId'] + 1;
                    await threadIdManagement
                        .doc(managementThreadIdSnapShot.id)
                        .update({'threadId': threadId});
                    await FirebaseFirestore.instance.collection('thread').add(
                        {'threadId': threadId, 'threadName': newThreadName});
                  });
                  Navigator.pushNamed(context, ThreadListScreen.id);
                },
              ),
            ],
          ),
        ));
  }
}
