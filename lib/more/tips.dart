import 'package:flutter/material.dart';
import 'package:license/_gen/assets.gen.dart';
import 'package:license/common/app_colors.dart';
import 'package:license/common/base/base_app_bar.dart';
import 'package:license/more/practice_tips.dart';
import 'package:license/more/theory_tips.dart';

class Tips extends StatefulWidget {
  const Tips({Key? key}) : super(key: key);

  @override
  State<Tips> createState() => _TipsState();
}

class _TipsState extends State<Tips>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  final List<String> tabTitles = [
    'Mẹo thi lý thuyết',
    'Mẹo thực hành',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabTitles.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BaseAppBar(
        title: 'Mẹo',
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Align(
            alignment: Alignment.center,
            child: Assets.icon.arrowBack.svg(width: 24, height: 24),
          ),
        ),
      ),
      body: Column(      // Column
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),       // Tab Bar color change
            child: TabBar(           // TabBar
              controller: _tabController,
              unselectedLabelColor: Colors.black.withOpacity(0.4),
              labelColor: AppColors.mainColor,
              indicatorWeight: 2,
              indicatorColor: AppColors.mainColor,
              indicatorPadding: const EdgeInsets.symmetric(horizontal: 30),
              tabs: tabTitles.map((e) => Tab(
                  child: Text(
                    e,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600
                    ),
                  ))
              ).toList(),
              dividerColor: Colors.transparent,
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                TheoryTips(),
                PracticeTips(),
              ],
            ),
          ),
        ],
      )
    );
  }
}
