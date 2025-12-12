// **Widget สำหรับบัตรข้อมูลนักศึกษา**
import 'package:flutter/material.dart';
import 'dart:convert'; // <-- ต้องเพิ่ม import นี้

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

  // ⭐️ Helper method สำหรับสร้างรูปโปรไฟล์ (รับขนาดเข้ามา) ⭐️
  Widget _buildProfileImage(double imageSize) {
    Widget imageWidget;
    const String defaultAsset = 'assets/item/people.png'; // รูปภาพสำรอง

    // 1. ตรวจสอบ Base64
    if (pictureBase64 != null && pictureBase64!.isNotEmpty) {
      try {
        final imageBytes = base64Decode(pictureBase64!);

        imageWidget = Image.memory(
          imageBytes,
          fit: BoxFit.cover,
        );
      } catch (e) {
        debugPrint('Error decoding Base64 image in ProfileCard: $e');
        imageWidget = Image.asset(defaultAsset, fit: BoxFit.cover); // Fallback
      }
    }
    // 2. ตรวจสอบ URL
    else if (pictureUrl != null && pictureUrl!.isNotEmpty) {
      imageWidget = Image.network(
        pictureUrl!,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const Center(child: CircularProgressIndicator(
            strokeWidth: 2.0,
            color: Color(0xFFFF8A00),
          ));
        },
        errorBuilder: (context, error, stackTrace) => Image.asset(
          defaultAsset, // Fallback หากโหลด URL ไม่ได้
          fit: BoxFit.cover,
        ),
      );
    }
    // 3. ใช้ Asset เริ่มต้น
    else {
      // ใช้ Icon แทนรูป Asset เพื่อให้ขนาดดูสวยงาม (หรือจะใช้ Asset ก็ได้)
      imageWidget = const Icon(
        Icons.account_circle,
        color: Colors.black54,
      );
    }

    // หากเป็น Icon ต้องห่อด้วย ClipOval เพื่อให้มีพื้นที่กำหนดขนาด
    // หากเป็น Image.memory/Image.network ก็ใช้ ClipOval เพื่อตัดเป็นวงกลม
    return Container(
      width: imageSize,
      height: imageSize,
      child: ClipOval(
        child: imageWidget,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    // ใช้ขนาดเดิมที่คำนวณจากความกว้างหน้าจอ (20% ของหน้าจอ)
    final double iconSize = screenWidth * 0.20;

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
              // ⭐️ แทนที่ Icon ด้วย _buildProfileImage ⭐️
              _buildProfileImage(iconSize),

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

              // ข้อมูลรายละเอียด (ใช้ Helper Row)
              _buildInfoRow('รหัสประจำตัว', displayCodeId),
              _buildInfoRow('คณะ', displayFacName),
              // ...
            ],
          ),
        ),
      ),
    );
  }
}