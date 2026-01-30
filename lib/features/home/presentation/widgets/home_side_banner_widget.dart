import 'package:flutter/material.dart';

class HomeSideBannerWidget extends StatelessWidget {
  final double bannerHeight;
  const HomeSideBannerWidget({super.key, required this.bannerHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: bannerHeight,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFF8A00), Color(0xFFFFB347)], // สีส้ม RMUTI
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30), // โค้งมนมากขึ้นเพื่อความทันสมัย
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Stack(
        children: [
          // ลายวงกลมจางๆ ด้านหลังเพิ่มมิติ
          Positioned(
            right: -30,
            top: -20,
            child: CircleAvatar(radius: 60, backgroundColor: Colors.white.withOpacity(0.1)),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.campaign, color: Colors.white, size: 40),
                const SizedBox(height: 8),
                Text(
                  'ข่าวสารและกิจกรรม',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    shadows: [Shadow(color: Colors.black.withOpacity(0.2), blurRadius: 10)],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}