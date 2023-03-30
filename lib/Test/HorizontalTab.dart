import 'package:flutter/material.dart';
class HorizontalTab extends StatelessWidget {

  HorizontalTab({super.key, required this.length, required this.currentPage, required this.callback, required this.width});

  int currentPage = 0;
  int length = 0;
  double width = 0;

  ScrollController tabController = ScrollController();
  Function(int) callback;

  void animateToIndex(int index) {
    double screenWidth = WidgetsBinding.instance.window.physicalSize.width/WidgetsBinding.instance.window.devicePixelRatio;
    var tabItemWidth = screenWidth/4;
    Duration duration = const Duration(milliseconds: 500);
    if ((index > 1) && ((index + 2) < length)) {
      tabController.animateTo((index - 1.5) * tabItemWidth, duration: duration, curve: Curves.easeOut);
    } else if (index >= (length - 1)) {
      tabController.animateTo((index - 3) * tabItemWidth, duration: duration, curve: Curves.easeOut);
    } else if (index == 0) {
      tabController.animateTo(0, duration: duration, curve: Curves.easeOut);
    } else if (index == (length - 2)) {
      tabController.animateTo((index - 2) * tabItemWidth, duration: duration, curve: Curves.easeOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: ListView.builder(
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
                child: Center(
                  child: Text(
                    'Câu ${index + 1}',
                    style: TextStyle(
                        fontSize: shouldHightLight ? 18 : 14,
                        fontWeight: shouldHightLight ? FontWeight.w700 : FontWeight.w500,
                        color: shouldHightLight ? Colors.green : Colors.black.withOpacity(0.2)
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              ),
            );
          }
      ),
    );
  }
}

