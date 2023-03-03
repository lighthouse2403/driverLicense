import 'package:flutter/material.dart';

class TrafficSignRow extends StatefulWidget {
  const TrafficSignRow({super.key});

  @override
  State<TrafficSignRow> createState() => _TrafficSignRowState();
}

class _TrafficSignRowState extends State<TrafficSignRow> {

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
          child: Image.asset('assets/home/tips.png', width: 60, height: 60,),),
        Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'P101',
                style: TextStyle(fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.green),),
              SizedBox(height: 10,),
              Text(
                'Biển báo hiệu hết giờ',
                style: TextStyle(fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),)
            ],
          ),
        ),
      ],
    );
  }
}