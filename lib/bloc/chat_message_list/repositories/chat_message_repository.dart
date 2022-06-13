import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rabbitmq_chat_flutter/bloc/chat_message_list/models/chat_message_model.dart';
import 'package:rabbitmq_chat_flutter/bloc/chat_message_list/repositories/chat_message_repository_ab.dart';

class ChatMessageRepository implements ChatMessageRepositoryAb {
  ChatMessageRepository();

  @override
  Future<bool> closeQueue(String queueName) async {
    try {
      var response = await Dio().get(
        'http://172.30.1.83:3000/close_queue',
        queryParameters: {
          "queue_name": queueName,
        },
      );

      if (response.statusCode == 200) {
        log(response.data.toString());
        return true;
      }
    } catch (e) {
      log(e.toString());
    }

    return false;
  }

  @override
  Future<bool> openQueue(String queueName) async {
    bool result = false;
    try {
      var response = await Dio().get(
        'http://172.30.1.83:3000/open_queue',
        queryParameters: {
          "queue_name": queueName,
        },
      );

      if (response.statusCode == 200) {
        result = true;
      }
    } catch (e) {
      log(e.toString());
    }

    return result;
  }

  @override
  Future<bool> sendMessage({
    required ChatMessageModel chatMessage,
    required String queueName,
  }) async {
    try {
      var response = await Dio().get(
        'http://172.30.1.83:3000/send_message',
        queryParameters: {
          "message": chatMessage.chatMessage,
          "queue_name": queueName,
        },
      );
      if (response.statusCode == 200) {
        log(response.data.toString());
        return true;
      }
    } catch (e) {
      log(e.toString());
    }

    return false;
  }
}
