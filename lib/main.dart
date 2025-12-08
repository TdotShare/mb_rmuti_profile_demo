// lib/main.dart
import 'package:flutter/material.dart';
import 'routes/app_router.dart'; // import แบบ relative path

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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

      // initial route (หน้าแรกของแอป)
      initialRoute: '/',

      // ใช้ onGenerateRoute จาก AppRouter
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
