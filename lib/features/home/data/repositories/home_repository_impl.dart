// data/repositories/home_repository_impl.dart



import 'package:mb_rmuti_profile_demo/features/home/data/datasources/home_remote_data_source.dart';
import 'package:mb_rmuti_profile_demo/features/home/domain/entities/home_notification_entity.dart';
import 'package:mb_rmuti_profile_demo/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<HomeNotificationEntity>> getNotifications() async {
    // 1. เรียก Data Source เพื่อดึง List<Model>
    final notificationModels = await remoteDataSource.fetchNotifications();

    // 2. แปลง List<Model> ให้เป็น List<Entity> ก่อนส่งคืน
    return notificationModels.map((model) => model.toEntity()).toList();
  }
}