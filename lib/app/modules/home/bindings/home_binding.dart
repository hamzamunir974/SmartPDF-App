import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../../../services/storage_service.dart';
import '../../../services/pdf_service.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // Ensure services are available
    if (!Get.isRegistered<StorageService>()) {
      Get.put<StorageService>(StorageService(), permanent: true);
    }
    if (!Get.isRegistered<PdfService>()) {
      Get.put<PdfService>(PdfService(), permanent: true);
    }
    
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
