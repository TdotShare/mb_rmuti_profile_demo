// **Widget สำหรับบัตรข้อมูลนักศึกษา**
import 'package:flutter/material.dart';
import 'package:mb_rmuti_profile_demo/core/widgets/profile_image/profile_image_widget.dart'; // <-- ต้องเพิ่ม import นี้

class ProfileInfoCardWidget extends StatelessWidget {

  final String? firstName;
  final String? lastName;
  final String? codeId;
  final String? facName;
  final String? pictureUrl;
  final String? pictureBase64;

  const ProfileInfoCardWidget({
    super.key,
    this.firstName,
    this.lastName,
    this.codeId,
    this.facName,
    this.pictureUrl,
    this.pictureBase64,
  });

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

    final screenWidth = MediaQuery.of(context).size.width;
    // ใช้ขนาดเดิมที่คำนวณจากความกว้างหน้าจอ (20% ของหน้าจอ)
    final double imageSize = screenWidth * 0.20;

    final String displayFirstName = firstName ?? 'ไม่พบข้อมูล';
    final String displayLastName = lastName ?? 'ไม่พบข้อมูล';
    final String displayCodeId = codeId ?? 'ไม่พบข้อมูล';
    final String displayFacName = facName ?? 'ไม่พบข้อมูล';

    return SizedBox(
      width: screenWidth * 0.90,
      child: Card(
        color: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [

              ProfileImageWidget(
                imageSize: imageSize,
                pictureUrl: pictureUrl,
                pictureBase64: pictureBase64,
              ),

              const SizedBox(height: 10),

              // ชื่อ-นามสกุล
              Text(
                '$displayFirstName $displayLastName',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              _buildInfoRow('รหัสประจำตัว', displayCodeId),
              _buildInfoRow('คณะ', displayFacName),

            ],
          ),
        ),
      ),
    );
  }
}