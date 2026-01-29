import 'package:mb_rmuti_profile_demo/core/configs/web_stub.dart' if (dart.library.js_interop) 'package:web/web.dart' as web;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mb_rmuti_profile_demo/core/store/notifier/user_profile_notifier.dart';
import 'package:mb_rmuti_profile_demo/routes/app_router.dart';
import 'package:mb_rmuti_profile_demo/routes/auth_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SettingRepository {
  final Ref _ref;
  SettingRepository(this._ref);

  /// ฟังก์ชันหลักสำหรับ Logout รองรับทั้ง Web และ Mobile
  void onLogout(BuildContext context) async {
    // 1. เตรียม Base URL และ Logout URL
    String baseUrl = "";
    if (kIsWeb) {
      final uri = Uri.parse(web.window.location.href);
      baseUrl = uri.origin;
    }
    
    // กำหนด URL สำหรับ Logout (เพิ่ม redirect_uri สำหรับ Web)
    final logoutUrl = kIsWeb 
        ? 'https://api.rmuti.ac.th/sso/index.php?logout&redirect=$baseUrl'
        : 'https://api.rmuti.ac.th/sso/index.php?logout';

    // 2. จัดการ Logout ตาม Platform
    if (kIsWeb) {
      await _executeWebLogout(logoutUrl);
    } else {
      await _executeMobileLogout(context, logoutUrl);
    }
  }

  /// สำหรับ Web: ล้างข้อมูลแล้ว Redirect ทั้งหน้าต่าง
  Future<void> _executeWebLogout(String logoutUrl) async {
    await _clearLocalData();
    // ย้ายหน้าไปยัง SSO Logout ทันที (Browser จะจัดการ Redirect กลับมา baseUrl เอง)
    web.window.location.href = logoutUrl;
  }

  /// สำหรับ Mobile: แสดง Modal และใช้ WebView แอบโหลด Logout URL
  Future<void> _executeMobileLogout(BuildContext context, String logoutUrl) async {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, a1, a2) {
        return Stack(
          alignment: Alignment.center,
          children: [
            // WebView ถูกเรียกเฉพาะบน Mobile เท่านั้น เพื่อป้องกัน Error บน Web
            Positioned(
              width: 1.0,
              height: 1.0,
              child: WebViewWidget(
                controller: WebViewController()
                  ..setJavaScriptMode(JavaScriptMode.unrestricted)
                  ..loadRequest(Uri.parse(logoutUrl))
                  ..setNavigationDelegate(
                    NavigationDelegate(
                      onPageFinished: (String url) {
                        // เมื่อโหลดหน้า Logout สำเร็จ ให้ปิด Modal
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
              ),
            ),

            ModalBarrier(
              dismissible: false,
              color: Colors.black.withOpacity(0.5),
            ),

            _buildLoadingIndicator(),
          ],
        );
      },
    ).then((_) async {
      // หลังจาก Dialog ปิดลง (Logout เสร็จ) ให้ล้างข้อมูลแล้วกลับไปหน้า Login
      await _clearLocalData();
      if (context.mounted) {
        Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil(
          AuthRoutes.authToken,
          (Route<dynamic> route) => false,
        );
      }
    });
  }

  /// ล้างข้อมูล Profile และ SharedPreferences
  Future<void> _clearLocalData() async {
    _ref.read(userProfileProvider.notifier).clearProfile();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    debugPrint('All local data cleared.');
  }

  /// UI ส่วน Loading
  Widget _buildLoadingIndicator() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(color: Color(0xFFFF8A00)),
          SizedBox(height: 16),
          DefaultTextStyle(
            style: TextStyle(fontFamily: 'Kanit', fontSize: 16, color: Colors.black),
            child: Text('กำลังออกจากระบบ'),
          ),
        ],
      ),
    );
  }
}

final settingRepositoryProvider = Provider((ref) {
  return SettingRepository(ref);
});