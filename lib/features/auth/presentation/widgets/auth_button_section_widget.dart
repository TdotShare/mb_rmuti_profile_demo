// auth_button_section_widget.dart
import 'package:flutter/material.dart';

class AuthButtonSectionWidget extends StatelessWidget {
  final int btnLoginSso;
  final int btnLoginOfficer;

  final VoidCallback voidBtnLoginSso;
  final VoidCallback voidBtnLoginOfficer;

  const AuthButtonSectionWidget({
    super.key,
    required this.btnLoginSso,
    required this.btnLoginOfficer,
    required this.voidBtnLoginSso,
    required this.voidBtnLoginOfficer,
  });

  @override
  Widget build(BuildContext context) {
    // ใช้ Theme ของปุ่มจาก ThemeData ที่เรากำหนดไว้ (หรือ override ที่นี่)
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.85,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: voidBtnLoginSso,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF8A00), // สีปุ่ม
                foregroundColor: Colors.white, // สีข้อความ (icon/text)
                textStyle: const TextStyle(
                  fontFamily: 'Kanit',
                  fontWeight: FontWeight.bold, // ตัวหนา
                  fontSize: 16,
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                "เข้าสู่ระบบด้วย SSO RMUTI",
                textAlign: TextAlign.center,

              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: voidBtnLoginOfficer,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF8A00),
                foregroundColor: Colors.white,
                textStyle: const TextStyle(
                  fontFamily: 'Kanit',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                "สำหรับเจ้าหน้าที่",
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
