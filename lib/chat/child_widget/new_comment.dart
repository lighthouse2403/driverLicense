import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:license/_gen/assets.gen.dart';
import 'package:license/common/app_colors.dart';
import 'package:license/extension/font_size_extension.dart';
import 'package:license/extension/font_weight_extension.dart';
import 'package:license/extension/text_color_extension.dart';
import 'package:license/firebase/firebase_chat.dart';
import 'package:license/more/model/thread_model.dart';

class NewComment extends StatefulWidget {
  NewComment({super.key, required this.thread, required this.sentComment});

  final ThreadModel thread;
  VoidCallback sentComment;
  @override
  State<NewComment> createState() => NewCommentState();
}

class NewCommentState extends State<NewComment> {
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.mainColor, width: 1)
              ),
              child: TextField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Nhận xét',
                    hintStyle: const TextStyle().textW400().text14().greyColor(),

                ),
                  controller: textController,
                  maxLines: 4,
                  minLines: 1,
                  style: const TextStyle().textW400().text14().blackColor()
              ),
            )
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          alignment: Alignment.center,
          width: 80,
          height: 60,
          child: InkWell(
              onTap: () {
                setState(() {
                  addComment();
                });
              },
              child: Assets.icon.chat.send.svg(width: 20, height: 20)
          ),
        )
      ],
    );
  }

  Future<void> addComment() async {
    if (textController.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Vui lòng viết nhận xét để gửi?');
      return;
    }
    await FirebaseChat.instance.addNewComment(widget.thread, textController.text);
    textController.text = '';
    widget.sentComment();
  }
}
