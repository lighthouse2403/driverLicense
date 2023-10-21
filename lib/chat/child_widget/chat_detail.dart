import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:license/chat/child_widget/comment_row.dart';
import 'package:license/chat/comment_model.dart';
import 'package:license/common/base/base_statefull_widget.dart';
import 'package:license/firebase/firebase_chat.dart';
import 'package:license/chat/child_widget/new_thread.dart';
import 'package:license/more/items/chat/thread_row.dart';
import 'package:license/more/model/thread_model.dart';
import 'package:license/theory/comment_row.dart';

class ChatDetail extends BaseStatefulWidget {
  ChatDetail({super.key, required this.thread});

  ThreadModel thread;

  @override
  State<ChatDetail> createState() => _ChatState();
}

class _ChatState extends BaseStatefulState<ChatDetail> {

  final ScrollController _controller = ScrollController();
  TextEditingController textController = TextEditingController();

  final double _endReachedThreshold = 30;
  bool _loading = false;
  List<CommentModel> comments = [];

  @override
  void initState() {
    _controller.addListener(_onScroll);
    loadData();
    super.initState();
  }

  Future loadData() async {
    comments = await FirebaseChat.instance.loadComment(widget.thread.threadId);
    setState(() {
      _loading = false;
    });
  }

  void _onScroll() {
    if (!_controller.hasClients || _loading) return;

    final shouldReload = _controller.position.extentAfter < _endReachedThreshold;
    bool isNotFull = comments.length >= FirebaseChat.instance.commentLimit;
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
      title: Text(
        widget.thread.title ?? '',
        style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: Colors.white,
          overflow: TextOverflow.ellipsis
        ),
      ),
      backgroundColor: Colors.green,
    );
  }

  @override
  Widget? buildBody() {
    _loading = false;
    return SafeArea(
        child: Column(
          children: [
            Expanded(
                child: CustomScrollView(
                  controller: _controller,
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  slivers: [
                    CupertinoSliverRefreshControl(
                      onRefresh: _refresh,
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        color: Colors.green,
                        child: ThreadRow(thread: widget.thread),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return ChatRow(comment: comments[index]);
                      },
                        childCount: comments.length,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                          height: 30,
                          child: FirebaseChat.instance.commentLimit > comments.length
                              ? Container()
                              : CupertinoActivityIndicator(
                              radius: 12.0, color: CupertinoColors.inactiveGray
                          )
                      ),
                    )
                  ],
                )
            ),
            Row(
              children: [
                Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: TextField(
                        controller: textController,
                        maxLines: 4,
                        minLines: 1,
                      ),
                    )
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  alignment: Alignment.center,
                  width: 80,
                  height: 60,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        FirebaseChat.instance.addNewComment(widget.thread.threadId, textController.text);
                      });
                    },
                    child: Text(
                      'Gửi', style: TextStyle(fontWeight: FontWeight.w700, color: Colors.green),
                    ),
                  ),
                )
              ],
            )
          ],
        )
    );
  }

  Future<void> _refresh() async {
    FirebaseChat.instance.commentLimit = 0;
    loadData();
  }
}