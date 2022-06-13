///
/// 라이브 커머스 방송중인 상품 클래스
///
///
/// * goodsId 상품 id
/// * goodsName 상품명
/// * goodsPrice 판매가
/// * goodsThumbnailUrl 상품썸네일 링크
class GoodsOnLiveCommerce {
  GoodsOnLiveCommerce({
    required this.goodsId,
    required this.goodsName,
    required this.goodsPrice,
    required this.goodsThumbnailUrl,
  });

  final String goodsId;
  final String goodsName;
  final double goodsPrice;
  final String goodsThumbnailUrl;
}
