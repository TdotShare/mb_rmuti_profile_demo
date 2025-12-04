import 'package:flutter/material.dart';

// Class สำหรับสร้างรูปร่างคลื่น (Layer หน้า - คลื่นหลักสีขาว)
class WhiteWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    // 1. วาดขอบบนของพื้นที่สีขาว
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);

    // 2. วาดขอบขวาลงมา
    path.lineTo(size.width, size.height * 0.60);

    // 3. วาดเส้นโค้งแบบ Cubic Bezier (จากขวาไปซ้าย) - (คลื่นหลัก)
    // ใช้ค่าพิกัดที่คุณปรับปรุงมา
    final controlPoint1 = Offset(size.width * 0.75, size.height * 0.60);
    final controlPoint2 = Offset(size.width * 0.10, size.height * 0.95);
    final endPoint = Offset(0, size.height * 0.65);

    path.cubicTo(
      controlPoint1.dx, controlPoint1.dy,
      controlPoint2.dx, controlPoint2.dy,
      endPoint.dx, endPoint.dy,
    );

    // 4. วาดขอบซ้ายขึ้นไปด้านบน
    path.lineTo(0, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

// Class สำหรับสร้างรูปร่างคลื่น (Layer หลัง - เพื่อสร้างขอบ/เงา)
// ปรับให้มีขนาดเล็กลง (ใกล้ WhiteWaveClipper มากขึ้น)
class BackWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    // 1. วาดขอบบน
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);

    // 2. วาดขอบขวาลงมา (จุดเริ่มต้นคลื่น: 0.62)
    path.lineTo(size.width, size.height * 0.62);

    // 3. วาดเส้นโค้งแบบ Cubic Bezier (จากขวาไปซ้าย) - (คลื่นหลัง/เงา)
    // ปรับค่า Y ให้ห่างจาก WhiteWaveClipper (0.60, 0.95, 0.65) เพียงเล็กน้อย
    final controlPoint1 = Offset(size.width * 0.75, size.height * 0.62);
    final controlPoint2 = Offset(size.width * 0.10, size.height * 0.97); // ดึงให้ลึกกว่าเดิมเล็กน้อย
    final endPoint = Offset(0, size.height * 0.67); // ขอบซ้ายล่างกว่าเดิมเล็กน้อย

    path.cubicTo(
      controlPoint1.dx, controlPoint1.dy,
      controlPoint2.dx, controlPoint2.dy,
      endPoint.dx, endPoint.dy,
    );

    // 4. วาดขอบซ้ายขึ้นไปด้านบน
    path.lineTo(0, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}


class AuthTokenPage extends StatelessWidget {
  const AuthTokenPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    // ความสูงของ White Container ที่มี ClipPath
    final double clippedContainerHeight = size.height * 1.0; 

    return Scaffold(
      body: Stack(
        children: [
          // 1) พื้นหลังส้มเต็มจอ (Orange Gradient) - ใช้การไล่โทนสีตามที่คุณต้องการ
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft, // ไล่จากบนซ้าย
                end: Alignment.bottomRight, // ไปล่างขวา
                colors: [
                  Color.fromARGB(255, 248, 199, 135), // ส้มอ่อน
                  Color.fromARGB(255, 255, 136, 0), // ส้มเข้ม
                ],
              ),
            ),
          ),
          
          // --- 2) คลื่น Layer หลัง (สีเหลืองทอง FFF10B) ---
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height: clippedContainerHeight, 
              child: ClipPath(
                clipper: BackWaveClipper(), // ใช้ BackWaveClipper ที่ใหญ่กว่า
                child: Container(
                  color: Color.fromRGBO(255, 246, 122, 1) 
                ),
              ),
            ),
          ),

          // --- 3) คลื่น Layer หน้า (คลื่นหลักสีขาว) ---
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height: clippedContainerHeight, 
              child: ClipPath(
                clipper: WhiteWaveClipper(), // ใช้ WhiteWaveClipper
                child: Container(
                  color: Colors.white,
                  child: SafeArea(
                    bottom: false,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // เว้นระยะห่างด้านบน (ใช้ค่าจากโค้ดที่คุณให้มาล่าสุด)
                        const SizedBox(height: 160), 
                        
                        // โลโก้ RMUTI (จำลองจากภาพต้นฉบับ)
                        const LogoPlaceholder(),
                        
                        // เว้นที่ว่างด้านล่างของ white area เพื่อให้ wave โผล่มาเห็น
                        Expanded(child: Container()),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // 4) ข้อความ + loader ซ้อนอยู่ "ด้านหน้า" ของขอบ wave
          Positioned(
            left: 0,
            right: 0,
            // ปรับตำแหน่งให้ลงมาอยู่ด้านล่างสุดของพื้นที่สีส้ม
            top: size.height * 0.88, 
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  'กำลังโหลดข้อมูล',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white, 
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: 36,
                  height: 36,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
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

// Widget จำลองโลโก้ให้ดูใกล้เคียงภาพต้นฉบับ
class LogoPlaceholder extends StatelessWidget {
  const LogoPlaceholder({super.key});

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