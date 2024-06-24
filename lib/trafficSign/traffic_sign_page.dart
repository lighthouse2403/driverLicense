import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:license/trafficSign/Model/traffic_sign_model.dart';
import 'package:license/trafficSign/traffic_sign_row.dart';

import '../Ads/ads_helper.dart';

class TrafficSignPage extends StatefulWidget {
  TrafficSignPage({super.key, required this.type, required this.traficSignByTypeArray});

  List<TrafficSignModel> traficSignByTypeArray;
  int type;

  @override
  State<TrafficSignPage> createState() => _TrafficSignPageState();
}

class _TrafficSignPageState extends State<TrafficSignPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: widget.traficSignByTypeArray.length,
      itemBuilder: (BuildContext context, int index) {
        return TrafficSignRow(model: widget.traficSignByTypeArray[index]);
      },
      separatorBuilder: (BuildContext context, int index) {
        return Container(height: 0.5, color: Colors.grey,);
      },
    );
  }
}