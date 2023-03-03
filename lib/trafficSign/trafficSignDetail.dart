import 'package:flutter/material.dart';

class TrafficSignDetail extends StatefulWidget {
  const TrafficSignDetail({super.key});

  @override
  State<TrafficSignDetail> createState() => _TrafficSignDetailState();
}

class _TrafficSignDetailState extends State<TrafficSignDetail> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Biển báo'),
        backgroundColor: Colors.green,
      ),
      body: Text('Traffic sign detail'),
    );
  }
}