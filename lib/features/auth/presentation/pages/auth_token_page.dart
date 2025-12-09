// auth_token_page.dart

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mb_rmuti_profile_demo/features/auth/presentation/widgets/auth_applogo_widget.dart';
import 'package:mb_rmuti_profile_demo/features/auth/presentation/widgets/auth_button_section_widget.dart';
import 'package:mb_rmuti_profile_demo/routes/app_router.dart';
import 'package:mb_rmuti_profile_demo/routes/auth_router.dart';

// SliverFadeTransition: wrapper สำหรับ FadeTransition
class SliverFadeTransition extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;

  const SliverFadeTransition({
    super.key,
    required this.animation,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}

// WhiteWaveClipper (ปรับปรุงสัดส่วน Y-coordinate เพื่อให้คลื่นอยู่ต่ำลง)
class WhiteWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.55); // ปรับจาก 0.60

    final controlPoint1 = Offset(size.width * 0.75, size.height * 0.55); // ปรับจาก 0.60
    final controlPoint2 = Offset(size.width * 0.10, size.height * 0.95);
    final endPoint = Offset(0, size.height * 0.60); // ปรับจาก 0.65

    path.cubicTo(
      controlPoint1.dx, controlPoint1.dy,
      controlPoint2.dx, controlPoint2.dy,
      endPoint.dx, endPoint.dy,
    );

    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

// BackWaveClipper (ปรับปรุงสัดส่วน Y-coordinate เพื่อให้คลื่นอยู่ต่ำลง)
class BackWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.57); // ปรับจาก 0.62

    final controlPoint1 = Offset(size.width * 0.75, size.height * 0.57); // ปรับจาก 0.62
    final controlPoint2 = Offset(size.width * 0.10, size.height * 0.97);
    final endPoint = Offset(0, size.height * 0.62); // ปรับจาก 0.67

    path.cubicTo(
      controlPoint1.dx, controlPoint1.dy,
      controlPoint2.dx, controlPoint2.dy,
      endPoint.dx, endPoint.dy,
    );

    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

class AuthTokenPage extends StatefulWidget {
  const AuthTokenPage({super.key});

  @override
  State<AuthTokenPage> createState() => _AuthTokenPageState();
}

class _AuthTokenPageState extends State<AuthTokenPage> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;
  bool _isLoaded = false;
  bool _hasError = false;

  // Dio instance (สามารถแชร์/ตั้งค่าได้ที่นี่)
  final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      // ถ้าต้องการ headers ใช้ options
      headers: {
        'Accept': 'application/json',
      },
    ),
  );

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    // เริ่มโหลด API
    _fetchApiWithDio();
  }

  Future<void> _fetchApiWithDio() async {
    const url = 'https://pokeapi.co/api/v2/pokemon-form/132/';
    setState(() {
      _isLoaded = false;
      _hasError = false;
    });

    try {
      final response = await _dio.get(url);
      // Dio returns Response with statusCode
      if (response.statusCode == 200) {
        // (ถ้าต้องการ) parse response.data
        // final data = response.data;
        if (!mounted) return;
        setState(() {
          _isLoaded = true;
          _hasError = false;
        });
        _controller.forward();
      } else {
        // กรณี status != 200
        if (!mounted) return;
        setState(() {
          _hasError = true;
        });
      }
    } on DioException catch (dioErr) {
      // แยกกรณี error ให้ชัดเจน ถ้าต้องการ debug สามารถ inspect dioErr.type / dioErr.response
      debugPrint('DioException: ${dioErr.type} - ${dioErr.message}');
      if (dioErr.response != null) {
        debugPrint('Dio response status: ${dioErr.response?.statusCode}');
        debugPrint('Dio response data: ${dioErr.response?.data}');
      }
      if (!mounted) return;
      setState(() {
        _hasError = true;
      });
    } catch (e) {
      debugPrint('Unexpected error: $e');
      if (!mounted) return;
      setState(() {
        _hasError = true;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _dio.close(); // ปิด Dio client (optional)
    super.dispose();
  }

  void _onPressedSso() {
    debugPrint('SSO pressed');
  }

  void _onPressedOfficer() {
    AppRouter.push(context, AuthRoutes.authLoginOfficer);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double clippedContainerHeight = size.height * 1.15;



    return Scaffold(
      body: Stack(
        children: [
          // 1) พื้นหลังส้มเต็มจอ (Orange Gradient)
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 248, 199, 135),
                  Color.fromARGB(255, 255, 136, 0),
                ],
              ),
            ),
          ),

          // 2) คลื่น Layer หลัง
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height: clippedContainerHeight,
              child: ClipPath(
                clipper: BackWaveClipper(),
                child: Container(color: const Color.fromRGBO(255, 246, 122, 1)),
              ),
            ),
          ),

          // 3) คลื่น Layer หน้า (สีขาว)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height: clippedContainerHeight,
              child: ClipPath(
                clipper: WhiteWaveClipper(),
                child: Container(
                  color: Colors.white,
                  child: SafeArea(
                    bottom: false,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 160),
                        // ส่ง calculatedLogoSize เข้าไป
                        AuthAppLogoWidget(),

                        // แสดงปุ่มเมื่อโหลดสำเร็จ (fade-in)
                        if (_isLoaded)
                          SliverFadeTransition(
                            animation: _animation,
                            child: AuthButtonSectionWidget(
                              btnLoginOfficer: 1,
                              btnLoginSso: 1,
                              voidBtnLoginSso: _onPressedSso,
                              voidBtnLoginOfficer: _onPressedOfficer,
                            ),
                          )
                        else
                          const SizedBox(height: 24),

                        Expanded(child: Container()),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // 4) ข้อความ + loader ด้านหน้า (แสดงสถานะโหลด/ข้อผิดพลาด)
          Positioned(
            left: 0,
            right: 0,
            top: size.height * 0.88,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!_isLoaded && !_hasError) ...[
                  const Text(
                    'กำลังโหลดข้อมูล',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Kanit',
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const SizedBox(
                    width: 36,
                    height: 36,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                ] else if (_hasError) ...[
                  const Text(
                    'เกิดข้อผิดพลาดในการโหลดข้อมูล',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Kanit',
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _hasError = false;
                      });
                      _fetchApiWithDio();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF8A00),
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('ลองใหม่'),
                  ),
                ] else ...[
                  const SizedBox.shrink(),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}