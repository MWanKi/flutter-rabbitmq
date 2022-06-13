import 'dart:developer';

import 'package:dart_amqp/dart_amqp.dart';
import 'package:rabbitmq_chat_flutter/bloc/chat_message_list/chat_message_list_bloc.dart';
import 'package:rabbitmq_chat_flutter/bloc/chat_message_list/events/chat_message_list_event.dart';
import 'package:rabbitmq_chat_flutter/bloc/chat_message_list/models/chat_message_model.dart';
import 'package:rabbitmq_chat_flutter/bloc/chat_message_list/states/chat_message_list_state.dart';

import 'package:rabbitmq_chat_flutter/common/data/models/live_commerce_program_item.dart';
import 'package:rabbitmq_chat_flutter/views/live_commerce_page/widgets/bottom_background_gradient_widget.dart';
import 'package:rabbitmq_chat_flutter/views/live_commerce_page/widgets/bottom_input_field_bar_widget.dart';
import 'package:rabbitmq_chat_flutter/views/live_commerce_page/widgets/chat_message_list_widget.dart';
import 'package:rabbitmq_chat_flutter/views/live_commerce_page/widgets/goods_on_streaming_widget.dart';
import 'package:rabbitmq_chat_flutter/views/live_commerce_page/widgets/live_streaming_video_widget.dart';
import 'package:rabbitmq_chat_flutter/views/live_commerce_page/widgets/top_background_gradient_widget.dart';
import 'package:rabbitmq_chat_flutter/views/live_commerce_page/widgets/top_navigator_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LiveCommerceWatchStreamingPage extends StatefulWidget {
  const LiveCommerceWatchStreamingPage({
    Key? key,
    required this.liveCommerceProgramItem,
    required this.messageQueue,
  }) : super(key: key);

  final LiveCommerceProgramItem liveCommerceProgramItem;
  final Queue messageQueue;

  @override
  State<LiveCommerceWatchStreamingPage> createState() =>
      _LiveCommerceWatchStreamingPageState();
}

class _LiveCommerceWatchStreamingPageState
    extends State<LiveCommerceWatchStreamingPage> {
  final TextEditingController textFieldController = TextEditingController();
  final FocusNode textFieldFocusNode = FocusNode();

  /// 음소거 여부
  bool isMuted = false;

  @override
  void initState() {
    // 채팅 큐 연결
    context.read<ChatMessageListBloc>().add(
          OpenQueueEvent(
            queueName: widget.liveCommerceProgramItem.liveCommerceProgramItemId,
          ),
        );

    Future.delayed(const Duration(milliseconds: 300), () {
      // 입장 메시지 추가
      context.read<ChatMessageListBloc>().add(
            ReceivedNewMessageEvent(
              message: ChatMessageModel(
                chatMessage: 'ㅇㅇㅇ님, 환영합니다!\n'
                    '[${widget.liveCommerceProgramItem.goodsOnLiveCommerce.goodsName}] 라이브 특가를 만나보세요!',
                senderName: "[플렉스미]",
              ),
            ),
          );
    });

    // 채팅 메시지 큐 구독
    widget.messageQueue.consume().then(
      (consumer) {
        // 채팅 메시지 리스너
        consumer.listen(
          (AmqpMessage message) {
            log("* New message received: ${message.payloadAsString}");
            context.read<ChatMessageListBloc>().add(
                  ReceivedNewMessageEvent(
                    message: ChatMessageModel(
                      chatMessage: message.payloadAsString,
                      senderName: "ㅇㅇㅇ님",
                    ),
                  ),
                );
          },
        );
      },
    );
    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
    await widget.messageQueue.delete();
  }

  /// 음소거 토글
  void changeMuteState() {
    setState(() {
      isMuted = !isMuted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<ChatMessageListBloc>().add(
              CloseQueueEvent(
                queueName:
                    widget.liveCommerceProgramItem.liveCommerceProgramItemId,
              ),
            );
        return true;
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: Stack(
            children: [
              Semantics(
                label: '스트리밍 동영상',
                child: LiveStreamingVideoWidget(
                  liveCommerceProgramItem: widget.liveCommerceProgramItem,
                ),
              ),
              const TopBackgroundGradientWidget(),
              const BottomBackgroundGradientWidget(),
              Positioned(
                top: 40,
                left: 16,
                right: 8,
                child: Semantics(
                  label: "화면 상단 스트리밍 타이틀 및 메뉴바",
                  child: TopNavigatorBarWidget(
                    liveCommerceProgramItem: widget.liveCommerceProgramItem,
                    isMuted: isMuted,
                    changeMuteState: () => changeMuteState(),
                  ),
                ),
              ),
              Positioned(
                left: 16,
                right: 16,
                bottom: MediaQuery.of(context).viewPadding.bottom,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocBuilder<ChatMessageListBloc, ChatMessageListState>(
                      builder: (context, state) {
                        if (state.status == ChateMessageListStatus.initial) {
                          return Semantics(
                            label: "채팅 리스트 큐 연결중 메시지",
                            child: const Text(
                              "오픈채팅에 연결중입니다.",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          );
                        }

                        if (state.status == ChateMessageListStatus.error) {
                          return Semantics(
                            label: "채팅 리스트 로딩 실패 에러 메시지",
                            child: Text(
                              state.errorMessage!,
                              style: const TextStyle(
                                color: Colors.red,
                              ),
                            ),
                          );
                        }

                        if (state.status == ChateMessageListStatus.opened) {
                          return Semantics(
                            label: "채팅 리스트 영역",
                            child: ChatMessageListWidget(
                              messages: state.messages!,
                            ),
                          );
                        }

                        return const SizedBox();
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Semantics(
                      label: "방송중인 상품 영역",
                      child: GoodsOnStreamingWidget(
                        liveCommerceProgramItem: widget.liveCommerceProgramItem,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Semantics(
                      label: "채팅 입력 영역",
                      child: BottomInputFieldBarWidget(
                        textFieldController: textFieldController,
                        textFieldFocusNode: textFieldFocusNode,
                        queueName: widget
                            .liveCommerceProgramItem.liveCommerceProgramItemId,
                        queue: widget.messageQueue,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
