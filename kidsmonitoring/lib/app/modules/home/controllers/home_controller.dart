import 'package:get/get.dart';

class DailyLimit {
  RxString name;
  RxString day;
  RxInt hour;
  RxInt minute;
  RxBool switched;

  DailyLimit({required this.name, required this.day, required this.hour, required this.minute, required this.switched});
}

class SleepingTime {
  RxString name;
  RxString day;
  RxInt firsthour;
  RxInt firstminute;
  RxInt lasthour;
  RxInt lastminute;
  RxBool switched;

  SleepingTime({required this.name, required this.day, required this.firsthour, required this.firstminute, required this.lasthour, required this.lastminute, required this.switched});
}

class HomeController extends GetxController {
  //TODO: Implement HomeController

  RxBool isSwitchedDailyLimit = false.obs;
  RxBool isSwitchedSleepingTime = false.obs;

  List<DailyLimit> DailyLimitItems = [
    DailyLimit(name: "Sunday".obs, day: "Sun".obs, hour: 0.obs, minute: 0.obs, switched: false.obs),
    DailyLimit(name: "Monday".obs, day: "Mon".obs, hour: 0.obs, minute: 0.obs, switched: false.obs),
    DailyLimit(name: "Tuesday".obs, day: "Tue".obs, hour: 0.obs, minute: 0.obs, switched: false.obs),
    DailyLimit(name: "Wednesday".obs, day: "Wed".obs, hour: 0.obs, minute: 0.obs, switched: false.obs),
    DailyLimit(name: "Thursday".obs, day: "Thu".obs, hour: 0.obs, minute: 0.obs, switched: false.obs),
    DailyLimit(name: "Friday".obs, day: "Fri".obs, hour: 0.obs, minute: 0.obs, switched: false.obs),
    DailyLimit(name: "Saturday".obs, day: "Sat".obs, hour: 0.obs, minute: 0.obs, switched: false.obs),
  ];

  List<SleepingTime> SleepingTimeItems = [
    SleepingTime(name: "Sunday".obs, day: "Sun".obs, firsthour: 0.obs, firstminute: 0.obs, lasthour: 0.obs, lastminute: 0.obs, switched: false.obs),
    SleepingTime(name: "Monday".obs, day: "Mon".obs, firsthour: 0.obs, firstminute: 0.obs, lasthour: 0.obs, lastminute: 0.obs, switched: false.obs),
    SleepingTime(name: "Tuesday".obs, day: "Tue".obs, firsthour: 0.obs, firstminute: 0.obs, lasthour: 0.obs, lastminute: 0.obs, switched: false.obs),
    SleepingTime(name: "Wednesday".obs, day: "Wed".obs, firsthour: 0.obs, firstminute: 0.obs, lasthour: 0.obs, lastminute: 0.obs, switched: false.obs),
    SleepingTime(name: "Thursday".obs, day: "Thu".obs, firsthour: 0.obs, firstminute: 0.obs, lasthour: 0.obs, lastminute: 0.obs, switched: false.obs),
    SleepingTime(name: "Friday".obs, day: "Fri".obs, firsthour: 0.obs, firstminute: 0.obs, lasthour: 0.obs, lastminute: 0.obs, switched: false.obs),
    SleepingTime(name: "Saturday".obs, day: "Sat".obs, firsthour: 0.obs, firstminute: 0.obs, lasthour: 0.obs, lastminute: 0.obs, switched: false.obs),
  ];


  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
