import 'package:flutter/material.dart';
import 'dart:convert'; // <--- เพิ่มสำหรับการถอดรหัส Base64

class SettingProfileHeaderCard extends StatelessWidget {

  final VoidCallback voidBtnSelectPhoto;
  final String? firstName;
  final String? lastName;
  final String? facName;
  final String? pictureUrl;
  final String? pictureBase64;

  const SettingProfileHeaderCard(
      {
        super.key,
        required this.voidBtnSelectPhoto,
        this.firstName,
        this.lastName,
        this.facName,
        this.pictureUrl,
        this.pictureBase64,
      });

  // ⭐️ Helper method สำหรับสร้างรูปโปรไฟล์ (รับขนาดเข้ามา) - ปรับปรุงไม่ให้มีเส้นขอบ/พื้นหลัง ⭐️
  Widget _buildProfileImage(double imageSize) {
    Widget imageWidget;
    const String defaultAsset = 'assets/item/people.png';

    // 1. ตรวจสอบ Base64
    if (pictureBase64 != null && pictureBase64!.isNotEmpty) {
      try {
        final imageBytes = base64Decode(pictureBase64!);
        imageWidget = Image.memory(
          imageBytes,
          fit: BoxFit.cover,
        );
      } catch (e) {
        debugPrint('Error decoding Base64 image in SettingProfileCard: $e');
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
    // 3. ใช้ Icon/Asset เริ่มต้น
    else {
      // ใช้ Icon ธรรมดาเป็น Fallback เมื่อไม่มีข้อมูลรูปภาพ
      imageWidget = Icon(
        Icons.account_circle,
        size: imageSize, // ใช้ขนาดเต็มเพื่อให้ Icon เต็มพื้นที่
        color: Colors.black,
      );
    }

    // ⭐️ โค้ดที่เปลี่ยน: ลบ Decoration/Border ออก ⭐️
    return Container(
      width: imageSize,
      height: imageSize,
      // ไม่ต้องมี decoration: BoxDecoration(...)
      child: ClipOval(
        // ห่อหุ้มด้วย ClipOval เพื่อให้รูปภาพเป็นวงกลม
        child: imageWidget,
      ),
    );
  }


  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    // กำหนดขนาดโปรไฟล์ เช่น 15% ของความกว้างหน้าจอ
    final double profileSize = screenWidth * 0.15; // ⬅️ ขนาดที่ต้องการ
    // กำหนดขนาดไอคอนกล้อง เช่น 40% ของขนาดโปรไฟล์
    final double cameraButtonSize = profileSize * 0.4;
    final double cameraIconSize = cameraButtonSize * 0.6;

    final disPlayFirstName = firstName ?? "";
    final disPlayLastName  = lastName ?? "";
    final disPlayFacName   = facName ?? "";

    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 20),
      child: Card(
        color: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 1. รูปโปรไฟล์และปุ่มถ่ายรูป
              Stack(
                clipBehavior: Clip.none,
                children: [

                  // ⭐️ แทนที่ Icon เดิมด้วย _buildProfileImage ⭐️
                  _buildProfileImage(profileSize),

                  // ปุ่มเปลี่ยนรูปโปรไฟล์ (อยู่ด้านขวา/ล่างของรูปโปรไฟล์)
                  Positioned(
                    bottom: -5,
                    right: -5,
                    child: InkWell(
                      onTap: voidBtnSelectPhoto,
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
                children: [
                  Text(
                    '$disPlayFirstName $disPlayLastName',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Kanit',
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    disPlayFacName,
                    style: const TextStyle(
                      fontSize: 14,
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