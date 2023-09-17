import 'package:flutter/cupertino.dart';
import 'package:license/common/base/base_statefull_widget.dart';
import 'package:license/firebase/firebase_chat.dart';
import 'package:license/more/items/chat/thread_row.dart';
import 'package:license/more/model/thread_model.dart';

class ThreadList extends BaseStatefulWidget {
  const ThreadList({super.key,});

  @override
  ThreadListState createState() => ThreadListState();
}

class ThreadListState extends BaseStatefulState<BaseStatefulWidget> {
  final ScrollController _controller = ScrollController();
  final double _endReachedThreshold = 30;
  bool _loading = false;
  List<ThreadModel> threads = [];

  @override
  void initState() {
    _controller.addListener(_onScroll);
    loadData();
    
    print('ThreadList ${threads.firstOrNull?.title ?? ''}');
    super.initState();
  }

  Future loadData() async {
    threads = await FirebaseChat.instance.loadThread();
    print('number of thread: ${threads.length}');
  }

  void _onScroll() {
    if (!_controller.hasClients || _loading) return;
    final shouldReload = _controller.position.extentAfter < _endReachedThreshold;
    if (shouldReload && !_loading) {
      _loading = true;
    }
  }



}
