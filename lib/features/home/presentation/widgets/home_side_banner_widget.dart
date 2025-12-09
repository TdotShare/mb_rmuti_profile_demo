import 'package:flutter/material.dart';

class HomeSideBannerWidget extends StatelessWidget {

  final double bannerHeight;

  const HomeSideBannerWidget(
      {
        super.key,
        required this.bannerHeight
      }
  );

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: double.infinity,
      height: bannerHeight,
      decoration: const ShapeDecoration(
        color: Color(0xFFBFB7B7),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
        ),
      ),
      alignment: Alignment.center,
      child: const Text(
        'side banner',
        style: TextStyle(
          color: Colors.black,
          fontSize: 40,
        ),
      ),
    );
  }
}
