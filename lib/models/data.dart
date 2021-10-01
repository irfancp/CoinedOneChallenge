class Data {
  ChartData chartData;
  String freeTimeMaxUsage;
  DeviceUsage deviceUsage;

  Data({this.chartData, this.freeTimeMaxUsage, this.deviceUsage});

  Data.fromJson(Map<String, dynamic> json) {
    chartData = json['chartData'] != null
        ? new ChartData.fromJson(json['chartData'])
        : null;
    freeTimeMaxUsage = json['freeTimeMaxUsage'];
    deviceUsage = json['deviceUsage'] != null
        ? new DeviceUsage.fromJson(json['deviceUsage'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.chartData != null) {
      data['chartData'] = this.chartData.toJson();
    }
    data['freeTimeMaxUsage'] = this.freeTimeMaxUsage;
    if (this.deviceUsage != null) {
      data['deviceUsage'] = this.deviceUsage.toJson();
    }
    return data;
  }
}

class ChartData {
  TotalTime totalTime;
  TotalTime studyTime;
  TotalTime classTime;
  TotalTime freeTime;

  ChartData({this.totalTime, this.studyTime, this.classTime, this.freeTime});

  ChartData.fromJson(Map<String, dynamic> json) {
    totalTime = json['totalTime'] != null
        ? new TotalTime.fromJson(json['totalTime'])
        : null;
    studyTime = json['studyTime'] != null
        ? new TotalTime.fromJson(json['studyTime'])
        : null;
    classTime = json['classTime'] != null
        ? new TotalTime.fromJson(json['classTime'])
        : null;
    freeTime = json['freeTime'] != null
        ? new TotalTime.fromJson(json['freeTime'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.totalTime != null) {
      data['totalTime'] = this.totalTime.toJson();
    }
    if (this.studyTime != null) {
      data['studyTime'] = this.studyTime.toJson();
    }
    if (this.classTime != null) {
      data['classTime'] = this.classTime.toJson();
    }
    if (this.freeTime != null) {
      data['freeTime'] = this.freeTime.toJson();
    }
    return data;
  }
}

class TotalTime {
  String total;

  TotalTime({this.total});

  TotalTime.fromJson(Map<String, dynamic> json) {
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    return data;
  }
}


class DeviceUsage {
  Total_Time totalTime;
  Total_Time studyTime;
  Total_Time classTime;
  Total_Time freeTime;

  DeviceUsage({this.totalTime, this.studyTime, this.classTime, this.freeTime});

  DeviceUsage.fromJson(Map<String, dynamic> json) {
    totalTime = json['totalTime'] != null
        ? new Total_Time.fromJson(json['totalTime'])
        : null;
    studyTime = json['studyTime'] != null
        ? new Total_Time.fromJson(json['studyTime'])
        : null;
    classTime = json['classTime'] != null
        ? new Total_Time.fromJson(json['classTime'])
        : null;
    freeTime = json['freeTime'] != null
        ? new Total_Time.fromJson(json['freeTime'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.totalTime != null) {
      data['totalTime'] = this.totalTime.toJson();
    }
    if (this.studyTime != null) {
      data['studyTime'] = this.studyTime.toJson();
    }
    if (this.classTime != null) {
      data['classTime'] = this.classTime.toJson();
    }
    if (this.freeTime != null) {
      data['freeTime'] = this.freeTime.toJson();
    }
    return data;
  }
}
class Total_Time {
  String mobile;
  String laptop;

  Total_Time({this.mobile, this.laptop});

  Total_Time.fromJson(Map<String, dynamic> json) {
    mobile = json['mobile'];
    laptop = json['laptop'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobile'] = this.mobile;
    data['laptop'] = this.laptop;
    return data;
  }
}
