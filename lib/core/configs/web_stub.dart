// web_stub.dart
// ไฟล์นี้สร้างไว้หลอกๆ เพื่อให้ฝั่งมือถือไม่พัง
class Window {
  Location get location => Location();
}
class Location {
  String get href => '';
  set href(String val) {}
  String get origin => '';
}
final window = Window();