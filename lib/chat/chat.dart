import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:license/chat/child_widget/chat_detail.dart';
import 'package:license/common/base/base_statefull_widget.dart';
import 'package:license/firebase/firebase_chat.dart';
import 'package:license/chat/child_widget/new_thread.dart';
import 'package:license/more/items/chat/thread_row.dart';
import 'package:license/more/model/thread_model.dart';

class Chat extends BaseStatefulWidget {
  const Chat({super.key});
  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends BaseStatefulState<Chat> {
  List<ThreadModel> threads = [];
  final ScrollController _controller = ScrollController();
  final double _endReachedThreshold = 30;
  bool _loading = false;

  @override
  void initState() {
    _controller.addListener(_onScroll);
    loadData();
    super.initState();
  }

  Future loadData() async {
    threads = await FirebaseChat.instance.loadThread();
    setState(() {
      _loading = false;
    });
  }

  void _onScroll() {
    if (!_controller.hasClients || _loading) return;

    final shouldReload = _controller.position.extentAfter < _endReachedThreshold;
    bool isNotFull = threads.length >= FirebaseChat.instance.threadLimit;
    if (shouldReload && !_loading && isNotFull) {
      _loading = true;
      loadData();
    }
  }

  void addNewThread(int index) {
  }

  @override
  PreferredSizeWidget? buildAppBar() {
    return AppBar(
      title: const Text(
        'Giao lưu',
        style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: Colors.white
        ),
      ),
      backgroundColor: Colors.green,
      actions: [
        TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const NewThread())).then((res) => loadData());
            },
            child: const Text(
              'Thêm mới',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Colors.white
              ),
            )
        )
      ],
    );
  }

  @override
  Widget? buildBody() {
    _loading = false;
    return CustomScrollView(
      controller: _controller,
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      slivers: [
        CupertinoSliverRefreshControl(
          onRefresh: _refresh,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ChatDetail(thread: threads[index]))).then((res) => loadData());
              },
              child: ThreadRow(thread: threads[index]),
            );
          },
            childCount: threads.length,
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 30,
            child: FirebaseChat.instance.threadLimit > threads.length
                ? Container()
                : CupertinoActivityIndicator(
                radius: 12.0, color: CupertinoColors.inactiveGray
            )
          ),
        )
      ],
    );
  }

  Future<void> _refresh() async {
    FirebaseChat.instance.threadLimit = 0;
    loadData();
  }
}