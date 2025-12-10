import 'package:flutter/material.dart';
import 'dart:math'; // ต้อง Import math เพื่อใช้ min

class AuthAppLogoWidget extends StatelessWidget {
  const AuthAppLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // 1. กำหนดขนาดสูงสุดที่โลโก้ควรจะเป็นบนหน้าจอขนาดใหญ่
    const double maxLogoSize = 250.0; // สามารถปรับได้ตามความเหมาะสม

    // 2. คำนวณขนาดที่ต้องการ:
    //    - ใช้ 55% ของความกว้างหน้าจอ (เหมือนเดิม)
    //    - เลือกค่าที่น้อยที่สุดระหว่าง (55% ของหน้าจอ) กับ (ขนาดสูงสุด 250.0)
    final double desiredLogoSize = screenWidth * 0.55;
    final double logoBoxSize = min(desiredLogoSize, maxLogoSize);

    // ใช้ 75% ของขนาดกล่องสำหรับรูปโลโก้ (ตามเดิม)
    final double imageSize = logoBoxSize * 0.75;

    return Column(
      children: [
        SizedBox( // กำหนดขนาดเป็นสัดส่วน (แต่จำกัดสูงสุด)
          width: logoBoxSize,
          height: logoBoxSize,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(logoBoxSize / 2),
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
              child: Image.asset(
                'assets/logo/rmuti.png',
                width: imageSize,
                height: imageSize,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}