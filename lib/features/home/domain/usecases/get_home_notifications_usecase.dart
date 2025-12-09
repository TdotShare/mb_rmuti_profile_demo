// domain/usecases/get_home_notifications_usecase.dart

import 'package:mb_rmuti_profile_demo/features/home/domain/entities/home_notification_entity.dart';
import 'package:mb_rmuti_profile_demo/features/home/domain/repositories/home_repository.dart';


class GetHomeNotificationsUsecase {
  final HomeRepository repository;

  GetHomeNotificationsUsecase(this.repository);

  // เมธอดสำหรับรัน Use Case
  Future<List<HomeNotificationEntity>> call() async {
    return await repository.getNotifications();
  }
}