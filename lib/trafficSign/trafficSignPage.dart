import 'package:flutter/material.dart';
import 'package:license/trafficSign/trafficSignRow.dart';

class TrafficSignPage extends StatefulWidget {
  const TrafficSignPage({super.key, required this.type});
  final int type;

  @override
  State<TrafficSignPage> createState() => _TrafficSignPageState();
}

class _TrafficSignPageState extends State<TrafficSignPage> {

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 20,
      itemBuilder: (BuildContext context, int index) {
        return TrafficSignRow();
      },
      separatorBuilder: (BuildContext context, int index) {
        return Container(height: 1, color: Colors.grey,);
      },
    );
  }
}