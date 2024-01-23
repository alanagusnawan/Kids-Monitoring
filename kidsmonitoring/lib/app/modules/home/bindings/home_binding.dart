// Mengimpor pustaka GetX untuk manajemen state dan dependensi
import 'package:get/get.dart';

// Mengimpor controller dari modul home
import '../controllers/home_controller.dart';

// Kelas HomeBinding yang mengimplementasikan Bindings untuk mengatur dependensi controller
class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // Menggunakan Get.lazyPut untuk menyediakan HomeController secara lazy (dibuat hanya jika diperlukan)
    Get.lazyPut<HomeController>(
          () => HomeController(), // Fungsi anonim untuk membuat instance dari HomeController
    );
  }
}
