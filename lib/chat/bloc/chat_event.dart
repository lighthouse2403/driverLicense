import 'package:equatable/equatable.dart';
import 'package:license/more/model/thread_model.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();
}

class LoadThreads extends ChatEvent {

  const LoadThreads();

  @override
  List<Object?> get props => [];
}

class LoadComment extends ChatEvent {
  String threadId;
  LoadComment(this.threadId);

  @override
  List<Object?> get props => [threadId];
}

class SendComment extends ChatEvent {
  ThreadModel thread;
  String comment;
  SendComment(this.thread, this.comment);

  @override
  List<Object?> get props => [thread, comment];
}