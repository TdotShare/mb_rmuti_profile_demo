

class HomeUserNotificationListModel {
  final int id;
  final String title;
  final String detail;

  const HomeUserNotificationListModel({
    required this.id,
    required this.title,
    required this.detail,
  });

  // Factory Constructor สำหรับแปลง JSON/Map เป็น Model
  factory HomeUserNotificationListModel.fromJson(Map<String, dynamic> json) {
    return HomeUserNotificationListModel(
      id : json['id'] as int,
      title: json['title'] as String,
      detail: json['detail'] as String,
    );
  }
}