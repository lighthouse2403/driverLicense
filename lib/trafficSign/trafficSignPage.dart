import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:license/trafficSign/TrafficSignModel.dart';
import 'package:license/trafficSign/trafficSignRow.dart';

import '../Ads/adsHelper.dart';

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
    // TODO: implement initState
    super.initState();
    AdHelper.showAds();
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