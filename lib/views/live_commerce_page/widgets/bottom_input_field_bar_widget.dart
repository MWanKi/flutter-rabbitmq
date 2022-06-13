import 'package:dart_amqp/dart_amqp.dart';
import 'package:rabbitmq_chat_flutter/bloc/chat_message_list/chat_message_list_bloc.dart';
import 'package:rabbitmq_chat_flutter/bloc/chat_message_list/events/chat_message_list_event.dart';
import 'package:rabbitmq_chat_flutter/bloc/chat_message_list/models/chat_message_model.dart';
import 'package:rabbitmq_chat_flutter/bloc/chat_message_list/states/chat_message_list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomInputFieldBarWidget extends StatelessWidget {
  const BottomInputFieldBarWidget({
    Key? key,
    required this.textFieldController,
    required this.textFieldFocusNode,
    required this.queueName,
    required this.queue,
  }) : super(key: key);
  final Queue queue;
  final TextEditingController textFieldController;
  final String queueName;
  final FocusNode textFieldFocusNode;

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      children: [
        Flexible(
          child: BlocBuilder<ChatMessageListBloc, ChatMessageListState>(
            builder: (context, state) {
              return TextField(
                autofocus: false,
                focusNode: textFieldFocusNode,
                controller: textFieldController,
                onSubmitted: (value) {
                  context.read<ChatMessageListBloc>().add(
                        SendMessageEvent(
                          message: ChatMessageModel(
                            chatMessage: value,
                            senderName: "ㅇㅇㅇ님",
                          ),
                          queueName: queueName,
                        ),
                      );
                  textFieldController.clear();
                  textFieldFocusNode.requestFocus();

                  // try {
                  //   queue.publish(value);
                  //   textFieldController.clear();
                  //   textFieldFocusNode.requestFocus();
                  // } catch (e) {
                  //   // 방송 스트리밍이 종료된 경우
                  //   Fluttertoast.showToast(
                  //       msg: "방송이 종료되었습니다.",
                  //       toastLength: Toast.LENGTH_SHORT,
                  //       gravity: ToastGravity.CENTER,
                  //       timeInSecForIosWeb: 1,
                  //       backgroundColor: Colors.red,
                  //       textColor: Colors.white,
                  //       fontSize: 16.0);
                  //   Navigator.of(context).pop();
                  // }
                },
                cursorColor: const Color(0XFFFFFFFF),
                style: const TextStyle(
                  color: Color(0XFFFFFFFF),
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  filled: true,
                  hintStyle: const TextStyle(
                    color: Color(0XFFD5D5D5),
                    fontSize: 14,
                  ),
                  hintText: "메시지를 입력해주세요",
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 1,
                      color: Color(0XFFD5D5D5),
                    ),
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 1,
                      color: Color(0XFFD5D5D5),
                    ),
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 1,
                      color: Color(0XFFFFFFFF),
                    ),
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(width: 16),
        IconButton(
          onPressed: () {},
          padding: const EdgeInsets.all(0),
          visualDensity: VisualDensity.compact,
          iconSize: 32,
          icon: const Icon(
            Icons.favorite_border,
            color: Color(0XFFFFFFFF),
          ),
        ),
      ],
    );
  }
}
