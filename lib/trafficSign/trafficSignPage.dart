import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:license/trafficSign/trafficSignModel.dart';
import 'package:license/trafficSign/trafficSignRow.dart';
import 'package:flutter/services.dart';

import '../Ads/adsHelper.dart';

class TrafficSignPage extends StatefulWidget {
  const TrafficSignPage({super.key, required this.type});
  final int type;

  @override
  State<TrafficSignPage> createState() => _TrafficSignPageState();
}

class _TrafficSignPageState extends State<TrafficSignPage> {
  List traficSignArray = [];

  Future<void> loadTrafficSignData() async {
    final String response = await rootBundle.loadString('assets/json/trafficSign.json');
    final data = await json.decode(response);
    setState(() {
      traficSignArray = data["trafficSign"];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadTrafficSignData();

    AdHelper.showAds();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: traficSignArray.length,
      itemBuilder: (BuildContext context, int index) {
        var model = TrafficSignModel.fromJson(traficSignArray[index]);
        return TrafficSignRow(model: model);
      },
      separatorBuilder: (BuildContext context, int index) {
        return Container(height: 0.5, color: Colors.grey,);
      },
    );
  }
}