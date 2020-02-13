// 2020 SPECIFIC
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataPoint {
  final double value;
  final String teamNumber;
  DataPoint(this.value, this.teamNumber);
}

class BarVisualisation extends StatefulWidget {
  final String sortBy;

  BarVisualisation(this.sortBy);

  _BarVisualisationState createState() => _BarVisualisationState();
}

class _BarVisualisationState extends State<BarVisualisation> {
  List<DataPoint> graphPoints;
  List<Series<DataPoint, String>> seriesList;

  @override
  void initState() {
    super.initState();
    graphPoints = new List<DataPoint>();
    seriesList = new List<Series<DataPoint, String>>();
    Firestore.instance.collection('teams').getDocuments().then((docs) {
      List<DocumentSnapshot> documents = docs.documents;
      documents.forEach((data) {
        graphPoints.add(new DataPoint(
            data[this.widget.sortBy], data["teamNumber"].toString()));
      });
      seriesList = [
        new Series<DataPoint, String>(
            id: 'Series',
            data: graphPoints,
            domainFn: (DataPoint point, _) => point.teamNumber,
            measureFn: (DataPoint point, _) => point.value)
      ];
      setState((){});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Bar Graph Visualisation")),
      body: BarChart(
        seriesList,
        animate: true,
        vertical: false,
      ),
    );
  }
}
