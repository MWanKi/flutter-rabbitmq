import 'package:rabbitmq_chat_flutter/common/data/models/goods_on_live_commerce.dart';

///
/// 라이브 커머스 방송 프로그램 클래스
///
///
/// * liveCommerceProgramItemId 라이브 커머스 방송 id
/// * goodsOnLiveCommerce 라이브 커머스 방송중인 상품
/// * liveCommerceVideoThumbnailUrl 라이브 커머스 스트리밍 썸네일 링크
/// * liveCommerceVideoStreamingUrl 라이브 커머스 스트리밍 링크
/// * broadCastTitle 방송 제목
/// * streamerName 방송 스트리머 이름
/// * viewCount 조회수
class LiveCommerceProgramItem {
  const LiveCommerceProgramItem({
    required this.liveCommerceProgramItemId,
    required this.goodsOnLiveCommerce,
    required this.liveCommerceVideoThumbnailUrl,
    required this.liveCommerceVideoStreamingUrl,
    required this.broadCastTitle,
    required this.streamerName,
    required this.viewCount,
  });

  final String liveCommerceProgramItemId;
  final GoodsOnLiveCommerce goodsOnLiveCommerce;
  final String liveCommerceVideoThumbnailUrl;
  final String liveCommerceVideoStreamingUrl;
  final String broadCastTitle;
  final String streamerName;
  final int viewCount;
}
