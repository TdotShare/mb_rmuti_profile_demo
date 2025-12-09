// **Widget สำหรับบัตรข้อมูลนักศึกษา**
import 'package:flutter/material.dart';


class ProfileInfoCardWidget extends StatelessWidget {
  const ProfileInfoCardWidget({super.key});

  // Helper สำหรับสร้างคู่ของ Label และ Value
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          SizedBox(
            width: 90,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // จำกัดความกว้างของ Card ให้ดูเหมือนบัตร
    final screenWidth = MediaQuery.of(context).size.width;
    final double iconSize = screenWidth * 0.20; // ⬅️ 20% ของความกว้างหน้าจอสำหรับไอคอนหลัก

    return SizedBox(
      width: screenWidth * 0.90,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              // รูปโปรไฟล์หลัก
              Icon( // ⬅️ ใช้ Icon ธรรมดาเพื่อใช้ตัวแปร iconSize
                Icons.account_circle,
                size: iconSize, // ⬅️ ใช้ iconSize ที่คำนวณแล้วแทน 80
                color: Colors.black,
              ),
              const SizedBox(height: 10),

              // ชื่อ-นามสกุล
              const Text(
                'นายรัฐสรณ์ ทดสอบ',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // ข้อมูลรายละเอียด (ใช้ Helper Row)
              _buildInfoRow('รหัส/นักศึกษา', '58162110024-5'),
              _buildInfoRow('คณะ', 'วิทยาศาสตร์และศิลปศาสตร์'),
              _buildInfoRow('โปรแกรมวิชา', 'วิทยาการคอมพิวเตอร์'),
            ],
          ),
        ),
      ),
    );
  }
}