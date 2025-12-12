// ไฟล์: AuthRepository.dart (ปรับปรุง)
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // **1. เพิ่ม Riverpod**
import 'package:mb_rmuti_profile_demo/core/store/notifier/user_profile_notifier.dart';
import 'package:mb_rmuti_profile_demo/routes/app_router.dart';
import 'package:mb_rmuti_profile_demo/routes/auth_router.dart';

// 3. เปลี่ยน AuthRepository เป็น Class ทั่วไปที่ถูกสร้างโดย Provider
class AuthRepository {
  // รับ Ref เข้ามาเพื่อใช้ในการเข้าถึง Providers อื่นๆ
  final Ref _ref;

  AuthRepository(this._ref); // Constructor รับ Ref

  void onPressedSso(BuildContext context) async {

    final result = await AppRouter.pushAuthOauth(context);

    if (result != null) {

      final code = result['code'];
      //final type = result['type'];

      final Dio dio = Dio();

      try {

        final Response response = await dio.get(
          'https://api.rmuti.ac.th/api/v3/me',
          options: Options(
            headers: {
              'Authorization': 'Bearer $code',
            },
          ),
        );

        if (response.statusCode == 200) {

          print("Data: ${response.data}");

          // **4. โค้ดใหม่: อัปเดต UserProfileState**
          final Map<String, dynamic> userData = response.data;

          // อ่าน Notifier เพื่อเรียกใช้เมธอด
          final userProfileNotifier = _ref.read(userProfileProvider.notifier);

          // เรียกเมธอด fetchAndSetProfile เพื่ออัปเดตสถานะ
          await userProfileNotifier.fetchAndSetProfile(userData);

          AppRouter.pushReplacement(context , AuthRoutes.home);

        } else {
          print("API Call Failed with status code: ${response.statusCode}");
        }
      } on DioException catch (e) {
        debugPrint("Dio Error: ${e.message}");
      } catch (e) {
        debugPrint("An unexpected error occurred: $e");
      }
    }
  }
}

// 5. สร้าง AuthRepository Provider
// เราจะใช้ Provider ธรรมดา เพื่อให้ Widgets หรือ Controllers สามารถอ่าน AuthRepository ได้
final authRepositoryProvider = Provider((ref) => AuthRepository(ref));