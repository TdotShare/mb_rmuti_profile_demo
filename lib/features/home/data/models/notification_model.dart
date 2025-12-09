// Class ที่ใช้รับข้อมูลจาก API (ควรใช้ final เพื่อ Immutability)
import 'package:mb_rmuti_profile_demo/features/home/domain/entities/home_notification_entity.dart';

class HomeNotificationModel {
  final String title;
  final String detail;

  const HomeNotificationModel({
    required this.title,
    required this.detail,
  });

  // Factory Constructor สำหรับแปลง JSON/Map เป็น Model
  factory HomeNotificationModel.fromJson(Map<String, dynamic> json) {
    return HomeNotificationModel(
      title: json['title'] as String,
      detail: json['detail'] as String,
    );
  }

  // Method สำหรับแปลง Model เป็น Entity (สิ่งที่สำคัญที่สุดใน Data Model)
  HomeNotificationEntity toEntity() {
    return HomeNotificationEntity(
      title: title,
      detail: detail,
    );
  }
}