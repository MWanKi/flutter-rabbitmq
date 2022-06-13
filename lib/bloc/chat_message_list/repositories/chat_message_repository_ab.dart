import 'package:rabbitmq_chat_flutter/bloc/chat_message_list/models/chat_message_model.dart';

///
/// 라이브 커머스 채팅 관련 http 통신용 리포지토리
///
///
/// * @openQueue : 시청중인 라이브 커머스 스트리밍 채널 메시지 큐 닫기
/// * @closeQueue : 시청하려는 라이브 커머스 스트리밍 채널 메시지 큐 열기
/// * @sendMessage : 실시간 채팅 메시지 보내기
abstract class ChatMessageRepositoryAb {
  Future<bool> openQueue(String queueName);
  Future<bool> closeQueue(String queueName);
  Future<bool> sendMessage({
    required ChatMessageModel chatMessage,
    required String queueName,
  });
}
