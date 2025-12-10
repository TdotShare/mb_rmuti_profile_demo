import 'package:mb_rmuti_profile_demo/features/home/data/models/home_user_notification_list_model.dart';

// ไฟล์: home_repository.dart
class HomeRepository {

  Future<List<HomeUserNotificationListModel>> getNotificationList() async {
    
    // **สำคัญ:** เพิ่มความหน่วง 1-2 วินาที เพื่อจำลองการเรียก API
    await Future.delayed(const Duration(seconds: 1)); // <--- เพิ่มบรรทัดนี้

    return [
      HomeUserNotificationListModel(title: "Alert 1", detail: "Detail 1"),
      HomeUserNotificationListModel(title: "Alert 2", detail: "Detail 2"),
    ];
  }
  
}