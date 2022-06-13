import 'dart:developer';

import 'package:rabbitmq_chat_flutter/bloc/chat_message_list/events/chat_message_list_event.dart';
import 'package:rabbitmq_chat_flutter/bloc/chat_message_list/models/chat_message_model.dart';
import 'package:rabbitmq_chat_flutter/bloc/chat_message_list/repositories/chat_message_repository.dart';
import 'package:rabbitmq_chat_flutter/bloc/chat_message_list/states/chat_message_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatMessageListBloc
    extends Bloc<ChateMessageListEvent, ChatMessageListState> {
  final ChatMessageRepository chatMessageRepository;

  ChatMessageListBloc({required this.chatMessageRepository})
      : super(const ChatMessageListState()) {
    on<CloseQueueEvent>(_mapCloseQueueEventToState);
    on<OpenQueueEvent>(_mapOpenQueueEventToState);
    on<SendMessageEvent>(_mapSendMessageEventToState);
    on<ReceivedNewMessageEvent>(_mapReceivedNewMessageEventToState);
  }

  void _mapCloseQueueEventToState(
    CloseQueueEvent event,
    Emitter<ChatMessageListState> emit,
  ) async {
    final isClosed = await chatMessageRepository.closeQueue(event.queueName);

    if (isClosed) {
      emit(
        state.copyWith(queueName: event.queueName),
      );
    } else {
      emit(
        state.copyWith(
          status: ChateMessageListStatus.error,
          errorMessage: "* 스트리밍 채널 채팅방 연결 종료에 실패했습니다.",
        ),
      );
    }
  }

  void _mapOpenQueueEventToState(
    OpenQueueEvent event,
    Emitter<ChatMessageListState> emit,
  ) async {
    try {
      final isConnected =
          await chatMessageRepository.openQueue(event.queueName);

      if (isConnected) {
        emit(
          state.copyWith(
            messages: [],
            status: ChateMessageListStatus.opened,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: ChateMessageListStatus.error,
            errorMessage: "* 스트리밍 채널 채팅방 연결에 실패했습니다.\n다시 접속해주세요.",
          ),
        );
      }
    } catch (e) {
      log(e.toString());
      emit(
        state.copyWith(
          status: ChateMessageListStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void _mapSendMessageEventToState(
    SendMessageEvent event,
    Emitter<ChatMessageListState> emit,
  ) async {
    try {
      final isSuccess = await chatMessageRepository.sendMessage(
        chatMessage: event.message,
        queueName: event.queueName,
      );

      if (!isSuccess) {
        log("* 메시지 전송에 실패했습니다.");
      }
    } catch (e) {
      log(e.toString());
    }
  }

  void _mapReceivedNewMessageEventToState(
    ReceivedNewMessageEvent event,
    Emitter<ChatMessageListState> emit,
  ) async {
    List<ChatMessageModel> messages = List.from(state.messages!);
    messages.insert(0, event.message);

    emit(
      state.copyWith(
        messages: messages,
      ),
    );
  }
}
