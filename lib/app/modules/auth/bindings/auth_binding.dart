import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../../../services/auth_service.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    // Ensure AuthService is available
    if (!Get.isRegistered<AuthService>()) {
      Get.put<AuthService>(AuthService(), permanent: true);
    }
    
    Get.put<AuthController>(
      AuthController(),
      permanent: true,
    );
  }
}
