import 'package:get/get.dart';
import '../controllers/conversion_controller.dart';

class ConversionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConversionController>(
      () => ConversionController(),
    );
  }
}
