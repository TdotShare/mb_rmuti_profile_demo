// lib/routes/home_tab_router.dart
import 'package:flutter/material.dart';
import 'package:mb_rmuti_profile_demo/features/home/presentation/widgets/home_content_widget.dart';
import 'package:mb_rmuti_profile_demo/features/service_access/presentation/pages/service_access_page.dart'; 
import 'package:mb_rmuti_profile_demo/routes/service_access_router.dart'; // ใช้ ServiceAccessRouters

class HomeTabRouter {
  // Map ที่เก็บชื่อ Route (String) และ Widget Builder (Function)
  static final Map<String, WidgetBuilder> routes = {
    
    // 1. หน้าหลักของ Tab (Initial Route)
    '/': (context) => SafeArea(
        top: false, 
        child: HomeContentWidget(), // HomeContentWidget ไม่สามารถเป็น const ได้
      ),

    // 2. หน้าบริการทั้งหมด
    // ใช้ชื่อ Route ที่กำหนดไว้ใน ServiceAccessRouters เพื่อความสอดคล้อง
    //ServiceAccessRouters.serviceAccess: (context) => const ServiceAccessPage(),

    // 🚀 เพิ่มหน้าใหม่ๆ สำหรับ Tab Home ในอนาคตที่นี่
    // '/new-page-in-home-tab': (context) => const NewPageInHomeTab(),
  };

  // เมธอดสำหรับสร้าง Route โดยเฉพาะ
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // หา Builder Function จากชื่อ Route ที่ถูกส่งเข้ามา
    final WidgetBuilder? builder = routes[settings.name];

    if (builder != null) {
      return MaterialPageRoute(
        builder: builder,
        settings: settings,
      );
    }

    // ถ้าไม่พบ Route, ให้ Fallback กลับไปหน้าหลักของ Tab
    return MaterialPageRoute(
      builder: routes['/']!, // ใช้ Builder หน้าหลัก
      settings: const RouteSettings(name: '/'),
    );
  }
}