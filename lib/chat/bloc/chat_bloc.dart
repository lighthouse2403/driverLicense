import 'package:bloc/bloc.dart';
import 'package:license/chat/bloc/chat_event.dart';
import 'package:license/chat/bloc/chat_state.dart';
import 'package:license/chat/comment_model.dart';
import 'package:license/firebase/firebase_chat.dart';
import 'package:license/more/model/thread_model.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {

  int paging = 100;
  String password = '';
  bool isSavedUserId = false;
  List<ThreadModel> threads = [];

  ChatBloc() : super(const ChatState()) {
    on<LoadThreads>(_loadThreads);
    on<LoadComment>(_loadComment);
    on<SendComment>(_sendComment);

  }

  Future<void> _loadThreads(ChatEvent event, Emitter<ChatState> emit) async {
    try {
      emit(const LoadingState());
      threads = await FirebaseChat.instance.loadThread();
      emit(const LoadingSuccessfulState());
    } catch (error) {
      print(error);
      emit(const LoadingThreadFailState());
    }
  }

  Future<void> _loadComment(LoadComment event, Emitter<ChatState> emit) async {
    try {
      emit(const LoadingState());
      List<CommentModel> comments = await FirebaseChat.instance.loadComment(event.threadId);
      emit(LoadingCommentsSuccessfulState(comments));
    } catch (error) {
      emit(const LoadingThreadFailState());
    }
  }

  Future<void> _sendComment(SendComment event, Emitter<ChatState> emit) async {
    try {
      emit(const LoadingState());
      await FirebaseChat.instance.addNewComment(event.thread, event.comment);
      emit(const SendCommentSuccessful());
    } catch (error) {
      emit(const LoadingThreadFailState());
    }
  }
}
