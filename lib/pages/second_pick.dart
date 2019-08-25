import 'package:flutter/material.dart';

class SecondPickPage extends StatefulWidget {
  _SecondPickPageState createState() => _SecondPickPageState();
}

class _SecondPickPageState extends State<SecondPickPage> {

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Pick List'),
      ),
    );
  }
}