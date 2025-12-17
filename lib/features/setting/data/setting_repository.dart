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

  void onLogout(BuildContext context) async {
    final logoutUrl = 'https://api.rmuti.ac.th/sso/index.php?logout';

    // --------------------------------------------------------
    // 1. แสดง Modal พร้อม Loading Indicator
    // --------------------------------------------------------

    // ใช้ showGeneralDialog เพื่อควบคุม Transition ได้ดีกว่า showDialog
    showGeneralDialog(
      context: context,
      barrierDismissible: false, // ป้องกันการปิดเมื่อแตะด้านนอก
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, a1, a2) {
        // องค์ประกอบหน้าจอทั้งหมดที่ซ้อนทับกัน
        return Stack(
          alignment: Alignment.center,
          children: [
            // A. WebViewWidget (ถูกซ่อนไว้ด้านล่าง)
            // กำหนดให้มีขนาด 1x1 พิกเซล หรือ 0x0 เพื่อซ่อนแต่ยังให้ทำงานได้
            // หรือใช้ Opacity(opacity: 0.0, ...) เพื่อซ่อนอย่างสมบูรณ์
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
                        // 1. เมื่อ SSO Logout เสร็จสิ้น (WebView โหลดหน้าสุดท้าย)
                        // 2. ให้ปิด Modal (Dismiss the dialog)
                        Navigator.of(context).pop();
                      },
                      // อาจเพิ่ม onWebResourceError เพื่อจัดการกรณีที่เกิดข้อผิดพลาด
                    ),
                  ),
              ),
            ),

            // B. Modal Barrier / Background (ทำให้หน้าจอมืดลง)
            ModalBarrier(
              dismissible: false,
              color: Colors.black.withOpacity(0.5), // ทำให้พื้นหลังมืดลง
            ),

            // C. Loading Indicator (แสดงต่อผู้ใช้)
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(), // ตัวหมุนโหลด
                  SizedBox(height: 10),
                  Text('กำลังออกจากระบบ', style: TextStyle(fontSize: 14, color: Colors.black)),
                ],
              ),
            ),
          ],
        );
      },
    );

    // --------------------------------------------------------
    // 2. Clear ข้อมูลและนำทางต่อ (รอจนกว่า showGeneralDialog จะถูก pop)
    // --------------------------------------------------------
    // เมื่อ showGeneralDialog ถูก pop แล้ว (จาก onPageFinished ใน WebView) โค้ดส่วนนี้จะทำงานต่อ

    _ref.read(userProfileProvider.notifier).clearProfile();
    print('User Profile State cleared (Riverpod).');

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    debugPrint('Shared Preferences data cleared.');

    // นำทางไปยังหน้า Login
    Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil(
      AuthRoutes.authToken,
          (Route<dynamic> route) => false,
    );
  }
}

final settingRepositoryProvider = Provider((ref) {
  return SettingRepository(ref);
});
