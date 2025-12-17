// lib/routes/app_router.dart
import 'package:flutter/material.dart';
import 'package:mb_rmuti_profile_demo/routes/auth_router.dart';
import 'package:mb_rmuti_profile_demo/routes/service_access_router.dart';

class AppRouter {
  static final Map<String, WidgetBuilder> _routes = {
    ...AuthRouter.routes,
    ...ServiceAccessRouter.routes,
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final name = settings.name;
    final builder = _routes[name];

    if (builder != null) {
      return MaterialPageRoute(
        builder: (context) => builder(context),
        settings: settings,
      );
    }

    return MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(title: const Text('Page not found')),
        body: Center(child: Text('Unknown route: $name')),
      ),
      settings: settings,
    );
  }

  // ปรับปรุง Helper เพื่อให้ใช้งานง่ายและปลอดภัยขึ้น

  static void pushReplacement(BuildContext context, String routeName, {Object? arguments}) {
    Navigator.of(context).pushReplacementNamed(routeName, arguments: arguments);
  }
  
  static void pushAndRemoveAll(BuildContext context, String routeName, {Object? arguments}) {
    // ใช้ rootNavigator: true เพื่อให้มั่นใจว่าล้างทั้งแอปจริงๆ
    Navigator.of(context, rootNavigator: true)
        .pushNamedAndRemoveUntil(routeName, (route) => false, arguments: arguments);
  }

  static Future<T?> push<T>(BuildContext context, String routeName, {Object? arguments}) {
    return Navigator.of(context).pushNamed<T>(routeName, arguments: arguments);
  }

  // ปรับ pushAuthOauth ให้เรียกใช้ผ่านระบบ Named Route แทนเพื่อความสม่ำเสมอ
  static Future<Map<String, String>?> pushAuthOauth(BuildContext context) {
    return Navigator.of(context).pushNamed<Map<String, String>>(AuthRoutes.authOauth);
  }
}