import 'package:equatable/equatable.dart';
import 'package:rabbitmq_chat_flutter/bloc/chat_message_list/models/chat_message_model.dart';

///
/// 라이브 커머스 채팅 Bloc 패턴 이벤트 클래스
///
///
/// * @CloseQueueEvent : 시청중인 라이브 커머스 스트리밍 채널 메시지 큐 닫기
/// * @OpenQueueEvent : 시청하려는 라이브 커머스 스트리밍 채널 메시지 큐 열기
/// * @SendMessageEvent : 실시간 채팅 메시지 보내기
/// * @ReceivedNewMessageEvent  : 실시간 채팅 메시지 수신
abstract class ChateMessageListEvent extends Equatable {}

/// 시청중인 라이브 커머스 스트리밍 채널 메시지 큐 닫기
class CloseQueueEvent extends ChateMessageListEvent {
  final String queueName;

  @override
  List<Object?> get props => [];

  CloseQueueEvent({
    required this.queueName,
  });
}

/// 시청하려는 라이브 커머스 스트리밍 채널 메시지 큐 열기
class OpenQueueEvent extends ChateMessageListEvent {
  final String queueName;

  @override
  List<Object?> get props => [queueName];

  OpenQueueEvent({
    required this.queueName,
  });
}

/// 실시간 채팅 메시지 보내기
class SendMessageEvent extends ChateMessageListEvent {
  final ChatMessageModel message;
  final String queueName;

  @override
  List<Object?> get props => [message, queueName];

  SendMessageEvent({
    required this.message,
    required this.queueName,
  });
}

/// 실시간 채팅 메시지 수신
class ReceivedNewMessageEvent extends ChateMessageListEvent {
  final ChatMessageModel message;

  @override
  List<Object?> get props => [message];

  ReceivedNewMessageEvent({
    required this.message,
  });
}
