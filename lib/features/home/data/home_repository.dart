import 'package:mb_rmuti_profile_demo/features/home/data/models/home_user_notification_list_model.dart';

// ไฟล์: home_repository.dart
class HomeRepository {

  Future<List<HomeUserNotificationListModel>> getNotificationList() async {
    
    // **สำคัญ:** เพิ่มความหน่วง 1-2 วินาที เพื่อจำลองการเรียก API
    await Future.delayed(const Duration(seconds: 1)); // <--- เพิ่มบรรทัดนี้

    return [
      HomeUserNotificationListModel(title: "แจ้งดำเนินการปิดปรับปรุง APP", detail: "เพื่อพัฒนาระบบให้ดียิ่งขึ้นจะทำการปิดปรับปรุง เวลา 20.00 น. วันที่ 9 ส.ค 68 เวลา 00.00 - 08.00 น."),
      HomeUserNotificationListModel(title: "ดำเนินการแจ้งการเปิดพื้นที่", detail: "เมื่อวันที่ XX ส.ค 68 คุณได้ส่งคำขอเปิดพื้นที่ faculty-ait ทางทีมงานเครือข่ายได้ดำเนินการเรียบร้อย"),
    ];
  }
  
}