// **เปลี่ยน Import**
import 'package:web/web.dart' as web; 
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // สำหรับ kIsWeb
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mb_rmuti_profile_demo/features/auth/data/auth_repository.dart';

// -------------------

class AuthController {
  final Ref _ref;

  AuthController(this._ref);


  void onCheckTokenLogin(BuildContext context , String code) async
  {
    final _repository = _ref.read(authRepositoryProvider);
    _repository.onCheckTokenLogin(context , code);
  }

  void onPressedSso(BuildContext context) async {
    final _repository = _ref.read(authRepositoryProvider);
    _repository.onPressedSso(context);
  }

  void onPressedSsoToWeb() {
    // 1. ตรวจสอบให้แน่ใจว่าเป็น Web ก่อน
    if (!kIsWeb) {
      print('SSO only supported on web platform.');
      return; 
    }

    // 2. ดึง Origin URL ปัจจุบัน: 'http://localhost:60918' หรือ 'https://prod-domain.com'
    // **ใช้ .origin เพื่อไม่ให้ฮาร์ดโค้ด**
    String currentOriginUrl = web.window.location.origin;

    // 3. สร้าง URL สำหรับ SSO
    // เราต้องทำการ Encode URL เพื่อให้แน่ใจว่าเครื่องหมายพิเศษจะไม่ทำให้เกิดปัญหา
    String encodedUrl = Uri.encodeComponent(currentOriginUrl);
    
    // 4. ประกอบ URL ใหม่
    String ssoUrl = 'https://mis.rmuti.ac.th/services-authen/auth?url=$encodedUrl&tag=rmuti_p_profile';
    
    // 5. นำทางไปยัง URL SSO โดยใช้ package:web
    web.window.location.href = ssoUrl;
  }
}

// -------------------

final authControllerProvider = Provider((ref) => AuthController(ref));