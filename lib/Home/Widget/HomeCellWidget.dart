import 'package:flutter/material.dart';

class HomeCellWidget extends StatelessWidget {
  const HomeCellWidget({super.key, required this.text, required this.icon});
  final String text;
  final String icon;
  @override
  Widget build(BuildContext context) {
    return InkWell(
            splashColor: Colors.blue,
            onTap: () {},
            child: Container(
                      decoration: const BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                          Center(child: Image.asset(icon, width: 40, height: 40,),), // <-- Icon
                                          const SizedBox(height: 10,),
                                          Text(
                                            text,
                                            style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w600),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                            ),
                  ),
          );
  }
}