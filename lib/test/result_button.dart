import 'package:flutter/material.dart';

class ResultButton extends StatelessWidget {
  const ResultButton({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      width: 120,
      height: 40,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          color: Colors.white.withOpacity(0.3)
      ),
      child: const Center(
        child: Text('Xem lại', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),),
      )
    );
  }
}

