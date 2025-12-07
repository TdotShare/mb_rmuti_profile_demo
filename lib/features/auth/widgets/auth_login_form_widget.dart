import 'package:flutter/material.dart';

class AuthLoginFormWidget extends StatelessWidget {
  final void Function(String username, String password) onSubmit;
  final VoidCallback voidBtnBack;

  const AuthLoginFormWidget({
    super.key,
    required this.onSubmit,
    required this.voidBtnBack,
  });

  @override
  Widget build(BuildContext context) {
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 8),

            TextFormField(
              controller: usernameController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.account_circle),
                labelText: 'บัญชีอินเตอร์เน็ต',
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 12),

            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.lock),
                labelText: 'รหัสผ่าน',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                onSubmit(
                  usernameController.text.trim(),
                  passwordController.text.trim(),
                );
              },
              child: const Text('เข้าสู่ระบบ'),
            ),
            SizedBox(height: 12),
            OutlinedButton(
              onPressed: () => voidBtnBack(),
              child: const Text('ย้อนกลับ'),
            ),
          ],
        ),
      ),
    );
  }
}
