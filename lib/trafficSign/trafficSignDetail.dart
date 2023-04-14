import 'package:flutter/material.dart';
import 'package:license/trafficSign/Model/TrafficSignModel.dart';

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
        title: Text('Biển ${widget.trafficSignModel.name}',
          style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w800),
        ),
        backgroundColor: Colors.green,
      ),
      body: Container(
        decoration: const BoxDecoration(
            color: Colors.white
        ),
        padding: const EdgeInsets.only(left: 16, right: 16, top:  20),
        child: ListView(
          children: [
            Text('Biển ${widget.trafficSignModel.name}',
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.green,
                  fontWeight: FontWeight.w700),
            ),
            Container(
              margin: const EdgeInsets.all(16),
              child: Center(
                child: Image.asset('assets/icon/trafficSign/${widget.trafficSignModel.name}.png', width: 160, height: 160,),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  color: Colors.green.withOpacity(0.5)
              ),
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.only(left: 10, right: 10, top: 16, bottom: 16),
              child: Text(widget.trafficSignModel.comment,
                  style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w500)),
            )
          ],
        )
      )
    );
  }
}