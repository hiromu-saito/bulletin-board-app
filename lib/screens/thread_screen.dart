import 'package:flutter/material.dart';

class ThreadScreen extends StatefulWidget {
  const ThreadScreen({Key? key}) : super(key: key);
  static const String id = '/thread';

  @override
  _ThreadScreenState createState() => _ThreadScreenState();
}

class _ThreadScreenState extends State<ThreadScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Text('ThreadScreen'),
      ),
    );
  }
}
