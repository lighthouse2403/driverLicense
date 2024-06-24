import 'package:flutter/material.dart';
import 'package:license/_gen/assets.gen.dart';
import 'package:license/common/app_colors.dart';
import 'package:license/common/base/base_app_bar.dart';
import 'package:license/extension/text_extension.dart';
import 'package:license/trafficSign/Model/traffic_sign_model.dart';

class TrafficSignDetail extends StatefulWidget {
  const TrafficSignDetail({super.key, required this.trafficSignModel});

  final TrafficSignModel trafficSignModel;
  @override
  State<TrafficSignDetail> createState() => _TrafficSignDetailState();
}

class _TrafficSignDetailState extends State<TrafficSignDetail> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: 'Biển ${widget.trafficSignModel.name}',
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Align(
            alignment: Alignment.center,
            child: Assets.icon.arrowBack.svg(width: 24, height: 24),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
            color: Colors.white
        ),
        padding: const EdgeInsets.only(left: 16, right: 16, top:  20),
        child: ListView(
          children: [
            Text('Biển ${widget.trafficSignModel.name}').w700().text20().blackColor(),
            Container(
              margin: const EdgeInsets.all(16),
              child: Center(
                child: Image.asset('assets/icon/trafficSign/${widget.trafficSignModel.name}.png', width: 160, height: 160,),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  color: AppColors.mainColor.withOpacity(0.5)
              ),
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.only(left: 10, right: 10, top: 16, bottom: 16),
              child: Text(widget.trafficSignModel.comment).w500().text14().blackColor(),
            )
          ],
        )
      )
    );
  }
}