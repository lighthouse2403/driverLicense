import 'package:flutter/material.dart';

class TrafficSign extends StatefulWidget {
  const TrafficSign({super.key});

  @override
  State<TrafficSign> createState() => _TrafficSignState();
}

class _TrafficSignState extends State<TrafficSign> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Biển báo'),
        backgroundColor: Colors.green,
      ),
      body: const Center(
          child: Text('Traffic sign,')
      ),
    );
  }
}