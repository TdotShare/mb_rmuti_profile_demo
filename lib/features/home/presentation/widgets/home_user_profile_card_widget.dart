import 'package:flutter/material.dart';
import 'package:mb_rmuti_profile_demo/core/widgets/profile_image/profile_image_widget.dart';

class HomeUserProfileCardWidget extends StatelessWidget {
  final double overlapSize;
  final double infoCardHeight;
  final VoidCallback btnServiceAccess;
  final String? firstName, lastName, facName, pictureUrl, pictureBase64;

  const HomeUserProfileCardWidget({
    super.key, required this.overlapSize, required this.infoCardHeight,
    required this.btnServiceAccess, this.firstName, this.lastName, this.facName, this.pictureUrl, this.pictureBase64,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: overlapSize,
      left: 20, right: 20, // เพิ่ม margin ซ้ายขวา
      child: Container(
        height: infoCardHeight,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 20, offset: const Offset(0, 10)),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'สวัสดี, ${firstName ?? "นักศึกษา"}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    facName ?? 'คณะเทคโนโลยีการจัดการ',
                    style: const TextStyle(fontSize: 13, color: Colors.grey),
                    maxLines: 1, overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: btnServiceAccess,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF8A00).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text('ดูบริการทั้งหมด >', style: TextStyle(color: Color(0xFFFF8A00), fontSize: 12, fontWeight: FontWeight.bold)),
                    ),
                  )
                ],
              ),
            ),
            ProfileImageWidget(
              imageSize: 65,
              pictureUrl: pictureUrl,
              pictureBase64: pictureBase64,
            ),
          ],
        ),
      ),
    );
  }
}