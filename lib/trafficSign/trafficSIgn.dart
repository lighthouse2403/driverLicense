import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:license/trafficSign/trafficSignPage.dart';

class TrafficSign extends StatefulWidget {
  const TrafficSign({super.key});

  @override
  State<TrafficSign> createState() => _TrafficSignState();
}

class _TrafficSignState extends State<TrafficSign> {

  // Fetch content from the json file
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/json/trafficSign.json');
    final data = await json.decode(response);
    print(data.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Biển báo'),
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