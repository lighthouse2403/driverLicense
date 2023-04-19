import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    MoreModel(icon: '', name: 'Mẹo'),
    MoreModel(icon: '', name: 'Câu sai'),
    MoreModel(icon: '', name: 'Xoá dữ liệu cũ'),
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
                      builder: (_) => CupertinoAlertDialog (
                        title: const Text('Xác nhận'),
                        content: const Text('Bạn có muốn xoá tất cả lịch sử ôn tập không?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              if (index == moreList.length - 1) {
                                SQLHelper.clearData();
                              }
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Huỷ',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.red
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              if (index == moreList.length - 1) {
                                SQLHelper.clearData();
                              }
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Xoá',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black
                              ),
                            ),
                          )
                        ],
                      ),
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