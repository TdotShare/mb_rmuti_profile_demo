// lib/routes/app_router.dart
import 'package:flutter/material.dart';



// นำเข้ารายการ route map ของแต่ละ feature
import 'package:mb_rmuti_profile_demo/routes/auth_router.dart';
import 'package:mb_rmuti_profile_demo/routes/service_access_router.dart';


/// รวม routes จากทุก router ย่อยเป็น map เดียว
class AppRouter {
  // เก็บ map ของทั้งหมด
  static final Map<String, WidgetBuilder> _routes = {
    ...AuthRouter.routes,
    ...ServiceAccessRouter.routes,
  };

  /// เรียกใช้จาก MaterialApp.onGenerateRoute
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final name = settings.name;

    // หา widget builder จาก map
    final builder = _routes[name];
    if (builder != null) {
      return MaterialPageRoute(
        builder: (context) => builder(context),
        settings: settings,
      );
    }

    // กรณีไม่พบ route ให้แสดง 404 แบบง่าย
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(title: const Text('Page not found')),
        body: Center(child: Text('Unknown route: $name')),
      ),
      settings: settings,
    );
  }

  /// helper สำหรับล้าง stack แล้วไปหน้าใหม่ (เช่น Login -> Home ไม่ย้อนกลับ)
  static void pushAndRemoveAll(BuildContext context, String routeName, {Object? arguments}) {
    Navigator.of(context).pushNamedAndRemoveUntil(routeName, (route) => false, arguments: arguments);
  }

  /// helper สำหรับแทนที่หน้าปัจจุบันด้วยหน้าใหม่ (ไม่ย้อนกลับไปหน้าเดิม)
  static void pushReplacement(BuildContext context, String routeName, {Object? arguments}) {
    Navigator.of(context).pushReplacementNamed(routeName, arguments: arguments);
  }

  /// helper ปกติ push (ย้อนกลับได้)
  static Future<T?> push<T>(BuildContext context, String routeName, {Object? arguments}) {
    return Navigator.of(context).pushNamed<T>(routeName, arguments: arguments);
  }
}
