// auth_controller.dart (ปรับปรุง)
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // **1. เพิ่ม Riverpod**
import 'package:mb_rmuti_profile_demo/features/auth/data/auth_repository.dart';

// 2. เปลี่ยน AuthController ให้เป็น Notifier
// ในโค้ดปัจจุบัน AuthController ไม่มีสถานะที่ต้องการเปลี่ยน เราสามารถใช้ Provider ธรรมดาได้
class AuthController {
  // เปลี่ยนไปรับ Ref แทน AuthRepository 
  final Ref _ref;

  AuthController(this._ref);

  void onPressedSso(BuildContext context) async
  {
    // 3. อ่าน AuthRepository จาก Provider
    final _repository = _ref.read(authRepositoryProvider);
    _repository.onPressedSso(context);
  }
}

// 4. สร้าง AuthController Provider
final authControllerProvider = Provider((ref) => AuthController(ref));