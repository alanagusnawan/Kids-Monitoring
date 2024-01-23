import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //Ini Kode Untuk Tab Bar Daily Limit dan Sleeping Time
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 75,
            backgroundColor: Colors.white,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      stops: [0.5, 1],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: <Color>[Colors.white, Color(0xffEDA7AB)])),
            ),
            leading: GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.arrow_back,
                color: Colors.pink,
              ),
            ),
            actions: [
              Container(
                margin: EdgeInsets.only(right: 20),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.pink.shade50,
                ),
                child: Text("Save", style: TextStyle(color: Colors.pink)),
              )
            ],
            bottom: TabBar(
              labelColor: const Color(0xff525c6e),
              unselectedLabelColor: const Color(0xffacb3bf),
              indicatorPadding: EdgeInsets.all(0.0),
              indicatorWeight: 4.0,
              labelPadding: EdgeInsets.only(left: 0.0, right: 0.0),
              indicator: ShapeDecoration(
                  shape: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 0,
                          style: BorderStyle.solid)),
                  gradient:
                      LinearGradient(colors: [Colors.pink, Colors.pinkAccent])),
              tabs: <Widget>[
                Container(
                  height: 50,
                  alignment: Alignment.center,
                  color: Colors.white,
                  child: Column(
                    children: [
                      Icon(Icons.timer_rounded, color: Colors.pink),
                      Text(
                        "Daily limit",
                        style: TextStyle(color: Colors.pink),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  alignment: Alignment.center,
                  color: Colors.white,
                  child: Column(
                    children: [
                      Icon(Icons.nights_stay, color: Colors.pink),
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
          body: TabBarView(children: [
            Obx(() => Column(
                  children: [
                    //Ini Fungsi untuk Mengaktifkan dan Menonaktifkan Secara Massal
                    Container(
                      color: Color(0xffFEF3F1),
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            controller.isSwitchedDailyLimit.value == false
                                ? "Not Scheduled"
                                : "Scheduled",
                            style: TextStyle(color: Colors.pink),
                          ),
                          Switch(
                              activeColor: Colors.pink,
                              value: controller.isSwitchedDailyLimit.value,
                              onChanged: (value) {
                                controller.isSwitchedDailyLimit.value = value;
                                for (var switched
                                    in controller.DailyLimitItems) {
                                  switched.switched.value = value;
                                }
                              })
                        ],
                      ),
                    ),
                    //Ini Fungsi Untuk Mengaktifkan Perhari
                    SingleChildScrollView(
                      child: Container(
                        height: 400,
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: ListView.builder(
                          itemCount: controller.DailyLimitItems.length,
                          itemBuilder: (context, index) {
                            final timeItem = controller.DailyLimitItems[index];
                            return ExpansionTile(
                              shape: Border.all(color: Colors.transparent),
                              trailing: Obx(() => Switch(
                                  activeColor: Colors.pink,
                                  value: timeItem.switched.value,
                                  onChanged: (value) {
                                    timeItem.switched.value = value;
                                    if (timeItem.switched.value == true) {
                                      controller.isSwitchedDailyLimit.value =
                                          true;
                                    }
                                  })),
                              title: Obx(() => Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        timeItem.day.value,
                                        style: TextStyle(color: Colors.pink),
                                      ),
                                      Container(
                                        width: 150,
                                        child: Text(
                                          timeItem.switched.value
                                              ? "${timeItem.hour} O`clock"
                                              : "The are no limits",
                                          style: TextStyle(color: Colors.pink),
                                        ),
                                      ),
                                    ],
                                  )),
                              children: <Widget>[
                                Builder(builder: (BuildContext context) {
                                  return ListTile(
                                      title: Text(
                                        timeItem.name.value,
                                        style: TextStyle(color: Colors.pink),
                                      ),
                                      trailing: InkWell(
                                        onTap: () {
                                          ExpansionTileController.of(context)
                                              .collapse();
                                        },
                                        child: Icon(Icons.arrow_upward,
                                            color: Colors.pink),
                                      ));
                                }),
                                Obx(() => ListTile(
                                      title: Text(
                                        "${timeItem.hour} hours ${timeItem.minute} minutes",
                                        style: TextStyle(color: Colors.pink),
                                      ),
                                      trailing: InkWell(
                                        onTap: () async {
                                          if (timeItem.switched.value == true) {
                                            var time = await showTimePicker(
                                              context: context,
                                              initialTime:
                                                  TimeOfDay(hour: 0, minute: 0),
                                              builder: (BuildContext context,
                                                  Widget? child) {
                                                return MediaQuery(
                                                  data: MediaQuery.of(context)
                                                      .copyWith(
                                                          alwaysUse24HourFormat:
                                                              true),
                                                  child: child!,
                                                );
                                              },
                                            );
                                            if (time != null) {
                                              timeItem.hour.value = time.hour;
                                              timeItem.minute.value =
                                                  time.minute;
                                            }
                                          }
                                        },
                                        child: Container(
                                          width: 60,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Icon(Icons.add,
                                                  color: Colors.pink),
                                              Icon(Icons.remove,
                                                  color: Colors.pink),
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
                    Divider(
                      height: 10,
                      thickness: 1,
                      indent: 0,
                      endIndent: 0,
                      color: Colors.pink,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "supervised android phones and tablets as well as chromebooks will lock when time is up.\nRahayu can still call you if necessary",
                        style: TextStyle(color: Colors.pink),
                      ),
                    )
                  ],
                )),
            Obx(() => Column(
                  children: [
                    Container(
                      color: Color(0xffFEF3F1),
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            controller.isSwitchedSleepingTime.value == false
                                ? "Not Scheduled"
                                : "Scheduled",
                            style: TextStyle(color: Colors.pink),
                          ),
                          Switch(
                              activeColor: Colors.pink,
                              value: controller.isSwitchedSleepingTime.value,
                              onChanged: (value) {
                                controller.isSwitchedSleepingTime.value = value;
                                for (var switched
                                    in controller.SleepingTimeItems) {
                                  switched.switched.value = value;
                                }
                              })
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Container(
                        height: 400,
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: ListView.builder(
                          itemCount: controller.SleepingTimeItems.length,
                          itemBuilder: (context, index) {
                            final timeItem =
                                controller.SleepingTimeItems[index];
                            return ExpansionTile(
                              shape: Border.all(color: Colors.transparent),
                              trailing: Obx(() => Switch(
                                  activeColor: Colors.pink,
                                  value: timeItem.switched.value,
                                  onChanged: (value) {
                                    timeItem.switched.value = value;
                                    if (timeItem.switched.value == true) {
                                      controller.isSwitchedSleepingTime.value =
                                          true;
                                    }
                                  })),
                              title: Obx(() => Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        timeItem.day.value,
                                        style: TextStyle(color: Colors.pink),
                                      ),
                                      Container(
                                        width: 150,
                                        child: Text(
                                          timeItem.switched.value
                                              ? "${timeItem.firsthour}.${timeItem.firstminute} - ${timeItem.lasthour}.${timeItem.lastminute}"
                                              : "The are no limits",
                                          style: TextStyle(color: Colors.pink),
                                        ),
                                      ),
                                    ],
                                  )),
                              children: <Widget>[
                                Builder(builder: (BuildContext context) {
                                  return ListTile(
                                      title: Text(
                                        timeItem.name.value,
                                        style: TextStyle(color: Colors.pink),
                                      ),
                                      trailing: InkWell(
                                        onTap: () {
                                          ExpansionTileController.of(context)
                                              .collapse();
                                        },
                                        child: Icon(Icons.arrow_upward,
                                            color: Colors.pink),
                                      ));
                                }),
                                Obx(() => InkWell(
                                      onTap: () async {
                                        if (timeItem.switched.value == true) {
                                          var time = await showTimePicker(
                                            context: context,
                                            initialTime:
                                                TimeOfDay(hour: 0, minute: 0),
                                            builder: (BuildContext context,
                                                Widget? child) {
                                              return MediaQuery(
                                                data: MediaQuery.of(context)
                                                    .copyWith(
                                                        alwaysUse24HourFormat:
                                                            true),
                                                child: child!,
                                              );
                                            },
                                          );
                                          if (time != null) {
                                            timeItem.firsthour.value =
                                                time.hour;
                                            timeItem.firstminute.value =
                                                time.minute;
                                          }
                                        }
                                      },
                                      child: ListTile(
                                        leading: Icon(Icons.lock,
                                            color: Colors.pink),
                                        title: Text(
                                          "Lock",
                                          style: TextStyle(color: Colors.pink),
                                        ),
                                        trailing: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 10),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.pink.shade50,
                                          ),
                                          child: Text(
                                              "${timeItem.firsthour.value}.${timeItem.firstminute.value}",
                                              style: TextStyle(
                                                  color: Colors.pink)),
                                        ),
                                      ),
                                    )),
                                Obx(() => InkWell(
                                      onTap: () async {
                                        if (timeItem.switched.value == true) {
                                          var time = await showTimePicker(
                                            context: context,
                                            initialTime:
                                                TimeOfDay(hour: 0, minute: 0),
                                            builder: (BuildContext context,
                                                Widget? child) {
                                              return MediaQuery(
                                                data: MediaQuery.of(context)
                                                    .copyWith(
                                                        alwaysUse24HourFormat:
                                                            true),
                                                child: child!,
                                              );
                                            },
                                          );
                                          if (time != null) {
                                            timeItem.lasthour.value = time.hour;
                                            timeItem.lastminute.value =
                                                time.minute;
                                          }
                                        }
                                      },
                                      child: ListTile(
                                        leading: Icon(Icons.lock_open,
                                            color: Colors.pink),
                                        title: Text(
                                          "Unlock",
                                          style: TextStyle(color: Colors.pink),
                                        ),
                                        trailing: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 10),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.pink.shade50,
                                          ),
                                          child: Text(
                                              "${timeItem.lasthour.value}.${timeItem.lastminute.value}",
                                              style: TextStyle(
                                                  color: Colors.pink)),
                                        ),
                                      ),
                                    )),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    Divider(
                      height: 10,
                      thickness: 1,
                      indent: 0,
                      endIndent: 0,
                      color: Colors.pink,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "supervised android phones and tablets as well as chromebooks will lock when time is up.\nRahayu can still call you if necessary",
                        style: TextStyle(color: Colors.pink),
                      ),
                    )
                  ],
                )),
          ]),
        ));
  }
}
