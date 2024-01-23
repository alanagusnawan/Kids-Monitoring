// Import paket GetX untuk manajemen state dan navigasi
import 'package:get/get.dart';

// Kelas model untuk batas harian (DailyLimit)
class DailyLimit {
  RxString name;    // Nama harian (contoh: "Sunday")
  RxString day;     // Singkatan harian (contoh: "Sun")
  RxInt hour;       // Jam batas harian
  RxInt minute;     // Menit batas harian
  RxBool switched;  // Status switch untuk mengaktifkan atau menonaktifkan batas harian

  // Konstruktor untuk membuat objek DailyLimit
  DailyLimit({
    required this.name,
    required this.day,
    required this.hour,
    required this.minute,
    required this.switched,
  });
}

// Kelas model untuk waktu tidur (SleepingTime)
class SleepingTime {
  RxString name;         // Nama harian (contoh: "Sunday")
  RxString day;          // Singkatan harian (contoh: "Sun")
  RxInt firsthour;       // Jam tidur awal
  RxInt firstminute;     // Menit tidur awal
  RxInt lasthour;        // Jam bangun
  RxInt lastminute;      // Menit bangun
  RxBool switched;       // Status switch untuk mengaktifkan atau menonaktifkan waktu tidur

  // Konstruktor untuk membuat objek SleepingTime
  SleepingTime({
    required this.name,
    required this.day,
    required this.firsthour,
    required this.firstminute,
    required this.lasthour,
    required this.lastminute,
    required this.switched,
  });
}

// Kelas controller untuk manajemen state dan logika aplikasi
class HomeController extends GetxController {
  // State untuk mengaktifkan/menonaktifkan batas harian
  RxBool isSwitchedDailyLimit = false.obs;
  // State untuk mengaktifkan/menonaktifkan waktu tidur
  RxBool isSwitchedSleepingTime = false.obs;

  // List untuk menyimpan batas harian pada setiap hari
  List<DailyLimit> DailyLimitItems = [
    DailyLimit(name: "Sunday".obs, day: "Sun".obs, hour: 0.obs, minute: 0.obs, switched: false.obs),
    DailyLimit(name: "Monday".obs, day: "Mon".obs, hour: 0.obs, minute: 0.obs, switched: false.obs),
    DailyLimit(name: "Tuesday".obs, day: "Tue".obs, hour: 0.obs, minute: 0.obs, switched: false.obs),
    DailyLimit(name: "Wednesday".obs, day: "Wed".obs, hour: 0.obs, minute: 0.obs, switched: false.obs),
    DailyLimit(name: "Thursday".obs, day: "Thu".obs, hour: 0.obs, minute: 0.obs, switched: false.obs),
    DailyLimit(name: "Friday".obs, day: "Fri".obs, hour: 0.obs, minute: 0.obs, switched: false.obs),
    DailyLimit(name: "Saturday".obs, day: "Sat".obs, hour: 0.obs, minute: 0.obs, switched: false.obs),
  ];

  // List untuk menyimpan waktu tidur pada setiap hari
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
