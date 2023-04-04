import 'package:flutter/material.dart';
class HorizontalTab extends StatelessWidget {

  HorizontalTab({super.key, required this.length, required this.currentPage, required this.callback, required this.title, required this.screenRate});

  int currentPage = 0;
  int length = 0;
  int screenRate = 4;
  List<String> title = [];

  ScrollController tabController = ScrollController();
  Function(int) callback;
  double screenWidth = WidgetsBinding.instance.window.physicalSize.width/WidgetsBinding.instance.window.devicePixelRatio;

  void animateToIndex(int index) {
    double tabItemWidth = screenWidth/screenRate;
    if (index == (length - 1)) {
      return;
    }

    Duration duration = const Duration(milliseconds: 500);
    int newIndex = (index - screenRate + 2) >= 0 ? (index - screenRate + 2) : 0;
    tabController.animateTo(newIndex * tabItemWidth, duration: duration, curve: Curves.easeOut);
  }

  @override
  Widget build(BuildContext context) {
    double tabItemWidth = screenWidth/screenRate;
    print(title.toString());
    return Container(
      height: 50,
      child: ListView.builder(
          controller: tabController,
          itemCount: length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            bool shouldHightLight = (index + 1) == currentPage;
            return SizedBox(
              width: tabItemWidth,
              child: GestureDetector(
                onTap: () {
                  callback(index);
                },
                child: Center(
                  child: Text(
                    title[index],
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

