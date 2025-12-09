import 'package:flutter/material.dart';
import 'package:mb_rmuti_profile_demo/features/home/presentation/widgets/home_notif_section_widget.dart';
import 'package:mb_rmuti_profile_demo/features/home/presentation/widgets/home_side_banner_widget.dart';
import 'package:mb_rmuti_profile_demo/features/home/presentation/widgets/home_user_profile_card_widget.dart';

class HomeContentWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // กำหนดความสูงของพื้นที่สีเทาเข้ม (Banner Area)
        final double bannerHeightRatio = 0.40;
        final double bannerHeight = constraints.maxHeight * bannerHeightRatio;

        // กำหนดความสูงของพื้นที่ข้อมูล (Info Card Area)
        const double infoCardHeight = 130.0;
        // ระยะห่างรวมที่ต้องการให้ Info Card อยู่เหนือ Banner (Overlap)
        const double overlapDistance = 40.0; // กำหนดระยะ Overlap ที่ต้องการ

        final double notiInfoCardHeight = ( bannerHeight - overlapDistance ) + 155.0;

        return Scaffold(
          body: Container(
            color: const Color(0xFFF7F7F7), // พื้นหลังหลัก
            // ใช้ Stack เพื่อให้ Info Card วางซ้อนและ Overlap กับ Banner ได้
            child: Stack(
              clipBehavior:
                  Clip.none, // อนุญาตให้ Widget ออกนอกขอบเขตของ Stack ได้
              children: [

                // 1. พื้นที่ Banner (สีเทาเข้ม) - ต้องอยู่ด้านล่างสุดใน Stack
                HomeSideBannerWidget(bannerHeight: bannerHeight),

                // 2. พื้นที่สำหรับ Info Card (สีเทาอ่อน) - ต้องอยู่ด้านบน
                HomeUserProfileCardWidget( overlapSize : bannerHeight - overlapDistance, infoCardHeight: infoCardHeight,),

                // 3. พื้นที่สำหรับ การแจ้งเตือน
                HomeNotifSectionWidget(notiInfoCardHeight : notiInfoCardHeight)

              ],
            ),
          ),
        );
      },
    );
  }
}
