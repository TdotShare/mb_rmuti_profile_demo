import 'package:flutter/material.dart';
import 'package:mb_rmuti_profile_demo/features/auth/presentation/widgets/auth_login_form_widget.dart';
import 'package:mb_rmuti_profile_demo/features/auth/presentation/widgets/auth_applogo_widget.dart';
import 'package:mb_rmuti_profile_demo/routes/app_router.dart';
import 'package:mb_rmuti_profile_demo/routes/auth_router.dart';

class AuthLoginOfficerPage extends StatefulWidget {
  const AuthLoginOfficerPage({super.key});

  @override
  _AuthLoginOfficerPageState createState() => _AuthLoginOfficerPageState();
}

class _AuthLoginOfficerPageState extends State<AuthLoginOfficerPage> {
  void login(String username, String password) {
    AppRouter.push(context, AuthRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // ✅ เพิ่มพื้นหลังแบบไล่เฉดสี
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFFFF8A00).withOpacity(0.1),
              Colors.white,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: size.height * 0.12),
              // ส่วนโลโก้
              const AuthAppLogoWidget(),
              const SizedBox(height: 10),
              const Text(
                'ระบบเจ้าหน้าที่ (Officer)',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const Text(
                'กรุณาเข้าสู่ระบบเพื่อดำเนินการต่อ',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 30),
              // ✅ นำ Form ไปใส่ในพื้นที่จำกัดเพื่อให้ดูเป็น Card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: AuthLoginFormWidget(
                  onSubmit: login,
                  voidBtnBack: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}