import 'package:extended_image/extended_image.dart';
import 'package:rabbitmq_chat_flutter/common/data/models/live_commerce_program_item.dart';
import 'package:flutter/material.dart';
import 'package:money_formatter/money_formatter.dart';

class GoodsOnStreamingWidget extends StatelessWidget {
  const GoodsOnStreamingWidget({
    Key? key,
    required this.liveCommerceProgramItem,
  }) : super(key: key);

  final LiveCommerceProgramItem liveCommerceProgramItem;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Material(
              color: const Color(0XFFFFFFFF),
              child: Row(
                children: [
                  SizedBox(
                    width: 66,
                    height: 66,
                    child: Semantics(
                      label: '방송중인 상품 썸네일 이미지',
                      child: ExtendedImage.network(
                        liveCommerceProgramItem
                            .goodsOnLiveCommerce.goodsThumbnailUrl,
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
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 32,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          liveCommerceProgramItem.goodsOnLiveCommerce.goodsName,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              '${MoneyFormatter(
                                settings:
                                    MoneyFormatterSettings(fractionDigits: 0),
                                amount: liveCommerceProgramItem
                                        .goodsOnLiveCommerce.goodsPrice *
                                    1.0,
                              ).output.nonSymbol}원',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0XFFFF3200),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Material(
                              color: const Color(0XFFFF3200).withOpacity(0.1),
                              child: const Padding(
                                padding: EdgeInsets.only(
                                  top: 4,
                                  bottom: 3,
                                  left: 6,
                                  right: 6,
                                ),
                                child: Text(
                                  '라이브가',
                                  style: TextStyle(
                                    fontSize: 9,
                                    color: Color(0XFFFF3200),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
