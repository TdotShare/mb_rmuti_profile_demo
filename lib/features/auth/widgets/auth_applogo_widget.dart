import 'package:flutter/material.dart';

class AuthAppLogoWidget extends StatelessWidget {
  const AuthAppLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // **ปรับขนาดเป็น 220x220 และใส่ Decoration กลับเข้าไป**
        SizedBox( // กำหนดขนาด 220x220 เพื่อรองรับโลโก้ 200x200
          width: 220,
          height: 220,
          child: DecoratedBox( // ใช้ DecoratedBox เพื่อใส่ decoration และ boxShadow
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(150), // ปรับรัศมีให้เป็นวงกลม
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFFFD49A), // ส้มอ่อน
                  Color(0xFFFF8A00), // ส้มเข้ม
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.orange.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Center(
              // ใช้ Image.asset Path และขนาดใหม่ตามที่ร้องขอ
              child: Image.asset(
                'assets/logo/rmuti.png', 
                width: 165, // ขนาดรูปภาพที่ต้องการ
                height: 165,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}