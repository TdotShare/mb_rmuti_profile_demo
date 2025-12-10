import 'package:mb_rmuti_profile_demo/features/home/data/home_repository.dart';
import 'package:mb_rmuti_profile_demo/features/home/data/models/home_user_notification_list_model.dart';

class HomeController {
  final HomeRepository _repository = HomeRepository();

  Future<List<HomeUserNotificationListModel>> getNotificationList() async { 

    final notificationList = await _repository.getNotificationList(); 
    return notificationList;
    
  }
}