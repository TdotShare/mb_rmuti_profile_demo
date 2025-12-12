import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mb_rmuti_profile_demo/core/store/notifier/user_profile_notifier.dart';
import 'package:mb_rmuti_profile_demo/routes/auth_router.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart'; // <--- 1. Import SharedPreferences
import 'package:web/web.dart' as web;
import 'package:flutter/foundation.dart'; // สำหรับ kIsWeb

class SettingRepository {
  final Ref _ref;
  SettingRepository(this._ref);

  void onLogout(BuildContext context) async {
    // --------------------------------------------------------
    // 1. Clear ข้อมูลภายในแอปทันที (ไม่ว่าจะเป็น Web หรือ Mobile)
    // --------------------------------------------------------
    _ref.read(userProfileProvider.notifier).clearProfile();
    print('User Profile State cleared (Riverpod).');

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    debugPrint('Shared Preferences data cleared.');
    
    // --------------------------------------------------------
    // 2. จัดการ SSO Logout และนำทาง (แยกตามแพลตฟอร์ม)
    // --------------------------------------------------------

    if (kIsWeb) {
      // **A. สำหรับ Flutter Web: ใช้เบราว์เซอร์นำทางไป URL Logout**
      // เราใช้ .replace เพื่อไม่ให้ผู้ใช้กด Back กลับมาได้
      final ssoLogoutUrl = 'https://api.rmuti.ac.th/sso/index.php?logout&redirect=${web.window.location.origin}';
      
      // การใช้ replace จะเปลี่ยนหน้าไป SSO Logout และ SSO จะ redirect กลับมาที่ Origin ที่ไม่มี ?code
      web.window.location.replace(ssoLogoutUrl); 
      
      // เมื่อใช้ web.window.location.replace แล้ว โค้ดส่วนนี้จะหยุดทำงานทันที (ไม่ต้องมี Navigator)
      
    } else {
      // **B. สำหรับ Mobile/Desktop: ใช้ WebViewWidget ที่ซ่อนอยู่เพื่อ Logout**
      final logoutUrl = 'https://api.rmuti.ac.th/sso/index.php?logout';

      // 1. แสดง Modal พร้อม Loading Indicator และ WebView
      await showGeneralDialog( // **ใช้ await เพื่อรอจนกว่า Modal จะปิด**
        context: context,
        barrierDismissible: false,
        transitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (context, a1, a2) {
          return Stack(
            alignment: Alignment.center,
            children: [
              // A. WebViewWidget (ถูกซ่อนไว้ด้านล่าง)
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
                          // เมื่อ SSO Logout เสร็จสิ้น ให้ปิด Modal
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                ),
              ),

              // B. Loading Indicator (แสดงต่อผู้ใช้)
              ModalBarrier(dismissible: false, color: Colors.black.withOpacity(0.5)),
              Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 10),
                    Text('กำลังออกจากระบบ', style: TextStyle(fontSize: 14, color: Colors.black)),
                  ],
                ),
              ),
            ],
          );
        },
      );
      
      // 2. นำทางไปยังหน้า Login (เมื่อ Modal ถูกปิดแล้ว)
      Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil(
        AuthRoutes.authToken,
        (Route<dynamic> route) => false,
      );
    }
  }
}

final settingRepositoryProvider = Provider((ref) {
  return SettingRepository(ref);
});
