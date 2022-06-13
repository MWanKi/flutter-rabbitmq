///
/// 라이브 커머스에 보내는 채팅 메시지 클래스
///
///
/// * chatMessage 채팅 메시지 내용
/// * senderName 채팅 보내는 사람 이름
class ChatMessageModel {
  const ChatMessageModel({
    required this.chatMessage,
    required this.senderName,
  });

  final String senderName;
  final String chatMessage;
}
