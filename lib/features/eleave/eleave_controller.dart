import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mb_rmuti_profile_demo/features/eleave/data/eleave_service.dart';
import 'package:mb_rmuti_profile_demo/features/eleave/data/models/leave_right_model.dart';

/// Provider สำหรับตัว Service เอง
final eleaveServiceProvider = Provider<EleaveService>((ref) {
  return EleaveService();
});

/// Controller สำหรับจัดการ Logic ของหน้า E-Leave
class EleaveController {
  final Ref _ref;
  EleaveController(this._ref);

  /// ฟังก์ชันสำหรับดึงข้อมูล (ถ้าต้องการเรียกใช้แบบแมนนวล)
  Future<List<LeaveRightModel>> getLeaveRights(String username) async {
    final service = _ref.read(eleaveServiceProvider);
    return await service.fetchLeaveRights(username);
  }
}

/// Provider สำหรับ EleaveController
final eleaveControllerProvider = Provider<EleaveController>((ref) {
  return EleaveController(ref);
});

// -------------------------------------------------------------------------
// Data Binding Layer (ใช้ FutureProvider.family เพื่อความสะดวกในหน้า UI)
// -------------------------------------------------------------------------

/// Provider ที่ UI จะใช้ watch เพื่อแสดงผล
/// จะ Re-fetch ข้อมูลอัตโนมัติเมื่อ username เปลี่ยน
final leaveRightsProvider = FutureProvider.family<List<LeaveRightModel>, String>((ref, username) async {
  // เรียกผ่าน Controller เพื่อให้เป็นไปตาม Flow
  final controller = ref.watch(eleaveControllerProvider);
  return await controller.getLeaveRights(username);
});