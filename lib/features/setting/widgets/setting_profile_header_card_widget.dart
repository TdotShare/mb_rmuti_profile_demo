import 'package:flutter/material.dart';

class SettingProfileHeaderCard extends StatelessWidget {

  final VoidCallback voidBtnSelectPhoto;

  const SettingProfileHeaderCard(
      {
        super.key,
        required this.voidBtnSelectPhoto,
      });

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    // กำหนดขนาดโปรไฟล์ เช่น 15% ของความกว้างหน้าจอ
    final double profileSize = screenWidth * 0.15; // ⬅️ ปรับให้เหมาะสม
    // กำหนดขนาดไอคอนกล้อง เช่น 40% ของขนาดโปรไฟล์
    final double cameraButtonSize = profileSize * 0.4;
    final double cameraIconSize = cameraButtonSize * 0.6;


    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 20),
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 1. รูปโปรไฟล์ (มีไอคอนกล้องถ่ายรูป)
              Stack(
                children: [
                  Icon( // ⬅️ ใช้ Icon ธรรมดา
                    Icons.account_circle,
                    size: profileSize, // ⬅️ ใช้ profileSize ที่คำนวณแล้วแทน 45
                    color: Colors.black,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    // **ไอคอนกล้องถ่ายรูป (สามารถกดได้)**
                    child: InkWell( // ใช้ InkWell เพื่อรองรับการคลิก
                      onTap: voidBtnSelectPhoto, // เรียกฟังก์ชันที่สร้างไว้
                      child: Container(
                        width: cameraButtonSize,
                        height: cameraButtonSize,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2), // Border สีขาว
                        ),
                        child: Icon(
                          Icons.camera_alt, // ไอคอนกล้องถ่ายรูป
                          size: cameraIconSize, // ขนาดไอคอน
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(width: 15),

              // 2. ข้อมูลผู้ใช้
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'รัฐสรณ์ ทดสอบ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Kanit',
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'คณะวิทยาศาสตร์และศิลปศาสตร์',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                      fontFamily: 'Kanit',
                    ),
                  ),
                  Text(
                    'นักศึกษา',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                      fontFamily: 'Kanit',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}