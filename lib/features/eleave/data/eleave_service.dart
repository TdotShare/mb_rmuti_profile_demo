import 'package:dio/dio.dart';
import 'package:mb_rmuti_profile_demo/features/eleave/data/models/leave_right_model.dart';

class EleaveService {
  final Dio _dio = Dio();

  Future<List<LeaveRightModel>> fetchLeaveRights(String username) async {
    try {
      final response = await _dio.get(
        'https://staff.rmuti.ac.th/elv/public/api/getLeaveRightUser',
        queryParameters: {'username': username},
      );

      if (response.statusCode == 200) {
        // Dio จะทำการถอดรหัส JSON ให้โดยอัตโนมัติ (ไม่ต้องใช้ jsonDecode)
        final List data = response.data;
        return data.map((item) => LeaveRightModel.fromJson(item)).toList();
      }
      return [];
    } on DioException catch (e) {
      // จัดการ Error เช่น Timeout หรือ Server พัง
      throw Exception('ไม่สามารถดึงข้อมูลได้: ${e.message}');
    }
  }
}