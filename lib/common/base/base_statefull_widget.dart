import 'package:flutter/material.dart';
import 'package:license/common/component/loading_view.dart';

class BaseStatefulWidget extends StatefulWidget  {
  const BaseStatefulWidget({super.key});

  @override
  State<StatefulWidget> createState() => BaseStatefulState<BaseStatefulWidget>();
}

class BaseStatefulState<T extends StatefulWidget> extends State<T> {
  final LoadingView loadingView = LoadingView();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  PreferredSizeWidget? buildAppBar() {
    return null;
  }

  Widget? buildBody() {
    return null;
  }

  @override
  void dispose() {
    super.dispose();
  }
}

