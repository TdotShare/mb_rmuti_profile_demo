import 'package:flutter/material.dart';
import 'package:mb_rmuti_profile_demo/core/widgets/profile_image/profile_image_widget.dart';

class ProfileInfoCardWidget extends StatelessWidget {
  final String? firstName, lastName, codeId, facName, pictureUrl, pictureBase64;

  const ProfileInfoCardWidget({
    super.key,
    this.firstName,
    this.lastName,
    this.codeId,
    this.facName,
    this.pictureUrl,
    this.pictureBase64,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth * 0.92,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Stack(
          children: [
            // ลายน้ำจางๆ ด้านหลัง
            Positioned(
              right: -20,
              bottom: -20,
              child: Icon(
                Icons.school,
                size: 150,
                color: Colors.grey.withOpacity(
                  0.05,
                ), // ปรับให้จางมากๆ เป็นลายน้ำ
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  ProfileImageWidget(
                    imageSize: 100,
                    pictureUrl: pictureUrl,
                    pictureBase64: pictureBase64,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    '${firstName ?? ""} ${lastName ?? ""}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      "สถานะ: ปกติ",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  const Divider(height: 1),
                  const SizedBox(height: 20),
                  _buildInfoRow(
                    Icons.badge_outlined,
                    'รหัสประจำตัว',
                    codeId ?? "-",
                  ),
                  const SizedBox(height: 12),
                  _buildInfoRow(
                    Icons.account_balance_outlined,
                    'คณะ/สังกัด',
                    facName ?? "-",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.orange),
        const SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 11, color: Colors.grey),
            ),
            Text(
              value,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ],
    );
  }
}
