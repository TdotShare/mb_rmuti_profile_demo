// profile.dart
import 'dart:convert';

class AuthUserProfile {
  // ปริมาณฟิลด์ตาม JSON ที่ให้มา (flat)
  final String id;
  final int? code;
  final String? type;
  final String? degree;

  final String? prefixEn;
  final String? firstNameEn;
  final String? lastNameEn;

  final String? prefixTh;
  final String? firstNameTh;
  final String? lastNameTh;

  final String? gender;

  final String? facultyId;
  final String? facultyNameEn;
  final String? facultyNameTh;

  final String? departmentId;
  final String? departmentNameEn;
  final String? departmentNameTh;

  final int? studyYear;
  final String? nickname;

  final String? email;
  final String? emailAlt;

  final String? status;
  final String? nationality;

  final String? picture;
  final String? pictureBase64;

  final DateTime? birthDate; // parsed from "birth_date" if possible
  final DateTime? lastUpdatedAt; // parsed from "last_updated_at" if possible

  final List<dynamic> teach;
  final List<dynamic> study;

  final String? custom1;
  final String? custom2;
  final String? custom3;

  final String? campusId;
  final int? curriculumId;
  final String? username;
  final String? citizenId;
  final String? passportId;
  final String? phone;

  final String? positionName;
  final String? positionNameMng;
  final String? positionNameAcademic;

  const AuthUserProfile({
    required this.id,
    this.code,
    this.type,
    this.degree,
    this.prefixEn,
    this.firstNameEn,
    this.lastNameEn,
    this.prefixTh,
    this.firstNameTh,
    this.lastNameTh,
    this.gender,
    this.facultyId,
    this.facultyNameEn,
    this.facultyNameTh,
    this.departmentId,
    this.departmentNameEn,
    this.departmentNameTh,
    this.studyYear,
    this.nickname,
    this.email,
    this.emailAlt,
    this.status,
    this.nationality,
    this.picture,
    this.pictureBase64,
    this.birthDate,
    this.lastUpdatedAt,
    this.teach = const [],
    this.study = const [],
    this.custom1,
    this.custom2,
    this.custom3,
    this.campusId,
    this.curriculumId,
    this.username,
    this.citizenId,
    this.passportId,
    this.phone,
    this.positionName,
    this.positionNameMng,
    this.positionNameAcademic,
  });

  // Helpers
  static int? _toInt(dynamic v) {
    if (v == null) return null;
    if (v is int) return v;
    if (v is String) {
      return int.tryParse(v);
    }
    if (v is double) return v.toInt();
    return null;
  }

  static DateTime? _toDateTime(dynamic v) {
    if (v == null) return null;
    if (v is DateTime) return v;
    if (v is String && v.isNotEmpty) {
      // พยายาม parse ISO-like first, ถ้าไม่สำเร็จลองแบบ yyyy-MM-dd
      try {
        return DateTime.parse(v);
      } catch (_) {
        // พยายาม parse แบบ yyyy-MM-dd
        try {
          final parts = v.split(RegExp(r'[^0-9]'));
          if (parts.length >= 3) {
            final y = int.tryParse(parts[0]) ?? 0;
            final m = int.tryParse(parts[1]) ?? 1;
            final d = int.tryParse(parts[2]) ?? 1;
            return DateTime(y, m, d);
          }
        } catch (_) {}
      }
    }
    return null;
  }

  // fromJson - รับ Map ที่มาจาก jsonDecode(...)
  factory AuthUserProfile.fromJson(Map<String, dynamic> json) {
    return AuthUserProfile(
      id: json['id']?.toString() ?? '',
      code: _toInt(json['code']),
      type: json['type']?.toString(),
      degree: json['degree']?.toString(),
      prefixEn: json['prefix_en']?.toString(),
      firstNameEn: json['first_name_en']?.toString(),
      lastNameEn: json['last_name_en']?.toString(),
      prefixTh: json['prefix_th']?.toString(),
      firstNameTh: json['first_name_th']?.toString(),
      lastNameTh: json['last_name_th']?.toString(),
      gender: json['gender']?.toString(),
      facultyId: json['faculty_id']?.toString(),
      facultyNameEn: json['faculty_name_en']?.toString(),
      facultyNameTh: json['faculty_name_th']?.toString(),
      departmentId: json['department_id']?.toString(),
      departmentNameEn: json['department_name_en']?.toString(),
      departmentNameTh: json['department_name_th']?.toString(),
      studyYear: _toInt(json['study_year']),
      nickname: json['nickname']?.toString(),
      email: json['email']?.toString(),
      emailAlt: json['email_alt']?.toString(),
      status: json['status']?.toString(),
      nationality: json['nationality']?.toString(),
      picture: json['picture']?.toString(),
      pictureBase64: json['picture_base64']?.toString(),
      birthDate: _toDateTime(json['birth_date']),
      lastUpdatedAt: _toDateTime(json['last_updated_at']),
      teach: (json['teach'] is List) ? List<dynamic>.from(json['teach']) : [],
      study: (json['study'] is List) ? List<dynamic>.from(json['study']) : [],
      custom1: json['custom1']?.toString(),
      custom2: json['custom2']?.toString(),
      custom3: json['custom3']?.toString(),
      campusId: json['campus_id']?.toString(),
      curriculumId: _toInt(json['curriculum_id']),
      username: json['username']?.toString(),
      citizenId: json['citizen_id']?.toString(),
      passportId: json['passport_id']?.toString(),
      phone: json['phone']?.toString(),
      positionName: json['position_name']?.toString(),
      positionNameMng: json['position_name_mng']?.toString(),
      positionNameAcademic: json['position_name_academic']?.toString(),
    );
  }

  // toJson - แปลงกลับเป็น Map<string,dynamic> โดยใช้ key เดิม (snake_case)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'type': type,
      'degree': degree,
      'prefix_en': prefixEn,
      'first_name_en': firstNameEn,
      'last_name_en': lastNameEn,
      'prefix_th': prefixTh,
      'first_name_th': firstNameTh,
      'last_name_th': lastNameTh,
      'gender': gender,
      'faculty_id': facultyId,
      'faculty_name_en': facultyNameEn,
      'faculty_name_th': facultyNameTh,
      'department_id': departmentId,
      'department_name_en': departmentNameEn,
      'department_name_th': departmentNameTh,
      'study_year': studyYear,
      'nickname': nickname,
      'email': email,
      'email_alt': emailAlt,
      'status': status,
      'nationality': nationality,
      'picture': picture,
      'picture_base64': pictureBase64,
      'birth_date': birthDate?.toIso8601String(),
      'last_updated_at': lastUpdatedAt?.toIso8601String(),
      'teach': teach,
      'study': study,
      'custom1': custom1,
      'custom2': custom2,
      'custom3': custom3,
      'campus_id': campusId,
      'curriculum_id': curriculumId,
      'username': username,
      'citizen_id': citizenId,
      'passport_id': passportId,
      'phone': phone,
      'position_name': positionName,
      'position_name_mng': positionNameMng,
      'position_name_academic': positionNameAcademic,
    };
  }

  // ตัวช่วยเล็กๆ สำหรับ debug / print
  @override
  String toString() => 'Profile(id: $id, firstNameEn: $firstNameEn, lastNameEn: $lastNameEn)';
}
