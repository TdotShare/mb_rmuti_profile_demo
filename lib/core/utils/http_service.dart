import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart'; // สำหรับ Navigator/Context ในกรณีที่ต้อง redirect

// 📌 แทนที่ด้วยการตั้งค่าจริงของคุณ
class AppSettings {
  static const String apiUrl = "https://api.yourdomain.com/v1"; // สมมติ Base URL
  static const String loginPage = "/login"; // สมมติ path สำหรับหน้า Login
}

// ----------------------------------------------------
// 1. Dio Interceptor สำหรับจัดการ Header และ Error
// ----------------------------------------------------

class AuthInterceptor extends Interceptor {
  final Dio dio;
  final GlobalKey<NavigatorState> navigatorKey; // สำหรับการนำทางเมื่อ 401

  AuthInterceptor(this.dio, this.navigatorKey);

  // 1.1. Request Interceptor (เทียบเท่า instance.interceptors.request.use)
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // 💡 การจำลอง localStorage.getItem("token")
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString("token");
    final String? tokenRMUTI = prefs.getString("tokenRMUTI");

    if (token != null) {
      // 💡 การตั้งค่า Header
      options.headers['Authorization'] = 'Bearer $token';
      options.headers['X-Token-Rmuti'] = tokenRMUTI;
    }

    // สำคัญ: ต้องเรียก handler.next() เพื่อดำเนินการ Request ต่อไป
    return handler.next(options);
  }

  // 1.2. Response Interceptor (เทียบเท่า instance.interceptors.response.use)
  // เราจะใช้ onError เพื่อจัดการ Error ที่คล้ายกับ ExceptionalHandling ใน Axios
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final int? status = err.response?.statusCode;
    final dynamic responseData = err.response?.data;

    // 💡 ฟังก์ชันจำลอง Swal.fire ใน Flutter (อาจใช้ package เช่น flutter_local_notifications หรือ custom dialog)
    // ในตัวอย่างนี้จะแค่พิมพ์ออกมา
    void show(String title, String text) {
      print("ERROR $status: $title - $text");
      // ⚠️ ในการใช้งานจริง ควรแสดง Dialog/Snackbar ด้วย
    }

    switch (status) {
      case 400:
        show("Bad Request", responseData['message'] ?? "Invalid request or missing parameters.");
        break;
      case 401:
      // 💡 การจัดการ 401: ลบ Token และ Redirect ไปหน้า Login
        show("Unauthorized", "Session expired or invalid token.");
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove("token");
        await prefs.remove("tokenRMUTI");

        // ⚠️ การ Redirect ต้องอาศัย Context/NavigatorKey
        // ในตัวอย่างนี้ เราจะใช้ GlobalKey เพื่อ Navigate (ต้องตั้งค่าใน MaterialApp)
        navigatorKey.currentState?.pushNamedAndRemoveUntil(
            AppSettings.loginPage,
                (Route<dynamic> route) => false
        );

        break;
      case 403:
        show("Forbidden", "You do not have permission to access this resource.");
        break;
      case 404:
        show("Not Found", "The requested resource does not exist.");
        break;
      case 412:
        show("Precondition Failed", "Request conditions failed.");
        break;
      case 500:
        show("Server Error", "An internal error occurred on the server.");
        break;
      case 503:
        show("Service Unavailable", "Service temporarily unavailable.");
        break;
      default:
        show("Unknown Error", err.message ?? "An unexpected error occurred.");
    }

    // สำคัญ: ต้องเรียก handler.next() หรือ handler.reject()
    return handler.reject(err);
  }
}

// ----------------------------------------------------
// 2. Dio Client Singleton
// ----------------------------------------------------

class ApiClient {
  // 💡 สร้าง Dio instance เป็นแบบ private
  late Dio _dio;

  // 💡 GlobalKey สำหรับเข้าถึง NavigatorState (ต้องตั้งค่าใน MaterialApp)
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // 💡 Singleton Pattern: ใช้ _instance เพื่อให้มี Object เดียวเท่านั้น
  static final ApiClient _instance = ApiClient._internal();

  // Factory Constructor: เพื่อให้แน่ใจว่าเรียกใช้ _instance เสมอ
  factory ApiClient() {
    return _instance;
  }

  // Private Constructor: สำหรับตั้งค่า Dio
  ApiClient._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppSettings.apiUrl, // 💡 baseURL: AppSettings.apiUrl
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          'Content-Type': 'application/json', // 💡 headers: {'Content-Type': ...}
        },
      ),
    );

    // 💡 การเพิ่ม Interceptor (เทียบเท่า instance.interceptors.use)
    _dio.interceptors.add(AuthInterceptor(_dio, navigatorKey));
  }

  // 💡 Getter สำหรับให้ภายนอกเข้าถึง Dio instance
  Dio get instance => _dio;
}

// 💡 Export Instance (เทียบเท่า export default instance ใน TS)
final Dio apiClient = ApiClient().instance;