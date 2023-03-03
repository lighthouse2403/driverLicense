import 'dart:ffi';

import 'package:flutter/material.dart';
import '../../trafficSign/trafficSIgn.dart';

class HomeCellWidget extends StatelessWidget {
  const HomeCellWidget({super.key, required this.text, required this.icon, required this.type});
  final String text;
  final String icon;
  final int type;

  @override
  Widget build(BuildContext context) {
    return InkWell(
            splashColor: Colors.blue,
            onTap: () {
              gotoDetail(context);
            },
            child: Card(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          color: Colors.white10,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                          Center(child: Image.asset('assets/home/$icon', width: 50, height: 50,),), // <-- Icon
                                          const SizedBox(height: 10,),
                                          Text(
                                            text,
                                            style: const TextStyle(
                                                    color: Colors.green,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w500),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                            ),
                  ),
          );
  }

  void gotoDetail(BuildContext context) {
    switch (type) {
      case 0: {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const TrafficSign()),
        );
      }
      break;
      case 1: {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const TrafficSign()),
        );
      }
      break;
      case 2: {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const TrafficSign()),
        );
      }
      break;
      case 3: {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const TrafficSign()),
        );
      }
      break;
      case 4: {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const TrafficSign()),
        );
      }
      break;
      case 5: {

      }
      break;
    }
  }
}