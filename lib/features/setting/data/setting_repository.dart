import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mb_rmuti_profile_demo/routes/auth_router.dart';
import 'package:webview_flutter/webview_flutter.dart'; 

class SettingRepository {
  final Ref _ref;
  SettingRepository(this._ref);

  void onLogout(BuildContext context) async {
    final logoutUrl = 'https://api.rmuti.ac.th/sso/index.php?logout';

    // 1. แสดง Modal พร้อม Loading Indicator และ WebView
    await showGeneralDialog(
      // **ใช้ await เพื่อรอจนกว่า Modal จะปิด**
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
            ModalBarrier(
              dismissible: false,
              color: Colors.black.withOpacity(0.5),
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 10),
                  Text(
                    'กำลังออกจากระบบ',
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );

    Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil(
      AuthRoutes.authToken,
      (Route<dynamic> route) => false,
    );
  }
}

final settingRepositoryProvider = Provider((ref) {
  return SettingRepository(ref);
});
