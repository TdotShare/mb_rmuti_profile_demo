// --- 1. Model ตามโครงสร้าง data.json ---
class ActivityCategoryResult {
  final String categoryShotName;
  final String participateAll;
  final int eachAreaResults; // 1 = ผ่าน

  ActivityCategoryResult({
    required this.categoryShotName,
    required this.participateAll,
    required this.eachAreaResults,
  });
}

class ActivityType {
  final String freeTypeName;
  final String countActivity; // กิจกรรมที่เข้าร่วมแล้ว
  final String unitActivity; // หน่วยกิตที่ได้แล้ว
  final String rUnit; // ต้องการอีกกี่หน่วยกิต
  final String rAct; // ต้องเข้าอีกกี่กิจกรรม
  final int participationResult; // 1 = ผ่าน
  final List<ActivityCategoryResult>? summaryResults;

  ActivityType({
    required this.freeTypeName,
    required this.countActivity,
    required this.unitActivity,
    required this.rUnit,
    required this.rAct,
    required this.participationResult,
    this.summaryResults,
  });
}

// --- 2. ข้อมูล Mockup (ดึงจาก data.json ที่คุณให้มา) ---
final List<ActivityType> mockupActivityData = [
  ActivityType(
    freeTypeName: "กิจกรรมทั้งหมด",
    countActivity: "32",
    unitActivity: "114",
    rUnit: "100",
    rAct: "21",
    participationResult: 1,
  ),
  ActivityType(
    freeTypeName: "กิจกรรมบังคับ",
    countActivity: "6",
    unitActivity: "27",
    rUnit: "22",
    rAct: "6",
    participationResult: 1,
  ),
  ActivityType(
    freeTypeName: "กิจกรรมบังคับเลือก",
    countActivity: "5",
    unitActivity: "20",
    rUnit: "20",
    rAct: "5",
    participationResult: 1,
  ),
  ActivityType(
    freeTypeName: "กิจกรรมเลือกเสรี",
    countActivity: "21",
    unitActivity: "67",
    rUnit: "58",
    rAct: "2",
    participationResult: 1,
    summaryResults: [
      ActivityCategoryResult(
        categoryShotName: "PD",
        participateAll: "3",
        eachAreaResults: 1,
      ),
      ActivityCategoryResult(
        categoryShotName: "HD",
        participateAll: "5",
        eachAreaResults: 1,
      ),
      ActivityCategoryResult(
        categoryShotName: "AD",
        participateAll: "6",
        eachAreaResults: 1,
      ),
      ActivityCategoryResult(
        categoryShotName: "MD",
        participateAll: "5",
        eachAreaResults: 1,
      ),
      ActivityCategoryResult(
        categoryShotName: "CD",
        participateAll: "7",
        eachAreaResults: 1,
      ),
    ],
  ),
];
