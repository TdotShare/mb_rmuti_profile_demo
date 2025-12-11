import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
// ไม่จำเป็นต้องใช้ 'dart:convert' สำหรับ Uri.decodeComponent
// import 'dart:convert';

class AuthOauthPage extends StatefulWidget {
  const AuthOauthPage({super.key});

  // กำหนดผลลัพธ์ที่คาดหวัง: สามารถส่ง Map<String, String>? กลับไปได้
  @override
  State<AuthOauthPage> createState() => _AuthOauthPage();
}

class _AuthOauthPage extends State<AuthOauthPage> {
  late final WebViewController _controller;
  final String _oauthUrl =
      "https://mis.rmuti.ac.th/services-authen/auth?url=auth/tokenOauth&tag=rmuti_p_profile";

  bool _loading = true;

  @override
  void initState() {
    super.initState();

    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress: $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
            if (mounted) {
              setState(() {
                _loading = true;
              });
            }
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
            if (mounted) {
              setState(() {
                _loading = false;
              });
            }
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('Page resource error: ${error.description}');
            if (mounted) {
              setState(() {
                _loading = false;
              });
            }
          },

          onNavigationRequest: (NavigationRequest request) {
            debugPrint('Navigation requested to: ${request.url}');

            // 1. ตรวจสอบ URL เพื่อดักจับ Token/Code
            if (request.url.contains('auth/tokenOauth?')) {
              debugPrint('*** OAuth Code Found! ***');

              // 2. แยกวิเคราะห์ URI เพื่อดึง Query Parameters
              final uri = Uri.parse(request.url);

              // 3. ดึงค่า 'code' และ 'type'
              final code = uri.queryParameters['code'];
              final type = uri.queryParameters['type'];

              // 4. แสดงผลลัพธ์
              if (code != null && type != null) {
                // Uri.decodeComponent ใช้ได้โดยไม่ต้อง import 'dart:convert'
                final decodedCode = Uri.decodeComponent(code);
                final decodedType = Uri.decodeComponent(type);

                debugPrint('✅ Code: $decodedCode');
                debugPrint('✅ Type: $decodedType');

                // --- ส่วนที่ปรับปรุง: ปิด WebView และส่งค่ากลับ ---
                // ปิดหน้าจอ AuthOauthPage และส่ง Map ของ code กับ type กลับไป
                Navigator.pop(
                  context,
                  {
                    'code': decodedCode,
                    'type': decodedType,
                  },
                );
                // ---------------------------------------------------

                // เพื่อไม่ให้ WebView โหลดหน้านี้ต่อ (เพราะเราดึงค่าไปแล้ว)
                return NavigationDecision.prevent;
              }

              debugPrint('⚠️ Warning: Code or Type parameter is missing.');
            }

            // แสดง Loading ทุกครั้งที่มีการขอเปลี่ยนหน้า
            if (mounted && !_loading) {
              setState(() {
                _loading = true;
              });
            }

            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(_oauthUrl));

    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("RMUTI OAuth"),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          WebViewWidget(controller: _controller),
          if (_loading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}