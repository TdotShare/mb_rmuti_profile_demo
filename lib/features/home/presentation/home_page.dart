// lib/features/home/presentation/home_page.dart
import 'package:flutter/material.dart';
import 'package:mb_rmuti_profile_demo/features/home/widgets/home_content_widget.dart';

import 'package:mb_rmuti_profile_demo/features/profile/presentation/profile_page.dart';
import 'package:mb_rmuti_profile_demo/features/setting/presentation/setting_page.dart';

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

  // สร้าง list ของ widget navigator (Offstage approach)
  Widget _buildOffstageNavigator(int index) {
    late Widget child;
    if (index == 0) {
      child = HomeContentWidget();
    } else if (index == 1) {
      child = const ProfilePage();
    } else {
      child = const SettingPage();
    }

    return Offstage(
      offstage: _currentIndex != index,
      child: Navigator(
        key: _navigatorKeys[index],
        onGenerateRoute: (RouteSettings settings) {
          return MaterialPageRoute(builder: (_) => child, settings: settings);
        },
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