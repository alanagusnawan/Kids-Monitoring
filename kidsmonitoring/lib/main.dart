// Import paket dasar Flutter untuk pengembangan UI
import 'package:flutter/material.dart';

// Import paket GetX untuk manajemen state dan navigasi
import 'package:get/get.dart';

// Import file yang berisi definisi rute aplikasi
import 'app/routes/app_pages.dart';

// Fungsi utama yang dijalankan pertama kali saat aplikasi dimulai
void main() {
  // Menjalankan aplikasi menggunakan GetMaterialApp dari paket GetX
  runApp(
    GetMaterialApp(
      // Judul aplikasi
      title: "Kids Monitoring",
      // Rute awal yang akan ditampilkan saat aplikasi pertama kali dijalankan
      initialRoute: AppPages.INITIAL,
      // Daftar rute yang digunakan dalam aplikasi
      getPages: AppPages.routes,
    ),
  );
}
