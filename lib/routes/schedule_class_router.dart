import 'package:flutter/material.dart';
import 'package:mb_rmuti_profile_demo/features/schedule_class/presentation/pages/schedule_class_page.dart';

class ScheduleClassRouters {
  static const String scheduleClassFirst = '/schedule-class';
}


/// Map ของ routes ที่เกี่ยวข้องกับ auth (WidgetBuilder)
class ScheduleClassRouter {
  static final Map<String, WidgetBuilder> routes = {
    ScheduleClassRouters.scheduleClassFirst : (_) => const ScheduleClassPage(),
  };
}
