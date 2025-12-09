// data/datasources/home_remote_data_source.dart


// Interface Data Source
import 'package:mb_rmuti_profile_demo/features/home/data/models/notification_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<HomeNotificationModel>> fetchNotifications();
}

// Implementation Data Source (จะมีการเรียกใช้ HTTP Client จริงๆ ในนี้)
class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  // (สมมติว่ามีการ Inject HTTP Client เข้ามา)

  @override
  Future<List<HomeNotificationModel>> fetchNotifications() async {
    // โค้ด HTTP Request ไปยัง API
    // ...
    // Map response JSON List to List<HomeNotificationModel>
    // return parsedList;

    // ตัวอย่าง Mock Data ที่ส่งคืน Model
    return [
      HomeNotificationModel(title: "Alert 1", detail: "Detail 1"),
      HomeNotificationModel(title: "Alert 2", detail: "Detail 2"),
    ];
  }
}