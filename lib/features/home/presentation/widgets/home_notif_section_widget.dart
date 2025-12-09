import 'package:flutter/material.dart';

class HomeNotifSectionWidget extends StatelessWidget {

  final double notiInfoCardHeight;

  const HomeNotifSectionWidget({super.key , required this.notiInfoCardHeight});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: notiInfoCardHeight,
      left: 15,
      right: 15,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('การแจ้งเตือนจากระบบ'),
          SizedBox(height: 10,)

        ],
      ),
    );
  }

}
