class LeaveRightModel {
  final int? leaveRightId;
  final int? leaveRightDayMax;
  final int? leaveRigthIsAccumulateDay;
  final int? leaveRigthAccumulateDay;
  final String? docCategoryName;
  final int? docCategoryId;
  final double? userLeaveSumDay;

  LeaveRightModel({
    this.leaveRightId,
    this.leaveRightDayMax,
    this.leaveRigthIsAccumulateDay,
    this.leaveRigthAccumulateDay,
    this.docCategoryName,
    this.docCategoryId,
    this.userLeaveSumDay,
  });

  factory LeaveRightModel.fromJson(Map<String, dynamic> json) {
    return LeaveRightModel(
      leaveRightId: json['leaveRightId'],
      leaveRightDayMax: json['leaveRightDayMax'],
      leaveRigthIsAccumulateDay: json['leaveRigthIsAccumulateDay'],
      leaveRigthAccumulateDay: json['leaveRigthAccumulateDay'],
      docCategoryName: json['docCategoryName'],
      docCategoryId: json['docCategoryId'],
      // จัดการกรณีค่าที่ได้มาเป็น int หรือ string ให้เป็น double
      userLeaveSumDay: double.tryParse(json['userLeaveSumDay'].toString()) ?? 0.0,
    );
  }
}