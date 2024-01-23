// Mengimpor pustaka GetX untuk manajemen state dan navigasi
import 'package:get/get.dart';

// Mengimpor binding dan view dari modul home
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

// Mengimpor file yang berisi definisi rute aplikasi
part 'app_routes.dart';

// Kelas yang menyediakan konfigurasi halaman-halaman (routes) dalam aplikasi
class AppPages {
  AppPages._(); // Konstruktor yang di-private agar kelas ini tidak dapat diinstansiasi

  // Rute inisial aplikasi, akan langsung menuju halaman home
  static const INITIAL = Routes.HOME;

  // Daftar rute aplikasi beserta konfigurasinya
  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(), // Fungsi untuk membuat instance dari HomeView
      binding: HomeBinding(), // Fungsi untuk membuat instance dari HomeBinding dan mengaitkannya dengan halaman home
    ),
  ];
}
