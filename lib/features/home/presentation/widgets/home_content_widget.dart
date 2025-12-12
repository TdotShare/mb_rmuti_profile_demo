// lib/features/home/presentation/widgets/home_content_widget.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mb_rmuti_profile_demo/core/store/notifier/user_profile_notifier.dart';
import 'package:mb_rmuti_profile_demo/features/home/data/models/home_user_notification_list_model.dart';
import 'package:mb_rmuti_profile_demo/features/home/home_controller.dart';
import 'package:mb_rmuti_profile_demo/features/home/presentation/widgets/home_notif_section_widget.dart';
import 'package:mb_rmuti_profile_demo/features/home/presentation/widgets/home_side_banner_widget.dart';
import 'package:mb_rmuti_profile_demo/features/home/presentation/widgets/home_user_profile_card_widget.dart';

class HomeContentWidget extends ConsumerWidget {

  late final HomeController _controller = HomeController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ลบ Scaffold ออกไป ใช้ Container ธรรมดาแทน
    final userProfile = ref.watch(userProfileProvider); // <-- ฟังสถานะ

    return Container( // <--- ไม่ใช้ Scaffold!
      color: Colors.white70,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double bannerHeightRatio = 0.40;
          final double bannerHeight = constraints.maxHeight * bannerHeightRatio;
          const double infoCardHeight = 130.0;
          const double overlapDistance = 40.0;

          // คำนวณ Top Offset ที่เป็นจุดเริ่มต้นของ Notification Section
          // ตำแหน่งนี้คือ (ปลาย Banner - ระยะ Overlap) + ความสูง Card
          final double notifSectionTopOffset = (bannerHeight - overlapDistance) + infoCardHeight + 15;

          return Stack(
            clipBehavior: Clip.none,
            children: [
              // 1. Banner (อยู่ล่างสุด)
              HomeSideBannerWidget(bannerHeight: bannerHeight),

              // 2. Info Card (อยู่ด้านบน)
              HomeUserProfileCardWidget(
                  btnServiceAccess: () => _controller.btnServiceAccess(context),
                  // overlapSize คือ Top ของ Card
                  overlapSize: bannerHeight - overlapDistance,
                  infoCardHeight: infoCardHeight,
                  firstName: userProfile.firstNameTh,
                  lastName: userProfile.lastNameTh,
                  facName: userProfile.facultyNameTh,
                  pictureUrl: userProfile.picture,
                  pictureBase64: userProfile.pictureBase64,
              ),

              // 3. พื้นที่สำหรับ การแจ้งเตือน (Positioned.fill เพื่อใช้พื้นที่ที่เหลือ)
              Positioned.fill(
                top: notifSectionTopOffset,
                // เนื่องจากห่อด้วย SafeArea ใน HomePage แล้ว จึงไม่จำเป็นต้องกำหนด bottom:
                child: FutureBuilder<List<HomeUserNotificationListModel>>(
                  future: _controller.getNotificationList(),
                  builder: (context, snapshot) {

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }

                    if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      final notifications = snapshot.data!;

                      return HomeNotifSectionWidget(
                        notifications: notifications,
                      );
                    }

                    return const Center(child: Text('ไม่มีการแจ้งเตือน'));
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}