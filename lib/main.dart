import 'package:rabbitmq_chat_flutter/common/data/models/goods_on_live_commerce.dart';
import 'package:rabbitmq_chat_flutter/common/data/models/live_commerce_program_item.dart';
import 'package:rabbitmq_chat_flutter/views/live_commerce_page/widgets/live_commerce_program_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'rabbitmq Chat Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<LiveCommerceProgramItem> liveCommerceProgramItemList = [
    LiveCommerceProgramItem(
        liveCommerceProgramItemId: "1",
        goodsOnLiveCommerce: GoodsOnLiveCommerce(
            goodsId: "1",
            goodsName: "18FW 루이비통 모노그램 ...",
            goodsPrice: 3250000,
            goodsThumbnailUrl:
                "https://wwws.dior.com/couture/ecommerce/media/catalog/product/cache/1/cover_image_1/870x580/17f82f742ffe127f42dca9de82fb58b1/Z/p/1589293313_013C218A3226_C900_E01_ZHC.jpg?imwidth=870"),
        liveCommerceVideoThumbnailUrl:
            "http://m.nobstyle.co.kr/web/product/big/20191126/d31d008b8baa6ad11d19cd664f229175.jpg",
        liveCommerceVideoStreamingUrl: "",
        broadCastTitle: "인생 정장 한정수량 달리세요~",
        streamerName: "서울언니",
        viewCount: 3351),
    LiveCommerceProgramItem(
        liveCommerceProgramItemId: "2",
        goodsOnLiveCommerce: GoodsOnLiveCommerce(
            goodsId: "2",
            goodsName: "18FW 루이비통 모노그램 ...",
            goodsPrice: 3250000,
            goodsThumbnailUrl:
                "https://wwws.dior.com/couture/ecommerce/media/catalog/product/cache/1/cover_image_1/870x580/17f82f742ffe127f42dca9de82fb58b1/Z/p/1589293313_013C218A3226_C900_E01_ZHC.jpg?imwidth=870"),
        liveCommerceVideoThumbnailUrl:
            "https://i.pinimg.com/originals/31/38/90/31389090648e486010c3f67133383001.jpg",
        liveCommerceVideoStreamingUrl: "",
        broadCastTitle: "인생 정장 한정수량 달리세요~",
        streamerName: "서울언니",
        viewCount: 3351),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          widget.title,
        ),
      ),
      body: MasonryGridView.count(
        itemCount: liveCommerceProgramItemList.length + 1,
        padding: const EdgeInsets.all(16),
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Container(
              height: 200,
              color: Colors.red,
              alignment: Alignment.center,
              child: const Text(
                "이벤트 배너",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            );
          }

          index--;

          return LiveCommerceProgramItemWidget(
            liveCommerceProgramItem: liveCommerceProgramItemList[index],
          );
        },
      ),
    );
  }
}
