import 'package:equatable/equatable.dart';
import 'package:rabbitmq_chat_flutter/bloc/chat_message_list/models/chat_message_model.dart';

///
/// 라이브 커머스 채팅 Bloc State 상태 종류
///
///
/// * initial : 초기상태
/// * error : 에러 발생
/// * loading : 채팅 큐 연결중
/// * opened : 채팅 큐 연결 완료
/// * closed : 채팅 큐 연결 해제
enum ChateMessageListStatus {
  initial,
  error,
  loading,
  opened,
  closed,
}

///
/// 라이브 커머스 채팅 Bloc State 클래스
///
///
/// * queueName 라이브 커머스 채팅 메시지 큐 이름
class ChatMessageListState extends Equatable {
  const ChatMessageListState({
    this.status = ChateMessageListStatus.initial,
    this.messages = const [],
    this.queueName,
    this.errorMessage = "",
  });

  final ChateMessageListStatus? status;
  final List<ChatMessageModel>? messages;
  final String? queueName;
  final String? errorMessage;

  @override
  List<Object?> get props => [queueName, messages];

  ChatMessageListState copyWith({
    ChateMessageListStatus? status,
    String? queueName,
    List<ChatMessageModel>? messages,
    String? errorMessage,
  }) {
    return ChatMessageListState(
      status: status ?? this.status,
      messages: messages ?? this.messages,
      queueName: queueName ?? this.queueName,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
