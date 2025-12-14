
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';


class ProfileImageWidget extends StatelessWidget {
  final double imageSize;
  final String? pictureUrl;
  final String? pictureBase64;
  final Widget? defaultFallbackWidget; // ตัวเลือกเสริม: Widget สำรองเมื่อไม่มีรูปภาพ

  const ProfileImageWidget({
    super.key,
    required this.imageSize,
    this.pictureUrl,
    this.pictureBase64,
    this.defaultFallbackWidget,
  });

  Widget _getImageWidget(BuildContext context) {
    const String defaultAsset = 'assets/item/people.png';
    Widget imageWidget;

    // 1. ตรวจสอบ Base64
    if (pictureBase64 != null && pictureBase64!.isNotEmpty) {
      try {
        final Uint8List imageBytes = base64Decode(pictureBase64!);
        imageWidget = Image.memory(
          imageBytes,
          fit: BoxFit.cover,
        );
      } catch (e) {
        // หากถอดรหัส Base64 ล้มเหลว
        debugPrint('Error decoding Base64 image in ProfileImageWidget: $e');
        imageWidget = Image.asset(defaultAsset, fit: BoxFit.cover); // Fallback to Asset
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
          defaultAsset, // Fallback หากโหลด URL ไม่ได้
          fit: BoxFit.cover,
        ),
      );
    }
    // 3. ใช้ Widget สำรอง/Asset/Icon เริ่มต้น
    else {
      // ใช้ defaultFallbackWidget ถ้ามีการส่งมา หรือใช้ Asset/Icon ตามค่า default
      if (defaultFallbackWidget != null) {
        imageWidget = defaultFallbackWidget!;
      } else {
        // ใช้ Icon เป็น default Fallback เพื่อความยืดหยุ่นในขนาด
        imageWidget = Icon(
          Icons.account_circle,
          size: imageSize, // ใช้ขนาดเต็มพื้นที่ที่กำหนด
          color: Colors.black54,
        );
      }
    }
    return imageWidget;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: imageSize,
      height: imageSize,
      // ห่อหุ้มด้วย ClipOval เพื่อให้รูปภาพเป็นวงกลมเสมอ
      child: ClipOval(
        child: _getImageWidget(context),
      ),
    );
  }
}