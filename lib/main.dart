// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:device_preview/device_preview.dart';
import 'routes/app_router.dart';

void main() {
  // **2. ห่อหุ้มแอปด้วย DevicePreview**
  runApp(
    DevicePreview(
      // เปิดใช้งาน DevicePreview
      enabled: true,

      // แสดงเครื่องมือ Default Tools เช่น การเปลี่ยนอุปกรณ์, Orientation, Theme
      tools: const [
        ...DevicePreview.defaultTools,
      ],

      // Builder ที่ใช้สำหรับห่อหุ้ม Widget หลักของแอป
      builder: (context) => const ProviderScope(
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 3. ใช้ DevicePreview.appBuilder และ DevicePreview.locale
    return MaterialApp(
      // ต้องใส่ 2 บรรทัดนี้เพื่อให้ DevicePreview ทำงานได้ถูกต้อง
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,

      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Kanit',
        textTheme: ThemeData.light().textTheme.apply(fontFamily: 'Kanit'),
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFF8A00)),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFF8A00),
            foregroundColor: Colors.white,
          ),
        ),
      ),
      initialRoute: '/',
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}