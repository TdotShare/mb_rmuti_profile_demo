import 'package:flutter/material.dart';
import 'package:mb_rmuti_profile_demo/core/widgets/profile_image/profile_image_widget.dart';

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



  @override
  Widget build(BuildContext context) {
    // 3. การแสดงผลข้อความ: ใช้ Null-aware operator (??) เพื่อแสดงค่าเริ่มต้น
    final String displayFirstName = firstName ?? 'ทดสอบ';
    final String displayLastName = lastName ?? 'ทดสอบ';
    final String displayFacName = facName ?? 'ทดสอบ';
    const double imageSize = 75;

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

              ProfileImageWidget(
                imageSize: imageSize,
                pictureUrl: pictureUrl,
                pictureBase64: pictureBase64,
              ),
            ],
          ),
        ),
      ),
    );
  }
}