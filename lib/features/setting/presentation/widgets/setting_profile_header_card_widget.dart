import 'package:flutter/material.dart';
import 'package:mb_rmuti_profile_demo/core/widgets/profile_image/profile_image_widget.dart'; // <--- เพิ่มสำหรับการถอดรหัส Base64

class SettingProfileHeaderCard extends StatelessWidget {
  final VoidCallback voidBtnSelectPhoto;
  final String? firstName;
  final String? lastName;
  final String? facName;
  final String? pictureUrl;
  final String? pictureBase64;

  const SettingProfileHeaderCard({
    super.key,
    required this.voidBtnSelectPhoto,
    this.firstName,
    this.lastName,
    this.facName,
    this.pictureUrl,
    this.pictureBase64,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // กำหนดขนาดโปรไฟล์ เช่น 15% ของความกว้างหน้าจอ
    final double profileSize = screenWidth * 0.15; // ⬅️ ขนาดที่ต้องการ
    // กำหนดขนาดไอคอนกล้อง เช่น 40% ของขนาดโปรไฟล์
    final double cameraButtonSize = profileSize * 0.4;
    final double cameraIconSize = cameraButtonSize * 0.6;

    final disPlayFirstName = firstName ?? "";
    final disPlayLastName = lastName ?? "";
    final disPlayFacName = facName ?? "";

    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 20),
      child: Card(
        color: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Stack(
                clipBehavior: Clip.none,
                children: [

                  ProfileImageWidget(
                    imageSize: profileSize,
                    pictureUrl: pictureUrl,
                    pictureBase64: pictureBase64,
                  ),


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
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ), // Border สีขาว
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

 
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize:
                      MainAxisSize.min, // เพิ่มเพื่อความชัดเจน (optional)
                  children: [
                    Text(
                      '$disPlayFirstName $disPlayLastName',
                      overflow: TextOverflow.ellipsis, // ⭐️ เพิ่มการตัดคำ ⭐️
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,

                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      disPlayFacName,
                      overflow: TextOverflow.ellipsis, // ⭐️ เพิ่มการตัดคำ ⭐️
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
