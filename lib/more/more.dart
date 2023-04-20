import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:license/CustomWidget/alert.dart';
import 'package:license/Database/sqlHelper.dart';
import 'package:license/more/more_model.dart';
import 'package:license/more/more_row.dart';

class More extends StatefulWidget {
  const More({super.key});

  @override
  State<More> createState() => _MoreState();
}

class _MoreState extends State<More> {
  List moreList = [
    MoreModel(icon: 'tips', name: 'Mẹo'),
    MoreModel(icon: 'wrongAnswer', name: 'Câu sai'),
    MoreModel(icon: 'reset', name: 'Xoá dữ liệu cũ'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Tiện ích'),
          backgroundColor: Colors.green,
        ),
        body: Container(
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
                  },
                  child: MoreRow(moreModel: moreList[index])
                );
              }
              ),
        )
    );
  }
}