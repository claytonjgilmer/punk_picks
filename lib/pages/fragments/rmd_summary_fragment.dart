// 2019 SPECIFIC
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RmdSummaryPage extends StatefulWidget {
  final String teamNumber;
  final String matchType;
  final String matchNumber;
  RmdSummaryPage(this.teamNumber, this.matchType, this.matchNumber);
  _RmdSummaryPageState createState() => _RmdSummaryPageState();
}

class _RmdSummaryPageState extends State<RmdSummaryPage> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
          title: Text(this.widget.teamNumber +
              ' ' +
              this.widget.matchType +
              this.widget.matchNumber +
              ' Summary')),
    );
  }
}
