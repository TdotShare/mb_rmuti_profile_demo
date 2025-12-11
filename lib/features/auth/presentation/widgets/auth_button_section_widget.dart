import 'package:flutter/material.dart';

class AuthButtonSectionWidget extends StatelessWidget {
  // ลบตัวแปร int ที่ไม่ได้ใช้ในการ build ออก
  // final int btnLoginSso; 
  // final int btnLoginOfficer;

  // คงไว้แค่ callback ที่ใช้
  final VoidCallback voidBtnLoginSso;
  final VoidCallback voidBtnLoginOfficer;

  const AuthButtonSectionWidget({
    super.key,
    // ไม่ต้อง required ตัวแปรที่ถูกลบไปแล้ว
    // required this.btnLoginSso,
    // required this.btnLoginOfficer,
    required this.voidBtnLoginSso,
    required this.voidBtnLoginOfficer,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.85,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: voidBtnLoginSso, // กำหนด callback
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
                "เข้าสู่ระบบด้วย SSO RMUTI",
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: voidBtnLoginOfficer, // กำหนด callback
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