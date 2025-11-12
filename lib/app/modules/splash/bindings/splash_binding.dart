import 'package:get/get.dart';
import '../controllers/splash_controller.dart';
import '../../../services/auth_service.dart';
import '../../../services/pdf_service.dart';
import '../../../services/storage_service.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    // Initialize global services
    Get.put<AuthService>(AuthService(), permanent: true);
    Get.put<PdfService>(PdfService(), permanent: true);
    Get.put<StorageService>(StorageService(), permanent: true);
    
    // Initialize splash controller
    Get.put(SplashController());
  }
}
