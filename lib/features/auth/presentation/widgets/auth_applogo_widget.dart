import 'package:flutter/material.dart';

class AuthAppLogoWidget extends StatelessWidget {
  const AuthAppLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // ใช้ 55% ของความกว้างหน้าจอสำหรับขนาดของกล่องโลโก้ (ประมาณ 200-220px บนมือถือทั่วไป)
    final double logoBoxSize = screenWidth * 0.55;
    // ใช้ 75% ของขนาดกล่องสำหรับรูปโลโก้
    final double imageSize = logoBoxSize * 0.75;

    return Column(
      children: [
        SizedBox( // กำหนดขนาดเป็นสัดส่วน
          width: logoBoxSize,
          height: logoBoxSize,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(logoBoxSize / 2), // ปรับรัศมีให้เป็นวงกลมตามขนาด
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