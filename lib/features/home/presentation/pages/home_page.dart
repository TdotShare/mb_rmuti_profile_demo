// lib/features/home/presentation/home_page.dart
import 'package:flutter/material.dart';
// ลบ HomeContentWidget, ServiceAccessPage ออก (ถูกจัดการใน HomeTabRouter)
import 'package:mb_rmuti_profile_demo/features/profile/presentation/pages/profile_page.dart';
import 'package:mb_rmuti_profile_demo/features/setting/presentation/pages/setting_page.dart';
// 🚀 เพิ่ม HomeTabRouter เข้ามา
import 'package:mb_rmuti_profile_demo/routes/home_tab_router.dart'; 

/// หน้า Home หลักที่มี BottomNavigationBar คงอยู่ตลอด
/// แต่ละ tab จะมี Navigator แยกของตัวเอง (preserve state)
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // index ของ bottom nav
  int _currentIndex = 0;

  // สร้าง Navigator keys สำหรับแต่ละ tab
  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(), // Home
    GlobalKey<NavigatorState>(), // Profile
    GlobalKey<NavigatorState>(), // Setting
  ];

  // ❌ ลบ _homeRouteBuilder ออกไป

  // สร้าง list ของ widget navigator (Offstage approach)
  Widget _buildOffstageNavigator(int index) {
    // กำหนด RouteSettings และ Builder สำหรับแต่ละ Tab
    const RouteSettings initialSettings = RouteSettings(name: '/');
    RouteFactory routeFactory;

    if (index == 0) {
      // 🚀 ใช้ HomeTabRouter.generateRoute สำหรับ Tab Home (Index 0)
      routeFactory = HomeTabRouter.generateRoute;
    } else if (index == 1) {
      // สำหรับ Tab อื่นๆ ใช้ builder เดิม
      routeFactory = (settings) => MaterialPageRoute(builder: (_) => const ProfilePage(), settings: settings);
    } else {
      routeFactory = (settings) => MaterialPageRoute(builder: (_) => const SettingPage(), settings: settings);
    }

    return Offstage(
      offstage: _currentIndex != index,
      child: Navigator(
        key: _navigatorKeys[index],
        initialRoute: initialSettings.name, // กำหนด Route เริ่มต้น '/'
        onGenerateRoute: routeFactory, // ใช้งาน Route Factory ที่กำหนด
      ),
    );
  }

  // ถ้ากด back (Android) จะพิจารณาจาก nested navigator ก่อน
  Future<bool> _onWillPop() async {
    final NavigatorState currentNavigator =
        _navigatorKeys[_currentIndex].currentState!;
    if (currentNavigator.canPop()) {
      currentNavigator.pop();
      return false; // ไม่ให้ระบบ pop เพิ่มเติม
    } else {
      if (_currentIndex != 0) {
        setState(() {
          _currentIndex = 0; // กลับไป tab หลักก่อน
        });
        return false; // ไม่ออกแอป
      }
    }
    return true; // อนุญาตให้ระบบออกแอป (pop root)
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        // AppBar สามารถวางไว้ที่แต่ละ tab ถ้าต้องการต่างกัน
        body: Stack(
          children: [
            _buildOffstageNavigator(0),
            _buildOffstageNavigator(1),
            _buildOffstageNavigator(2),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            if (index == _currentIndex) {
              // ถ้ากด tab เดิม ให้ pop to first route ของ nested navigator
              _navigatorKeys[index].currentState?.popUntil(
                (route) => route.isFirst,
              );
            } else {
              setState(() {
                _currentIndex = index;
              });
            }
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'หน้าหลัก'),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'โปรไฟล์',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'ตั้งค่า',
            ),
          ],
        ),
      ),
    );
  }
}