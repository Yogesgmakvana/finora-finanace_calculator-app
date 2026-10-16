import 'package:get/get.dart';
import '../controllers/emi_calculator_controller.dart';

class EmiCalculatorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EmiCalculatorController>(() => EmiCalculatorController());
  }
}
