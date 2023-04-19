import 'package:flutter/material.dart';
import 'package:license/more/more_model.dart';

class MoreRow extends StatelessWidget {
  MoreRow({required this.moreModel});

  MoreModel moreModel;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.more),
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
      )
    );
  }
}