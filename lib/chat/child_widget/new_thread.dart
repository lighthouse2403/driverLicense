import 'package:flutter/material.dart';
import 'package:license/chat/bloc/chat_bloc.dart';
import 'package:license/common/app_colors.dart';
import 'package:license/common/base/base_app_bar.dart';
import 'package:license/common/base/base_statefull_widget.dart';
import 'package:license/extension/font_size_extension.dart';
import 'package:license/extension/font_weight_extension.dart';
import 'package:license/extension/text_color_extension.dart';
import 'package:license/extension/text_extension.dart';
import 'package:license/firebase/firebase_chat.dart';

class NewThread extends BaseStatefulWidget {
  const NewThread({super.key});
  @override
  State<NewThread> createState() => _NewThreadState();
}

class _NewThreadState extends BaseStatefulState<NewThread> {
  TextEditingController textController = TextEditingController();
  ChatBloc chatBloc = ChatBloc();

  onGoBack(dynamic value) {
    setState(() {});
  }

  @override
  Widget? buildBody() {
    return Scaffold(
        appBar: BaseAppBar(title: 'Thêm chủ đề'),
        body: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: 16, right: 16, top: 20),
              child: const Text('Nhập nội dung:').w500().text15().blackColor(),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.mainColor, width: 1)
              ),
              child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Nội dung',
                    hintStyle: const TextStyle().textW400().text14().greyColor(),

                  ),
                  controller: textController,
                  maxLines: 6,
                  minLines: 2,
                  style: const TextStyle().textW400().text14().blackColor()
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: 160,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: AppColors.mainColor, width: 1)
              ),
              child: InkWell(
                onTap: () async {
                  loadingView.show(context);
                  await FirebaseChat.instance.addNewThread(textController.text);
                  loadingView.hide();
                  Navigator.of(context).pop();
                },
                child: const Text('Tạo mới').w500().text16().whiteColor(),
              ),
            ),
            Expanded(child: Container())
          ],
        )
    );
  }
}