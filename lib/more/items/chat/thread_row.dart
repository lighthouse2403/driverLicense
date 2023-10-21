import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:license/more/model/thread_model.dart';

class ThreadRow extends StatefulWidget {
  const ThreadRow({super.key, required this.thread});

  final ThreadModel thread;

  @override
  State<ThreadRow> createState() => ThreadRowState();
}

class ThreadRowState extends State<ThreadRow> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 3,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ]
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.thread.deviceName ?? 'No name',
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color:  Colors.green,
              overflow: TextOverflow.ellipsis
            ),
          ),
          const SizedBox(height: 6),
          Text(
            widget.thread.title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400
            ),
          ),
          const SizedBox(height: 4),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              widget.thread.createTime.toDate().toString(),
              textAlign: TextAlign.right,
              style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400
              ),
            ),
          )
        ],
      ),
    );
  }
}
