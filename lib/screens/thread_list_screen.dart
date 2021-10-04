import 'package:bulletin_board_app/screens/thread_add_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  CollectionReference thread = FirebaseFirestore.instance.collection('thread');
  List<DocumentSnapshot> documentList = [];

  @override
  void initState() {
    super.initState();
    getThreadDate();
  }

  void getThreadDate() async {
    final snapshot = await thread.get();
    setState(() {
      documentList = snapshot.docs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _saving,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
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
        body: ListView.separated(
          separatorBuilder: (context, index) {
            return const Divider(
              thickness: 0.8,
            );
          },
          itemCount: documentList.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(documentList[index]['threadName']),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text(
                      'delete?',
                      textAlign: TextAlign.center,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () async {
                          await thread.doc(documentList[index].id).delete();
                          Navigator.pop(context);
                          getThreadDate();
                        },
                        child: const Text(
                          'OK',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, ThreadAddScreen.id);
          },
        ),
      ),
    );
  }
}
