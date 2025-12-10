import 'package:flutter/material.dart';

class HomeUserProfileCardWidget extends StatelessWidget {

  final double overlapSize;
  final double infoCardHeight;
  final VoidCallback btnServiceAccess;

  const HomeUserProfileCardWidget({
        super.key,
        required this.overlapSize,
        required this.infoCardHeight,
        required this.btnServiceAccess
      });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: overlapSize, // เลื่อนขึ้นไป Overlap
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 29),
        child: Container(
          width: double.infinity, // เต็มความกว้าง
          height: infoCardHeight, // ความสูงยังคงที่ (103)
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: const Color(0xFFD9D9D9),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // ข้อความซ้าย
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'สวัสดีคุณ รัฐสรณ์',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'คณะวิทยาศาสตร์และศิลปศาสตร์',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 4),
                  ElevatedButton(
                    onPressed: btnServiceAccess,
                    child: const Text('ดูบริการที่เข้าถึงได้'),
                  )
                ],
              ),

              // รูปภาพโปรไฟล์ขวา (ส่วนที่แก้ไข)
              Container(
                width: 75,
                height: 75,
                // ไม่ต้องมี decoration: BoxDecoration(...)
                child: ClipOval(
                  // ใช้ ClipOval ในการตัดรูปภาพให้เป็นวงกลม
                  child: Image.asset(
                    'assets/item/people.png',
                    fit: BoxFit.cover, // สำคัญ: ใช้ BoxFit.cover เพื่อให้ภาพเต็มพื้นที่ 84x84
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
