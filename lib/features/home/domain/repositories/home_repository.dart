// domain/repositories/home_repository.dart
import 'package:mb_rmuti_profile_demo/features/home/domain/entities/home_notification_entity.dart';

abstract class HomeRepository {
  // สัญญา: ต้องมีเมธอดที่ส่งคืน List ของ Entity
  Future<List<HomeNotificationEntity>> getNotifications();
}