import 'package:flutter/material.dart';
import 'package:license/extension/text_extension.dart';
import 'package:license/trafficSign/traffic_sign_detail.dart';
import 'package:license/trafficSign/Model/traffic_sign_model.dart';

class TrafficSignRow extends StatefulWidget {
  TrafficSignRow({super.key, required this.model});
  TrafficSignModel model;

  @override
  State<TrafficSignRow> createState() => _TrafficSignRowState();
}

class _TrafficSignRowState extends State<TrafficSignRow> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TrafficSignDetail(trafficSignModel: widget.model,))
        );
      },
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
            child: Image.asset('assets/icon/trafficSign/${widget.model.name}.png', width: 60, height: 60,),
          ),
          Flexible(
              child: Container(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.model.name).w600().text16().blackColor(),
                    const SizedBox(height: 10,),
                    Text(
                      widget.model.comment,
                      style: const TextStyle(fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    )
                  ],
                ),
              )
          )
        ],
      ),
    );
  }
}