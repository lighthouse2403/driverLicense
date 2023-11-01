import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:license/chat/chat.dart';
import 'package:license/common/base/base_app_bar.dart';
import 'package:license/customer_widget/alert.dart';
import 'package:license/database/sql_helper.dart';
import 'package:license/more/items/chat/thread_list.dart';
import 'package:license/more/model/more_model.dart';
import 'package:license/more/child_view/more_row.dart';
import 'package:license/more/tips.dart';
import 'package:license/theory/models/theory_question_model.dart';
import 'package:license/theory/question_page.dart';

class More extends StatefulWidget {
  More({super.key});

  @override
  State<More> createState() => _MoreState();
}

class _MoreState extends State<More> {
  List moreList = [
    MoreModel(icon: 'tips', name: 'Mẹo'),
    MoreModel(icon: 'wrongAnswer', name: 'Câu sai'),
    MoreModel(icon: 'chat', name: 'Giao lưu'),
    MoreModel(icon: 'reset', name: 'Xoá dữ liệu cũ'),
  ];
  List<QuestionModel> wrongQuestions = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<void> loadWrongQuestion() async {
    List<QuestionModel> questionsOnAllTest = await SQLHelper().getQuestionsOnAllTest();
    wrongQuestions = questionsOnAllTest.where((element) => (element.selectedIndex != element.answerIndex) && element.selectedIndex != -1).toSet().toList();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: BaseAppBar(title: 'Tiện ích'),
        body: FutureBuilder(
            future: loadWrongQuestion(),
            builder: (context, item) {
              return Container(
                  margin: const EdgeInsets.all(10),
                  child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemCount: moreList.length,
                      shrinkWrap: false,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                            onTap: () {
                              gotoDetail(index);
                            },
                            child: MoreRow(moreModel: moreList[index])
                        );
                      }
                  ),
                );
            }
        )
    );
  }

  void gotoDetail(int index) {
    switch (index) {
      case 0:
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Tips())
        );
        break;
      case 1:
        if (wrongQuestions.isEmpty) {
          Fluttertoast.showToast(msg: 'Bạn chưa làm bài thi thử.', gravity: ToastGravity.CENTER);
          return;
        }

        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => QuestionPage(questionList: wrongQuestions, title: 'Câu hay sai'))
        );
        break;
      case 2:
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Chat())
            );
        break;
      case 3:
        showDialog(
          context: context,
          builder: (_) {
            return Alert(
                confirmPressed: () {
                  if (index == moreList.length - 1) {
                    SQLHelper.clearData();
                  }
                }
            );
          },
        );
        break;
      default:
        break;
    }
  }
}