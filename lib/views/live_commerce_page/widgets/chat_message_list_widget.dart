import 'package:rabbitmq_chat_flutter/bloc/chat_message_list/models/chat_message_model.dart';
import 'package:flutter/material.dart';

class ChatMessageListWidget extends StatelessWidget {
  const ChatMessageListWidget({
    Key? key,
    required this.messages,
  }) : super(key: key);

  final List<ChatMessageModel> messages;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.center,
          colors: <Color>[Colors.transparent, Colors.white],
        ).createShader(bounds);
      },
      child: Container(
        alignment: Alignment.bottomCenter,
        width: MediaQuery.of(context).size.width * .75,
        height: MediaQuery.of(context).size.height / 3,
        child: ListView.builder(
          padding: const EdgeInsets.all(0),
          itemCount: messages.length,
          reverse: true,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding(
              key: Key("message$index"),
              padding: const EdgeInsets.symmetric(
                vertical: 5,
              ),
              child: Flex(
                crossAxisAlignment: CrossAxisAlignment.start,
                direction: Axis.horizontal,
                children: [
                  Text(
                    messages[index].senderName,
                    style: const TextStyle(
                      color: Color(0XFFA5A5A5),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Flexible(
                    child: Text(
                      messages[index].chatMessage,
                      style: const TextStyle(
                        color: Color(0XFFFFFFFF),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
