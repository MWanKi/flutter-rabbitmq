import 'package:dart_amqp/dart_amqp.dart' as amqp;
import 'package:extended_image/extended_image.dart';
import 'package:rabbitmq_chat_flutter/bloc/chat_message_list/chat_message_list_bloc.dart';
import 'package:rabbitmq_chat_flutter/bloc/chat_message_list/repositories/chat_message_repository.dart';
import 'package:rabbitmq_chat_flutter/common/data/models/live_commerce_program_item.dart';
import 'package:rabbitmq_chat_flutter/common/widgets/FMDivider.dart';
import 'package:rabbitmq_chat_flutter/views/live_commerce_page/live_commerce_watch_streaming_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:money_formatter/money_formatter.dart';

class LiveCommerceProgramItemWidget extends StatelessWidget {
  const LiveCommerceProgramItemWidget(
      {Key? key, required this.liveCommerceProgramItem})
      : super(key: key);

  final LiveCommerceProgramItem liveCommerceProgramItem;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // RabbitMQ 채팅 메시지 클라이언트 초기화
        amqp.Client rabbitMQClient = amqp.Client();
        rabbitMQClient.channel().then((amqp.Channel channel) {
          channel
              .queue(
            liveCommerceProgramItem.liveCommerceProgramItemId,
            autoDelete: true,
          )
              .then((newMessageQueue) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider.value(
                  value: ChatMessageListBloc(
                    chatMessageRepository: ChatMessageRepository(),
                  ),
                  child: LiveCommerceWatchStreamingPage(
                    liveCommerceProgramItem: liveCommerceProgramItem,
                    messageQueue: newMessageQueue,
                  ),
                ),
              ),
            );
          });
        }).catchError((e) {
          // 방송 스트리밍이 종료된 경우
          Fluttertoast.showToast(
              msg: "이미 종료된 방송입니다.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        });
      },
      child: Container(
        color: const Color(0XFFD5D5D5),
        height: 300,
        child: Stack(
          children: [
            Semantics(
              label: '스트리밍 커버 이미지',
              child: ExtendedImage.network(
                liveCommerceProgramItem.liveCommerceVideoThumbnailUrl,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                clearMemoryCacheWhenDispose: true,
                loadStateChanged: (ExtendedImageState state) {
                  switch (state.extendedImageLoadState) {
                    case LoadState.loading:
                      break;
                    case LoadState.completed:
                      PaintingBinding.instance.imageCache.clear();
                      return ExtendedRawImage(
                        image: state.extendedImageInfo?.image,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        fit: BoxFit.cover,
                      );
                    case LoadState.failed:
                      break;
                  }
                  return const SizedBox();
                },
              ),
            ),
            Semantics(
              label: '스트리밍 커버 이미지 검은 필터 오버레이',
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: const Material(
                  color: Color.fromRGBO(0, 0, 0, 0.2),
                ),
              ),
            ),
            Positioned(
              left: 10,
              right: 10,
              bottom: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Semantics(
                    label: '상품 이미지',
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(17),
                      child: ExtendedImage.network(
                        liveCommerceProgramItem
                            .goodsOnLiveCommerce.goodsThumbnailUrl,
                        width: 34,
                        height: 34,
                        clearMemoryCacheWhenDispose: true,
                        loadStateChanged: (ExtendedImageState state) {
                          switch (state.extendedImageLoadState) {
                            case LoadState.loading:
                              break;
                            case LoadState.completed:
                              PaintingBinding.instance.imageCache.clear();
                              return ExtendedRawImage(
                                image: state.extendedImageInfo?.image,
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                fit: BoxFit.cover,
                              );
                            case LoadState.failed:
                              break;
                          }
                          return const SizedBox();
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    liveCommerceProgramItem.goodsOnLiveCommerce.goodsName,
                    style: const TextStyle(
                      color: Color(0XFFDDDDDD),
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${MoneyFormatter(
                      settings: MoneyFormatterSettings(fractionDigits: 0),
                      amount: liveCommerceProgramItem
                              .goodsOnLiveCommerce.goodsPrice *
                          1.0,
                    ).output.nonSymbol}원',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const FMVerticalDivder(
                    height: 1,
                    color: Color.fromRGBO(255, 255, 255, .15),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Text(
                        liveCommerceProgramItem.streamerName,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0XFFDDDDDD),
                        ),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.people,
                        color: Colors.white,
                        size: 12,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(
                        MoneyFormatter(
                          settings: MoneyFormatterSettings(fractionDigits: 0),
                          amount: liveCommerceProgramItem.viewCount * 1.0,
                        ).output.nonSymbol,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0XFFDDDDDD),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
