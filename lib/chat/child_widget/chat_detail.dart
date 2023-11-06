import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:license/chat/bloc/chat_bloc.dart';
import 'package:license/chat/bloc/chat_event.dart';
import 'package:license/chat/bloc/chat_state.dart';
import 'package:license/chat/child_widget/comment_row.dart';
import 'package:license/chat/child_widget/new_comment.dart';
import 'package:license/chat/comment_model.dart';
import 'package:license/common/base/base_app_bar.dart';
import 'package:license/common/base/base_statefull_widget.dart';
import 'package:license/extension/text_extension.dart';
import 'package:license/firebase/firebase_chat.dart';
import 'package:license/more/items/chat/thread_row.dart';
import 'package:license/more/model/thread_model.dart';

class ChatDetail extends BaseStatefulWidget {
  ChatDetail({super.key, required this.thread});

  ThreadModel thread;

  @override
  State<ChatDetail> createState() => _ChatState();
}

class _ChatState extends BaseStatefulState<ChatDetail> {

  final ScrollController _controller = ScrollController();

  final double _endReachedThreshold = 30;
  bool _loading = false;
  List<CommentModel> comments = [];
  ChatBloc chatBloc = ChatBloc();

  @override
  void initState() {
    super.initState();

    _controller.addListener(_onScroll);
    chatBloc.add(LoadComment(widget.thread.threadId));
  }

  void _onScroll() {
    if (!_controller.hasClients || _loading) return;

    final shouldReload = _controller.position.extentAfter < _endReachedThreshold;
    bool isNotFull = comments.length >= FirebaseChat.instance.commentLimit;
    if (shouldReload && !_loading && isNotFull) {
      _loading = true;
      chatBloc.add(LoadComment(widget.thread.threadId));
    }
  }

  void addNewThread(int index) {
  }

  @override
  PreferredSizeWidget? buildAppBar() {
    return BaseAppBar(title: widget.thread.title ?? '');
  }

  @override
  Widget? buildBody() {
    _loading = false;
    return BlocProvider(
        create: (context) => chatBloc,
        child: BlocListener<ChatBloc, ChatState> (
            listener: (context, state) {
              if (state is LoadingState) {
                _loading = true;
                loadingView.show(context);
                return;
              }

              if (state is LoadingCommentsSuccessfulState) {
                setState(() {
                  _loading = false;
                  comments = state.comments;
                });
                loadingView.hide();
              }
            },
            child: SafeArea(
                child: Column(
                  children: [
                    ThreadRow(thread: widget.thread),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      child: Text('Binh luận').w600().text15().blackColor(),
                    ),
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
                                      : const CupertinoActivityIndicator(radius: 12.0, color: CupertinoColors.inactiveGray)
                              ),
                            )
                          ],
                        )
                    ),
                    NewComment(
                        thread: widget.thread,
                        sentComment: _refresh
                    )
                  ],
                )
            )
        )
    );
  }

  Future<void> _refresh() async {
    FirebaseChat.instance.commentLimit = 0;
    chatBloc.add(LoadComment(widget.thread.threadId));
  }
}