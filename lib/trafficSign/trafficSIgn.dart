import 'package:flutter/material.dart';
import 'package:license/trafficSign/trafficSignPage.dart';

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
        title: const Text('Biển báo'),
        backgroundColor: Colors.green,
      ),
      body: PageView(
        scrollDirection: Axis.horizontal,
        children: const [
          TrafficSignPage(type: 0),
          TrafficSignPage(type: 1),
          TrafficSignPage(type: 2),
        ],
      ),
    );
  }
}