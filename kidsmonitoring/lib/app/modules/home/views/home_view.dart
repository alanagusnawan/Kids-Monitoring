import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // Kode ini digunakan untuk menampilkan Tab Bar Daily Limit dan Sleeping Time
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          // Menentukan tinggi toolbar AppBar
          toolbarHeight: 75,
          // Menentukan warna latar belakang AppBar
          backgroundColor: Colors.white,
          // Mengatur latar belakang AppBar menggunakan gradient
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                // Menentukan pemberhentian gradient
                stops: [0.5, 1],
                // Menentukan titik awal dan akhir gradient
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                // Menentukan warna gradient
                colors: <Color>[Colors.white, Color(0xffEDA7AB)],
              ),
            ),
          ),
          // Icon dan aksi di sebelah kiri AppBar
          leading: GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.arrow_back,
              color: Colors.pink,
            ),
          ),
          // Tombol "Save" di sebelah kanan AppBar
          actions: [
            Container(
              margin: EdgeInsets.only(right: 20),
              // Menentukan margin, padding, dan dekorasi tombol "Save"
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.pink.shade50,
              ),
              child: Text("Save", style: TextStyle(color: Colors.pink)),
            )
          ],
          // TabBar untuk Daily Limit dan Sleeping Time
          bottom: TabBar(
            // Menentukan warna label yang dipilih dan tidak dipilih
            labelColor: const Color(0xff525c6e),
            unselectedLabelColor: const Color(0xffacb3bf),
            // Menentukan padding dan berat indikator
            indicatorPadding: EdgeInsets.all(0.0),
            indicatorWeight: 4.0,
            labelPadding: EdgeInsets.only(left: 0.0, right: 0.0),
            // Mengatur dekorasi indikator dengan gradient
            indicator: ShapeDecoration(
              shape: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 0,
                  style: BorderStyle.solid,
                ),
              ),
              gradient: LinearGradient(colors: [Colors.pink, Colors.pinkAccent]),
            ),
            // Menentukan tab-tab dalam TabBar
            tabs: <Widget>[
              // Tab pertama untuk Daily Limit
              Container(
                height: 50,
                alignment: Alignment.center,
                color: Colors.white,
                child: Column(
                  children: [
                    // Menampilkan ikon jam pada tab
                    Icon(Icons.timer_rounded, color: Colors.pink),
                    // Menampilkan teks "Daily limit" pada tab
                    Text(
                      "Daily limit",
                      style: TextStyle(color: Colors.pink),
                    ),
                  ],
                ),
              ),
              // Tab kedua untuk Sleeping Time
              Container(
                height: 50,
                alignment: Alignment.center,
                color: Colors.white,
                child: Column(
                  children: [
                    // Menampilkan ikon tempat tidur pada tab
                    Icon(Icons.nights_stay, color: Colors.pink),
                    // Menampilkan teks "Sleeping time" pada tab
                    Text(
                      "Sleeping time",
                      style: TextStyle(color: Colors.pink),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Isi dari masing-masing tab
        body: TabBarView(
          children: [
            // Tab pertama untuk Daily Limit
            Obx(() => Column(
              children: [
                // Container untuk mengaktifkan dan menonaktifkan secara massal
                Container(
                  color: Color(0xffFEF3F1),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Menampilkan teks "Not Scheduled" atau "Scheduled" tergantung nilai isSwitchedDailyLimit
                      Text(
                        controller.isSwitchedDailyLimit.value == false
                            ? "Not Scheduled"
                            : "Scheduled",
                        style: TextStyle(color: Colors.pink),
                      ),
                      // Mengaktifkan atau menonaktifkan isSwitchedDailyLimit
                      Switch(
                        activeColor: Colors.pink,
                        value: controller.isSwitchedDailyLimit.value,
                        onChanged: (value) {
                          // Mengubah nilai isSwitchedDailyLimit
                          controller.isSwitchedDailyLimit.value = value;
                          // Mengubah nilai switched untuk setiap item dalam DailyLimitItems
                          for (var switched in controller.DailyLimitItems) {
                            switched.switched.value = value;
                          }
                        },
                      ),
                    ],
                  ),
                ),
                // Container untuk mengaktifkan perhari
                SingleChildScrollView(
                  child: Container(
                    height: 400,
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: ListView.builder(
                      itemCount: controller.DailyLimitItems.length,
                      itemBuilder: (context, index) {
                        // Mengambil data batasan waktu harian
                        final timeItem = controller.DailyLimitItems[index];
                        return ExpansionTile(
                          shape: Border.all(color: Colors.transparent),
                          trailing: Obx(() => Switch(
                            activeColor: Colors.pink,
                            value: timeItem.switched.value,
                            onChanged: (value) {
                              // Mengubah nilai switched untuk batasan waktu saat ini
                              timeItem.switched.value = value;
                              // Jika batasan waktu diaktifkan, mengubah nilai isSwitchedDailyLimit
                              if (timeItem.switched.value == true) {
                                controller.isSwitchedDailyLimit.value = true;
                              }
                            },
                          )),
                          title: Obx(() => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              // Menampilkan nama hari
                              Text(
                                timeItem.day.value,
                                style: TextStyle(color: Colors.pink),
                              ),
                              Container(
                                width: 150,
                                child: Text(
                                  // Menampilkan jam batasan waktu atau pesan jika tidak ada batasan waktu
                                  timeItem.switched.value
                                      ? "${timeItem.hour} O`clock"
                                      : "There are no limits",
                                  style: TextStyle(color: Colors.pink),
                                ),
                              ),
                            ],
                          )),
                          children: <Widget>[
                            // Widget lainnya di dalam ExpansionTile
                            Builder(builder: (BuildContext context) {
                              return ListTile(
                                // Menampilkan nama batasan waktu
                                title: Text(
                                  timeItem.name.value,
                                  style: TextStyle(color: Colors.pink),
                                ),
                                // Tombol untuk menyembunyikan ExpansionTile
                                trailing: InkWell(
                                  onTap: () {
                                    ExpansionTileController.of(context).collapse();
                                  },
                                  child: Icon(Icons.arrow_upward, color: Colors.pink),
                                ),
                              );
                            }),
                            // Menampilkan jumlah jam dan menit serta menyediakan input untuk mengubahnya
                            Obx(() => ListTile(
                              title: Text(
                                "${timeItem.hour} hours ${timeItem.minute} minutes",
                                style: TextStyle(color: Colors.pink),
                              ),
                              trailing: InkWell(
                                onTap: () async {
                                  if (timeItem.switched.value == true) {
                                    // Menampilkan dialog pemilih waktu
                                    var time = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay(hour: 0, minute: 0),
                                      builder: (BuildContext context, Widget? child) {
                                        return MediaQuery(
                                          data: MediaQuery.of(context).copyWith(
                                            alwaysUse24HourFormat: true,
                                          ),
                                          child: child!,
                                        );
                                      },
                                    );
                                    // Jika waktu dipilih, mengubah jam dan menit batasan waktu
                                    if (time != null) {
                                      timeItem.hour.value = time.hour;
                                      timeItem.minute.value = time.minute;
                                    }
                                  }
                                },
                                child: Container(
                                  width: 60,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(Icons.add, color: Colors.pink),
                                      Icon(Icons.remove, color: Colors.pink),
                                    ],
                                  ),
                                ),
                              ),
                            )),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                // Divider untuk memisahkan bagian-bagian dalam tab
                Divider(
                  height: 10,
                  thickness: 1,
                  indent: 0,
                  endIndent: 0,
                  color: Colors.pink,
                ),
                // Container untuk keterangan tambahan
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    // Menampilkan informasi tambahan
                    "Supervised Android phones and tablets as well as Chromebooks will lock when time is up.\nRahayu can still call you if necessary",
                    style: TextStyle(color: Colors.pink),
                  ),
                )
              ],
            )),
            // Tab kedua untuk Sleeping Time
            Obx(() => Column(
              children: [
                // Container untuk mengaktifkan dan menonaktifkan secara massal
                Container(
                  color: Color(0xffFEF3F1),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Menampilkan teks "Not Scheduled" atau "Scheduled" tergantung nilai isSwitchedSleepingTime
                      Text(
                        controller.isSwitchedSleepingTime.value == false
                            ? "Not Scheduled"
                            : "Scheduled",
                        style: TextStyle(color: Colors.pink),
                      ),
                      // Mengaktifkan atau menonaktifkan isSwitchedSleepingTime
                      Switch(
                        activeColor: Colors.pink,
                        value: controller.isSwitchedSleepingTime.value,
                        onChanged: (value) {
                          // Mengubah nilai isSwitchedSleepingTime
                          controller.isSwitchedSleepingTime.value = value;
                          // Mengubah nilai switched untuk setiap item dalam SleepingTimeItems
                          for (var switched in controller.SleepingTimeItems) {
                            switched.switched.value = value;
                          }
                        },
                      ),
                    ],
                  ),
                ),
                // Container untuk mengaktifkan perhari
                SingleChildScrollView(
                  child: Container(
                    height: 400,
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: ListView.builder(
                      itemCount: controller.SleepingTimeItems.length,
                      itemBuilder: (context, index) {
                        // Mengambil data waktu tidur untuk satu hari
                        final timeItem = controller.SleepingTimeItems[index];
                        return ExpansionTile(
                          shape: Border.all(color: Colors.transparent),
                          trailing: Obx(() => Switch(
                            activeColor: Colors.pink,
                            value: timeItem.switched.value,
                            onChanged: (value) {
                              // Mengubah nilai switched untuk waktu tidur saat ini
                              timeItem.switched.value = value;
                              // Jika waktu tidur diaktifkan, mengubah nilai isSwitchedSleepingTime
                              if (timeItem.switched.value == true) {
                                controller.isSwitchedSleepingTime.value = true;
                              }
                            },
                          )),
                          title: Obx(() => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              // Menampilkan nama hari
                              Text(
                                timeItem.day.value,
                                style: TextStyle(color: Colors.pink),
                              ),
                              Container(
                                width: 150,
                                child: Text(
                                  // Menampilkan rentang waktu tidur atau pesan jika tidak ada batasan waktu
                                  timeItem.switched.value
                                      ? "${timeItem.firsthour}.${timeItem.firstminute} - ${timeItem.lasthour}.${timeItem.lastminute}"
                                      : "There are no limits",
                                  style: TextStyle(color: Colors.pink),
                                ),
                              ),
                            ],
                          )),
                          children: <Widget>[
                            // Widget lainnya di dalam ExpansionTile
                            Builder(builder: (BuildContext context) {
                              return ListTile(
                                // Menampilkan nama waktu tidur
                                title: Text(
                                  timeItem.name.value,
                                  style: TextStyle(color: Colors.pink),
                                ),
                                // Tombol untuk menyembunyikan ExpansionTile
                                trailing: InkWell(
                                  onTap: () {
                                    ExpansionTileController.of(context).collapse();
                                  },
                                  child: Icon(Icons.arrow_upward, color: Colors.pink),
                                ),
                              );
                            }),
                            // Menampilkan jam tidur dan menit serta menyediakan input untuk mengubahnya
                            Obx(() => InkWell(
                              onTap: () async {
                                if (timeItem.switched.value == true) {
                                  // Menampilkan dialog pemilih waktu
                                  var time = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay(hour: 0, minute: 0),
                                    builder: (BuildContext context, Widget? child) {
                                      return MediaQuery(
                                        data: MediaQuery.of(context).copyWith(
                                          alwaysUse24HourFormat: true,
                                        ),
                                        child: child!,
                                      );
                                    },
                                  );
                                  // Jika waktu dipilih, mengubah jam dan menit waktu tidur
                                  if (time != null) {
                                    timeItem.firsthour.value = time.hour;
                                    timeItem.firstminute.value = time.minute;
                                  }
                                }
                              },
                              child: ListTile(
                                leading: Icon(Icons.lock, color: Colors.pink),
                                // Menampilkan teks "Lock"
                                title: Text(
                                  "Lock",
                                  style: TextStyle(color: Colors.pink),
                                ),
                                // Menampilkan waktu tidur terkini
                                trailing: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.pink.shade50,
                                  ),
                                  child: Text(
                                      "${timeItem.firsthour.value}.${timeItem.firstminute.value}",
                                      style: TextStyle(color: Colors.pink)),
                                ),
                              ),
                            )),
                            // Menampilkan jam dan menit waktu terakhir yang bisa dibuka
                            Obx(() => InkWell(
                              onTap: () async {
                                if (timeItem.switched.value == true) {
                                  // Menampilkan dialog pemilih waktu
                                  var time = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay(hour: 0, minute: 0),
                                    builder: (BuildContext context, Widget? child) {
                                      return MediaQuery(
                                        data: MediaQuery.of(context).copyWith(
                                          alwaysUse24HourFormat: true,
                                        ),
                                        child: child!,
                                      );
                                    },
                                  );
                                  // Jika waktu dipilih, mengubah jam dan menit waktu terakhir yang bisa dibuka
                                  if (time != null) {
                                    timeItem.lasthour.value = time.hour;
                                    timeItem.lastminute.value = time.minute;
                                  }
                                }
                              },
                              child: ListTile(
                                leading: Icon(Icons.lock_open, color: Colors.pink),
                                // Menampilkan teks "Unlock"
                                title: Text(
                                  "Unlock",
                                  style: TextStyle(color: Colors.pink),
                                ),
                                // Menampilkan waktu terakhir yang bisa dibuka
                                trailing: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.pink.shade50,
                                  ),
                                  child: Text(
                                      "${timeItem.lasthour.value}.${timeItem.lastminute.value}",
                                      style: TextStyle(color: Colors.pink)),
                                ),
                              ),
                            )),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                // Divider untuk memisahkan bagian-bagian dalam tab
                Divider(
                  height: 10,
                  thickness: 1,
                  indent: 0,
                  endIndent: 0,
                  color: Colors.pink,
                ),
                // Container untuk keterangan tambahan
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    // Menampilkan informasi tambahan
                    "Supervised Android phones and tablets as well as Chromebooks will lock when time is up.\nRahayu can still call you if necessary",
                    style: TextStyle(color: Colors.pink),
                  ),
                )
              ],
            )),
          ],
        ),
      ),
    );
  }
}