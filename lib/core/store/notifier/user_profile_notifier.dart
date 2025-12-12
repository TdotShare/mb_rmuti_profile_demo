import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mb_rmuti_profile_demo/core/store/states/user_profile_state.dart';


// 1. สร้าง Notifier Class
// Notifier จะจัดการ logic และเก็บสถานะ UserProfile
class UserProfileNotifier extends Notifier<UserProfileState> {
  // 1.1 build() ถูกเรียกครั้งแรกเพื่อกำหนดค่าเริ่มต้นของ State
  @override
  UserProfileState build() {
    // สถานะเริ่มต้นเมื่อแอปฯ เริ่มทำงาน (เช่น เป็นค่าว่างหรือเป็นค่าจาก Shared Preferences)
    return const UserProfileState();
  }

  // 2. สร้างเมธอดสำหรับเปลี่ยนสถานะ (Logic)

  /// ตั้งค่าโปรไฟล์ผู้ใช้ใหม่ทั้งหมด
  void setUserProfile(UserProfileState profile) {
    // 'state' คือสถานะปัจจุบันของ Notifier (UserProfile)
    state = profile;
  }

  /// อัปเดตข้อมูลบางส่วน
  void updatePicture(String newPictureUrl, String newBase64) {
    // ใช้ copyWith เพื่ออัปเดตเฉพาะฟิลด์ที่ต้องการ และคงค่าเดิมของฟิลด์อื่น ๆ ไว้
    state = state.copyWith(
      picture: newPictureUrl,
      pictureBase64: newBase64,
    );
  }

  /// ตั้งค่าสถานะเป็นค่าเริ่มต้น (Logout)
  void clearProfile() {
    state = const UserProfileState();
  }

  // เมธอดสำหรับโหลดข้อมูลจาก API (สมมติว่าคุณมีฟังก์ชันสำหรับ fetch ข้อมูล)
  Future<void> fetchAndSetProfile(Map<String, dynamic> jsonResponse) async {
    // สมมติว่านี่คือการเรียก API และได้รับ JSON มา
    final newProfile = UserProfileState.fromJson(jsonResponse);
    state = newProfile;
  }
}

// 3. สร้าง Global Provider
// นี่คือ Provider ที่ Widget จะใช้ในการเข้าถึง Notifier และ State
final userProfileProvider = NotifierProvider<UserProfileNotifier, UserProfileState>(
  UserProfileNotifier.new,
);