import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    print('SplashController initialized');
    _checkAuthStatus();
  }

  void _checkAuthStatus() async {
    print('Checking auth status...');
    await Future.delayed(const Duration(seconds: 2)); // Show splash for 2 seconds
    
    try {
      if (_auth.currentUser != null) {
        print('User is logged in, navigating to home');
        Get.offAllNamed('/home');
      } else {
        print('User is not logged in, navigating to login');
        Get.offAllNamed('/login');
      }
    } catch (e) {
      print('Error in auth check: $e');
      // Navigate to login on error
      Get.offAllNamed('/login');
    }
  }
}
