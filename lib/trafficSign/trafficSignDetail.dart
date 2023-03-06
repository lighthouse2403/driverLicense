import 'package:flutter/material.dart';
import 'package:license/trafficSign/trafficSignModel.dart';

class TrafficSignDetail extends StatefulWidget {
  const TrafficSignDetail({super.key, required this.trafficSignModel});

  final TrafficSignModel trafficSignModel;
  @override
  State<TrafficSignDetail> createState() => _TrafficSignDetailState();
}

class _TrafficSignDetailState extends State<TrafficSignDetail> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.trafficSignModel.name),
        backgroundColor: Colors.green,
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 16, right: 16, top:  20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.trafficSignModel.comment,
              style: const TextStyle(
                              fontSize: 20,
                              color: Colors.green,
                              fontWeight: FontWeight.w700),),
            Container(
              child: Center(
                child: Image.asset('assets/trafficSign/${widget.trafficSignModel.image}',),)
          ),
            Text(widget.trafficSignModel.description,
              style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w500))
          ],
        ),
      )
    );
  }
}