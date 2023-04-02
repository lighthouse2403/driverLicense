import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:license/trafficSign/trafficSignPage.dart';
import '../Test/HorizontalTab.dart';
import 'TrafficSignModel.dart';

class TrafficSign extends StatefulWidget {
  const TrafficSign({super.key});

  @override
  State<TrafficSign> createState() => _TrafficSignState();
}

class _TrafficSignState extends State<TrafficSign> {
  var currentPage = 1;
  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );
  double screenWidth = WidgetsBinding.instance.window.physicalSize.width/WidgetsBinding.instance.window.devicePixelRatio;
  HorizontalTab? horizontalTab;
  List<String> trafficSignList = ['Biển báo cấm', 'Biển hiệu lệnh', 'Biển chỉ dẫn', 'Biển cảnh báo', 'Biển phụ'];
  List<TrafficSignModel> traficSignArray = [];

  Future<void> loadTrafficSignData() async {
    final String response = await rootBundle.loadString('assets/json/trafficSign.json');
    final trafficSigndata = await json.decode(response);
    traficSignArray = List<TrafficSignModel>.from(trafficSigndata["trafficSign"].map((json) => TrafficSignModel.fromJson(json)));
  }

  void onPageChanged(int index) {
    horizontalTab?.animateToIndex(index);
    setState(() {
      currentPage = index + 1;
    });
  }

  void jumToIndex(int index) {
    pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    horizontalTab = HorizontalTab(
      length: trafficSignList.length,
      currentPage: currentPage,
      callback: jumToIndex,
      screenRate: 2,
      title: trafficSignList,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Biển báo'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Container(child: horizontalTab),
          Container(height: 0.5, color: Colors.green,),
          Expanded(
              child: FutureBuilder(
                future: loadTrafficSignData(),
                builder: (context, snapshot) {
                  return Container(
                    color: Colors.white,
                    child: PageView.builder(
                      controller: pageController,
                      itemCount: trafficSignList.length,
                      scrollDirection: Axis.horizontal,
                      onPageChanged: onPageChanged,
                      itemBuilder: (BuildContext context, int index) {
                        List<TrafficSignModel> trafficSign = traficSignArray.where((element) => element.type == index).toList();

                        return TrafficSignPage(type: index, traficSignByTypeArray: trafficSign);
                      },
                    ),
                  );
                },
              )
          )
        ],
      ),
    );
  }
}