import 'package:flutter/material.dart';

class TopBackgroundGradientWidget extends StatelessWidget {
  const TopBackgroundGradientWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      top: 0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: const Color(0XFF000000).withOpacity(0.15),
              blurRadius: 50,
              spreadRadius: 50,
            ),
            BoxShadow(
              color: const Color(0XFF000000).withOpacity(0.17),
              blurRadius: 100,
              spreadRadius: 55,
            ),
            BoxShadow(
              color: const Color(0XFF000000).withOpacity(0.19),
              blurRadius: 100,
              spreadRadius: 55,
            )
          ],
        ),
      ),
    );
  }
}
