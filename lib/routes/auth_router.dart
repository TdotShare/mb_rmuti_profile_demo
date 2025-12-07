// lib/routes/auth_router.dart
import 'package:flutter/material.dart';
import 'package:mb_rmuti_profile_demo/features/auth/presentation/auth_token_page.dart';
import 'package:mb_rmuti_profile_demo/features/auth/presentation/auth_login_officer_page.dart';
import 'package:mb_rmuti_profile_demo/features/home/presentation/home_page.dart';

/// — ชื่อนี้เป็นที่เดียวเก็บชื่อ route ของ auth —
class AuthRoutes {
  static const String authToken = '/';
  static const String authLoginOfficer = '/auth/login-officer';
  static const String home = '/home'; // Home ถูกวางไว้ใน auth ด้วยเพื่อความสะดวก
}

/// Map ของ routes ที่เกี่ยวข้องกับ auth (WidgetBuilder)
class AuthRouter {
  static final Map<String, WidgetBuilder> routes = {
    AuthRoutes.authToken: (_) => const AuthTokenPage(),
    AuthRoutes.authLoginOfficer: (_) => const AuthLoginOfficerPage(),
    // Home page สามารถอยู่ไฟล์ home_router แต่ผมใส่ตัวอย่างไว้ที่นี่เพื่อให้ใช้ได้ทันที
    AuthRoutes.home: (_) => const HomePage(),
  };
}
