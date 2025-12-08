import 'package:flutter/material.dart';
import 'package:mb_rmuti_profile_demo/features/auth/widgets/auth_applogo_widget.dart';
import 'package:mb_rmuti_profile_demo/features/auth/widgets/auth_login_form_widget.dart';
import 'package:mb_rmuti_profile_demo/routes/app_router.dart';
import 'package:mb_rmuti_profile_demo/routes/auth_router.dart';

class AuthLoginOfficerPage extends StatefulWidget {
  const AuthLoginOfficerPage({super.key});

  @override
  _AuthLoginOfficerPageState createState() => _AuthLoginOfficerPageState();
}

class _AuthLoginOfficerPageState extends State<AuthLoginOfficerPage> {

  void login(String username, String password) {
    print("USERNAME: $username");
    print("PASSWORD: $password");

    AppRouter.push(context, AuthRoutes.home);
  }

  void btnBack() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView( // ⬅️ เพิ่ม SingleChildScrollView เพื่อรองรับหน้าจอขนาดเล็ก
        child: Column(
          children: [
            const SizedBox(height: 50), // ⬅️ ลดระยะห่างด้านบน
            const AuthAppLogoWidget(),
            AuthLoginFormWidget(
              onSubmit: (username, password) => login(username, password),
              voidBtnBack:  () => btnBack(),
            ),
            const SizedBox(height: 50), // เพิ่มระยะห่างด้านล่าง
          ],
        ),
      ),
    );
  }
}