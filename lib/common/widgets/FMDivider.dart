import 'package:flutter/material.dart';

class FMVerticalDivder extends StatelessWidget {
  const FMVerticalDivder({
    Key? key,
    required this.height,
    required this.color,
  }) : super(key: key);
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: height,
      ),
    );
  }
}
