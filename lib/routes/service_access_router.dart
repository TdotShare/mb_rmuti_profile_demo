import 'package:flutter/material.dart';
import 'package:mb_rmuti_profile_demo/features/service_access/presentation/service_access_page.dart';


class ServiceAccessRouters {
  static const String serviceAccess = '/service-access';
}


/// Map ของ routes ที่เกี่ยวข้องกับ auth (WidgetBuilder)
class ServiceAccessRouter {
  static final Map<String, WidgetBuilder> routes = {
    ServiceAccessRouters.serviceAccess: (_) => const ServiceAccessPage(),
  };
}
