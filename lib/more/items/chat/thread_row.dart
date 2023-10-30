import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:license/extension/date_extension.dart';
import 'package:license/extension/text_extension.dart';
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
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
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
          Text(widget.thread.deviceName ?? 'No name').w700().text15().mainColor().ellipsis(),
          const SizedBox(height: 6),
          Text(widget.thread.title).w400().text15(),
          const SizedBox(height: 4),
          Align(
            alignment: Alignment.centerRight,
            child: Text(widget.thread.createTime.toDate().generateDurationTime())
                .w400()
                .text13()
                .customColor(Colors.grey)
                .right(),
          ),
        ],
      ),
    );
  }
}
