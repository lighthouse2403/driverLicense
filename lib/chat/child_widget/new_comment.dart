import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:license/_gen/assets.gen.dart';
import 'package:license/chat/bloc/chat_bloc.dart';
import 'package:license/chat/bloc/chat_event.dart';
import 'package:license/chat/bloc/chat_state.dart';
import 'package:license/common/app_colors.dart';
import 'package:license/common/component/loading_view.dart';
import 'package:license/extension/font_size_extension.dart';
import 'package:license/extension/font_weight_extension.dart';
import 'package:license/extension/text_color_extension.dart';
import 'package:license/firebase/firebase_chat.dart';
import 'package:license/more/model/thread_model.dart';

class NewComment extends StatefulWidget {
  NewComment({super.key, required this.thread, required this.sentComment});

  late ThreadModel thread;
  VoidCallback sentComment;
  @override
  State<NewComment> createState() => NewCommentState();
}

class NewCommentState extends State<NewComment> {
  TextEditingController textController = TextEditingController();
  ChatBloc chatBloc = ChatBloc();
  LoadingView loadingView = LoadingView();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => chatBloc,
        child: BlocListener<ChatBloc, ChatState> (
            listener: (context, state) {
              if (state is LoadingState) {
                loadingView.show(context);
                return;
              }

              if (state is SendCommentSuccessful) {
                _updateNewThread();
                  loadingView.hide();
                  widget.sentComment();
              }
            },
            child: Row(
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
                          _addComment();
                        });
                      },
                      child: Assets.icon.chat.send.svg(width: 20, height: 20)
                  ),
                )
              ],
            )
        )
    );
  }

  Future<void> _addComment() async {
    if (textController.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Vui lòng viết nhận xét để gửi?');
      return;
    }
    chatBloc.add(SendComment(widget.thread, textController.text));
    textController.text = '';
  }

  void _updateNewThread() async {
    widget.thread.updateCommentCount();
  }
}
