// lib/routes/app_router.dart
import 'package:flutter/material.dart';
import 'package:mb_rmuti_profile_demo/features/auth/presentation/pages/auth_oauth.dart';



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
      // 💡 จุดที่แก้ไข: เราต้องใช้ RouteSettings.arguments เพื่อระบุ Type ให้กับ Route
      // ถ้า settings.arguments มีค่า (ซึ่งไม่มีในกรณีนี้) จะใช้ค่า dynamic แทน
      // สิ่งที่สำคัญคือการส่ง settings เข้าไปใน MaterialPageRoute

      // เราจะ Cast settings ให้เป็น RouteSettings<T> เพื่อให้ Navigator รู้จัก Type
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

  // 💡 NEW: Helper Method สำหรับ AuthOauth โดยเฉพาะ เพื่อรับค่ากลับแบบ Strong-typed
  static Future<Map<String, String>?> pushAuthOauth(BuildContext context) {
    return Navigator.of(context).push<Map<String, String>?>(
      MaterialPageRoute(
        builder: (context) => const AuthOauthPage(),
        // ใช้งานชื่อ route เดิมเพื่อประโยชน์ในการ Debugging/Monitoring (ถ้ามี)
        settings: const RouteSettings(name: AuthRoutes.authOauth),
      ),
    );
  }

}
