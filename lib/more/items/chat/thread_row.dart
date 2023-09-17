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
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      decoration: const BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.all(Radius.circular(4))
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.thread.title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600
            ),
          ),
          const SizedBox(height: 3),
          Text(
            widget.thread.createTime.toDate().toString(),
            style: const TextStyle(
                fontSize: 14,
                color: Colors.greenAccent,
                fontWeight: FontWeight.w400
            ),
          )
        ],
      ),
    );
  }
}
