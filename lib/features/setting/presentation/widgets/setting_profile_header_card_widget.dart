import 'package:flutter/material.dart';
import 'package:mb_rmuti_profile_demo/core/widgets/profile_image/profile_image_widget.dart';

class SettingProfileHeaderCard extends StatelessWidget {
  final VoidCallback voidBtnSelectPhoto;
  final String? firstName, lastName, facName, pictureUrl, pictureBase64;

  const SettingProfileHeaderCard({
    super.key,
    required this.voidBtnSelectPhoto,
    this.firstName, this.lastName, this.facName, this.pictureUrl, this.pictureBase64,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFF8A00), Color(0xFFFFB347)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: const Color(0xFFFF8A00).withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 8)),
        ],
      ),
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                ),
                child: ProfileImageWidget(
                  imageSize: 70,
                  pictureUrl: pictureUrl,
                  pictureBase64: pictureBase64,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: voidBtnSelectPhoto,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                    child: const Icon(Icons.camera_alt, size: 16, color: Color(0xFFFF8A00)),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${firstName ?? ""} ${lastName ?? ""}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                Text(
                  facName ?? "",
                  style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.9)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}