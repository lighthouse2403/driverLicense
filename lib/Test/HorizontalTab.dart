import 'package:flutter/material.dart';
class HorizontalTab extends StatelessWidget {
  HorizontalTab({super.key, required this.length, required this.currentPage, required this.callback, required this.width});

  int currentPage = 0;
  int length = 0;
  double width = 0;

  ScrollController tabController = ScrollController();
  Function(int) callback;

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
        controller: tabController,
        itemCount: length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          bool shouldHightLight = (index + 1) == currentPage;
          return SizedBox(
            width: width,
            child: GestureDetector(
              onTap: () {
                callback(index);
              },
              child: Text(
                'Câu ${index + 1}',
                style: TextStyle(
                    fontSize: shouldHightLight ? 18 : 14,
                    fontWeight: shouldHightLight ? FontWeight.w700 : FontWeight.w500,
                    color: shouldHightLight ? Colors.green : Colors.black.withOpacity(0.2)
                ),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
    );
  }
}

