import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:license/chat/comment_model.dart';

class ChatRow extends StatefulWidget {
  const ChatRow({super.key, required this.comment});

  final CommentModel comment;

  @override
  State<ChatRow> createState() => ChatRowState();
}

class ChatRowState extends State<ChatRow> {

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
            widget.comment.deviceName ?? 'No name',
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color:  Colors.green,
                overflow: TextOverflow.ellipsis
            ),
          ),
          const SizedBox(height: 6),
          Text(
            widget.comment.content,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400
            ),
          ),
          const SizedBox(height: 4),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              widget.comment.createTime.toDate().toString(),
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
