import 'package:flutter/material.dart';
import 'package:license/trafficSign/trafficSignDetail.dart';
import 'package:license/trafficSign/Model/TrafficSignModel.dart';

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
                    Text(
                      widget.model.name,
                      style: const TextStyle(fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.green),),
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