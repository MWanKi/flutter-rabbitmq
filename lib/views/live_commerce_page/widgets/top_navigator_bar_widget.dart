import 'package:rabbitmq_chat_flutter/common/data/models/live_commerce_program_item.dart';
import 'package:flutter/material.dart';
import 'package:money_formatter/money_formatter.dart';

class TopNavigatorBarWidget extends StatelessWidget {
  const TopNavigatorBarWidget({
    Key? key,
    required this.liveCommerceProgramItem,
    required this.isMuted,
    required this.changeMuteState,
  }) : super(key: key);

  final LiveCommerceProgramItem liveCommerceProgramItem;
  final bool isMuted;
  final Function changeMuteState;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              liveCommerceProgramItem.broadCastTitle,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0XFFFFFFFF),
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {
                changeMuteState();
              },
              visualDensity: VisualDensity.compact,
              padding: const EdgeInsets.all(0),
              icon: Icon(
                isMuted ? Icons.volume_off : Icons.volume_up,
                size: 24,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              padding: const EdgeInsets.all(0),
              visualDensity: VisualDensity.compact,
              icon: const Icon(
                Icons.close,
                size: 24,
                color: Colors.white,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              liveCommerceProgramItem.streamerName,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0XFFF5F5F5),
              ),
            ),
            Container(
              width: 3,
              height: 3,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: const Color(0XFFF5F5F5),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
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
                color: Color(0XFFF5F5F5),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(8),
            visualDensity: VisualDensity.compact,
            primary: const Color(0XFFFF0000),
            elevation: 0,
          ),
          onPressed: () {},
          child: const Text(
            "LIVE",
            style: TextStyle(
              color: Color(0XFFFFFFFF),
            ),
          ),
        )
      ],
    );
  }
}
