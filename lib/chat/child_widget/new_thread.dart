import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:license/firebase/firebase_chat.dart';

class NewThread extends StatefulWidget {
  const NewThread({super.key});
  @override
  State<NewThread> createState() => _NewThreadState();
}

class _NewThreadState extends State<NewThread> {
  TextEditingController controller = TextEditingController();

  onGoBack(dynamic value) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Thêm chủ đề',
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: Colors.white
            ),
          ),
          backgroundColor: Colors.green,
        ),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 16, right: 16, top: 20),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ]
              ),
              child: TextField(
                controller: controller,
                maxLines: 8,
                minLines: 1,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: 160,
              height: 50,
              alignment: Alignment.center,
              color: Colors.green,
              child: InkWell(
                onTap: () async {
                  await FirebaseChat.instance.addNewThread(controller.text);
                  Navigator.pop(context);
                },
                child: const Text(
                  'Tạo mới',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500
                  ),
                ),
              ),
            ),
            Expanded(child: Container())
          ],
        )
    );
  }
}