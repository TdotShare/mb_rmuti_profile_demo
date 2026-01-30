import 'package:flutter/material.dart';
import 'package:mb_rmuti_profile_demo/features/home/data/home_repository.dart';
import 'package:mb_rmuti_profile_demo/features/home/data/models/home_user_notification_list_model.dart';
import 'package:mb_rmuti_profile_demo/routes/app_router.dart';
import 'package:mb_rmuti_profile_demo/routes/service_access_router.dart';

class HomeController {
  final HomeRepository _repository = HomeRepository();

  Future<List<HomeUserNotificationListModel>> getNotificationList() async {
    final notificationList = await _repository.getNotificationList();
    return notificationList;
  }

  // 🚀 แก้ไข: ให้เมธอดนี้รับ BuildContext เข้ามา
  void btnServiceAccess(BuildContext context) {
    // ตอนนี้ AppRouter.push ก็จะสามารถใช้ context ที่ถูกส่งเข้ามาได้
    Navigator.of(
      context,
      rootNavigator: true,
    ).pushNamed(ServiceAccessRouters.serviceAccess);
  }
}
