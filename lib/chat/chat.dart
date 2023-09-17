import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:license/common/base/base_statefull_widget.dart';
import 'package:license/firebase/firebase_chat.dart';
import 'package:license/more/items/chat/new_thread.dart';
import 'package:license/more/items/chat/thread_row.dart';
import 'package:license/more/model/thread_model.dart';
import 'package:license/test/model/test_model.dart';

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
  }

  void _onScroll() {
    if (!_controller.hasClients || _loading) return;
    final shouldReload = _controller.position.extentAfter < _endReachedThreshold;
    if (shouldReload && !_loading) {
      _loading = true;
    }
  }

  void addNewThread(int index) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const NewThread())
    ).then(onGoBack);
  }

  onGoBack(dynamic value) {
    setState(() {});
  }

  @override
  PreferredSizeWidget? buildAppBar() {
    // TODO: implement buildAppBar
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
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NewThread())
              );
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
            return ThreadRow(thread: threads[index]);
          },
            childCount: threads.length,
          ),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 30,
            child: CupertinoActivityIndicator(
                radius: 12.0, color: CupertinoColors.inactiveGray
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _refresh() async {
    _loading = true;
  }
}