import 'package:extended_image/extended_image.dart';
import 'package:rabbitmq_chat_flutter/common/data/models/live_commerce_program_item.dart';
import 'package:flutter/material.dart';

class LiveStreamingVideoWidget extends StatelessWidget {
  const LiveStreamingVideoWidget(
      {Key? key, required this.liveCommerceProgramItem})
      : super(key: key);

  final LiveCommerceProgramItem liveCommerceProgramItem;
  @override
  Widget build(BuildContext context) {
    return ExtendedImage.network(
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
    );
  }
}
