import 'package:flutter/material.dart';
import 'package:license/more/more_model.dart';

class MoreRow extends StatelessWidget {
  MoreRow({super.key, required this.moreModel});

  MoreModel moreModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/icon/home/${moreModel.icon}.png', width: 40, height: 40,),
          const SizedBox(height: 10),
          Text(
            moreModel.name,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black
            ),
          )
        ],
      ),
    );
  }
}