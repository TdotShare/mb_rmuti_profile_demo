import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // **1. เพิ่ม Riverpod**
import 'package:mb_rmuti_profile_demo/routes/app_router.dart';
import 'package:mb_rmuti_profile_demo/routes/schedule_class_router.dart';

class ServiceAccessRepository {
  final Ref _ref;
  ServiceAccessRepository(this._ref);

  void onPressedGoToScheduleClass(BuildContext context) async {
    // ใช้ rootNavigator: true เพื่อให้ Push ทับ Bottom Navigation Bar ทั้งหมด
    // และเมื่อ Pop กลับมา ระบบจะกลับมาที่หน้า ServiceAccessPage ที่อยู่ใน Tab เดิมอย่างถูกต้อง
    Navigator.of(context, rootNavigator: true).pushNamed(
      ScheduleClassRouters.scheduleClassFirst,
    );
  }
}

final serviceAccessRepositoryProvider = Provider(
  (ref) => ServiceAccessRepository(ref),
);
