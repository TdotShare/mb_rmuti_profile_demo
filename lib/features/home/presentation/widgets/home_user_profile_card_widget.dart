import 'dart:convert';

import 'package:flutter/material.dart';

class HomeUserProfileCardWidget extends StatelessWidget {

  final double overlapSize;
  final double infoCardHeight;
  final VoidCallback btnServiceAccess;


  final String? firstName;
  final String? lastName;
  final String? facName;
  final String? pictureUrl;
  final String? pictureBase64;

  const HomeUserProfileCardWidget({
    super.key,
    required this.overlapSize,
    required this.infoCardHeight,
    required this.btnServiceAccess,
    this.firstName,
    this.lastName,
    this.facName,
    this.pictureUrl,
    this.pictureBase64,
  });

  // Helper method สำหรับสร้างรูปโปรไฟล์
  Widget _buildProfileImage() {
    const double imageSize = 75;
    Widget imageWidget;

    // 1. ตรวจสอบ Base64
    if (pictureBase64 != null && pictureBase64!.isNotEmpty) {
      try {
        // ถอดรหัส Base64 String เป็น Uint8List (bytes)
        final imageBytes = base64Decode(pictureBase64!);

        imageWidget = Image.memory(
          imageBytes, // ใช้ Image.memory เพื่อแสดงผลจาก Bytes
          fit: BoxFit.cover,
        );
      } catch (e) {
        // หากถอดรหัส Base64 ล้มเหลว (Malformed Base64)
        debugPrint('Error decoding Base64 image: $e');
        imageWidget = Image.asset(
          'assets/item/people.png',
          fit: BoxFit.cover,
        );
      }
    }
    // 2. ตรวจสอบ URL
    else if (pictureUrl != null && pictureUrl!.isNotEmpty) {
      imageWidget = Image.network(
        pictureUrl!,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const Center(
            child: CircularProgressIndicator(
              strokeWidth: 2.0,
              color: Color(0xFFFF8A00),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) => Image.asset(
          'assets/item/people.png', // Fallback หากโหลด URL ไม่ได้
          fit: BoxFit.cover,
        ),
      );
    }
    // 3. ใช้ Asset เริ่มต้น
    else {
      imageWidget = Image.asset(
        'assets/item/people.png', // รูปภาพเริ่มต้น
        fit: BoxFit.cover,
      );
    }

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
    // 3. การแสดงผลข้อความ: ใช้ Null-aware operator (??) เพื่อแสดงค่าเริ่มต้น
    final String displayFirstName = firstName ?? 'ทดสอบ';
    final String displayLastName = lastName ?? 'ทดสอบ';
    final String displayFacName = facName ?? 'ทดสอบ';

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
            color: Colors.white,
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
              Flexible( // ใช้ Flexible/Expanded เพื่อให้ข้อความไม่ชนรูปภาพ
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'สวัสดีคุณ $displayFirstName $displayLastName',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      displayFacName,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 4),
                    ElevatedButton(
                      onPressed: btnServiceAccess,
                      child: const Text('ดูบริการที่เข้าถึงได้'),
                    )
                  ],
                ),
              ),

              // รูปภาพโปรไฟล์ขวา (ใช้ Helper method ที่สร้างขึ้น)
              _buildProfileImage(),
            ],
          ),
        ),
      ),
    );
  }
}