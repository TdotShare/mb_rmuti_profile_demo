import 'package:mb_rmuti_profile_demo/core/configs/web_stub.dart' if (dart.library.js_interop) 'package:web/web.dart' as web;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mb_rmuti_profile_demo/core/store/notifier/user_profile_notifier.dart';
import 'package:mb_rmuti_profile_demo/routes/auth_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SettingRepository {
  final Ref _ref;
  SettingRepository(this._ref);

  /// ฟังก์ชันหลักสำหรับ Logout
  void onLogout(BuildContext context) async {
    String baseUrl = "";
    if (kIsWeb) {
      final uri = Uri.parse(web.window.location.href);
      baseUrl = uri.origin;
    }

    final logoutUrl = kIsWeb
        ? 'https://api.rmuti.ac.th/sso/index.php?logout&redirect=$baseUrl'
        : 'https://api.rmuti.ac.th/sso/index.php?logout';

    if (kIsWeb) {
      await _executeWebLogout(logoutUrl);
    } else {
      await _executeMobileLogout(context, logoutUrl);
    }
  }

  Future<void> _executeWebLogout(String logoutUrl) async {
    await _clearLocalData();
    web.window.location.href = logoutUrl;
  }

  /// สำหรับ Mobile: แก้ไขป้องกันอาการจอดำ (Release Mode)
  Future<void> _executeMobileLogout(BuildContext context, String logoutUrl) async {
    // 1. เก็บ Navigator และ ScaffoldMessenger ไว้ก่อนเริ่ม Async
    final navigator = Navigator.of(context, rootNavigator: true);

    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (dialogContext, a1, a2) {
        return PopScope( // ป้องกันการกดปุ่ม Back ระหว่าง Logout
          canPop: false,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // WebView สำหรับแอบรันคำสั่ง Logout
              Positioned(
                width: 1.0,
                height: 1.0,
                child: Opacity(
                  opacity: 0.01,
                  child: WebViewWidget(
                    controller: WebViewController()
                      ..setJavaScriptMode(JavaScriptMode.unrestricted)
                      ..setNavigationDelegate(
                        NavigationDelegate(
                          onPageFinished: (String url) {
                            // เมื่อโหลดเสร็จ ปิด Dialog
                            if (navigator.canPop()) {
                              navigator.pop();
                            }
                          },
                          onWebResourceError: (error) {
                            // กรณี Error (เช่นเน็ตหลุด) ต้องปิด Dialog เช่นกัน เพื่อไม่ให้ค้างจอดำ
                            debugPrint('Logout WebView Error: ${error.description}');
                            if (navigator.canPop()) {
                              navigator.pop();
                            }
                          },
                        ),
                      )
                      ..loadRequest(Uri.parse(logoutUrl)),
                  ),
                ),
              ),
              ModalBarrier(
                dismissible: false,
                color: Colors.black.withOpacity(0.5),
              ),
              _buildLoadingIndicator(),
            ],
          ),
        );
      },
    ).then((_) async {
      // 2. หลังจาก Dialog ปิดลง ไม่ว่าจะสำเร็จหรือ Error
      await _clearLocalData();

      // 3. ตรวจสอบ Mounted ของ Context หรือใช้ Navigator ที่เก็บค่าไว้
      if (context.mounted) {
        navigator.pushNamedAndRemoveUntil(
          AuthRoutes.authToken,
              (Route<dynamic> route) => false,
        );
      }
    });
  }

  Future<void> _clearLocalData() async {
    try {
      _ref.read(userProfileProvider.notifier).clearProfile();
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      debugPrint('All local data cleared.');
    } catch (e) {
      debugPrint('Error clearing data: $e');
    }
  }

  Widget _buildLoadingIndicator() {
    return Material( // ใส่ Material เพื่อให้ Text แสดงผลถูกต้องไม่เป็นเส้นใต้แดง
      type: MaterialType.transparency,
      child: Container(
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
            Text(
              'กำลังออกจากระบบ',
              style: TextStyle(
                  fontFamily: 'Kanit',
                  fontSize: 16,
                  color: Colors.black,
                  decoration: TextDecoration.none
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final settingRepositoryProvider = Provider((ref) {
  return SettingRepository(ref);
});