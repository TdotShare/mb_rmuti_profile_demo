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
    
    // ตรวจสอบให้แน่ใจว่าเป็น Web ก่อน
    if (!kIsWeb) {
      return; 
    }

    String currentOriginUrl = web.window.location.href;
    String encodedUrl = Uri.encodeComponent(currentOriginUrl);
    
    String ssoUrl = 'https://mis.rmuti.ac.th/services-authen/auth?url=$encodedUrl&tag=rmuti_p_profile';
    
    web.window.location.href = ssoUrl;
  }
}

// -------------------

final authControllerProvider = Provider((ref) => AuthController(ref));