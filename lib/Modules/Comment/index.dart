import 'package:flutter/material.dart';

class CommentPage extends StatefulWidget {
  CommentPage({Key key}) : super(key: key);
  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Comment Page"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Text('loading'),
    );
  }
}
