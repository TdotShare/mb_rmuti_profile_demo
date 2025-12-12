// user_profile_state.dart

class UserProfileState {
  final String? firstNameTh;
  final String? lastNameTh;
  final String? facultyNameTh;
  final String? picture;
  final String? pictureBase64;
  final String? citizenId;
  final int? code;

  // สถานะเริ่มต้น (เช่น ผู้ใช้ยังไม่เข้าสู่ระบบ)
  const UserProfileState({
    this.firstNameTh,
    this.lastNameTh,
    this.facultyNameTh,
    this.picture,
    this.pictureBase64,
    this.citizenId,
    this.code,
  });

  // ใช้สำหรับการคัดลอกสถานะเดิมและเปลี่ยนเฉพาะบางฟิลด์
  UserProfileState copyWith({
    String? firstNameTh,
    String? lastNameTh,
    String? facultyNameTh,
    String? picture,
    String? pictureBase64,
    String? citizenId,
    int? code,
  }) {
    return UserProfileState(
      firstNameTh: firstNameTh ?? this.firstNameTh,
      lastNameTh: lastNameTh ?? this.lastNameTh,
      facultyNameTh: facultyNameTh ?? this.facultyNameTh,
      picture: picture ?? this.picture,
      pictureBase64: pictureBase64 ?? this.pictureBase64,
      citizenId: citizenId ?? this.citizenId,
      code: code ?? this.code,
    );
  }

  // ตัวช่วยในการแปลงจาก Map (กรณีที่ได้รับข้อมูล JSON มา)
  factory UserProfileState.fromJson(Map<String, dynamic> json) {
    return UserProfileState(
      firstNameTh: json['first_name_th']?.toString(),
      lastNameTh: json['last_name_th']?.toString(),
      facultyNameTh: json['faculty_name_th']?.toString(),
      picture: json['picture']?.toString(),
      pictureBase64: json['picture_base64']?.toString(),
      citizenId: json['citizen_id']?.toString(),
      code: _toInt(json['code']), // ใช้ Helper ที่เราจะสร้าง
    );
  }
}

// Helper สำหรับแปลง dynamic เป็น int
int? _toInt(dynamic v) {
  if (v == null) return null;
  if (v is int) return v;
  if (v is String) {
    return int.tryParse(v);
  }
  if (v is double) return v.toInt();
  return null;
}